import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

/**
 * MasonryView
 *
 * A virtualized, Pinterest-style masonry layout component.
 * Drop-in replacement wherever you'd use a ListView, but for
 * multi-column, variable-height tiles.
 *
 * Required properties
 * ───────────────────
 *   model            : var        – Flat JS array of model objects.
 *   delegate         : Component  – Item rendered per tile.
 *                                   Receives `modelData` (the raw model item)
 *                                   and `modelIndex` (its original flat index)
 *                                   as context properties — same convention as
 *                                   ListView delegates.
 *
 * Optional properties
 * ───────────────────
 *   aspectRatioOf    : function   – Called as aspectRatioOf(item) for each model
 *                                   item to determine tile height.  Return a
 *                                   positive number (width ÷ height).  Defaults
 *                                   to reading item.width / item.height, falling
 *                                   back to 1.5 when those fields are absent.
 *   columnWidth      : real       – Ideal column width in px       (default: 240)
 *   minColumns       : int        – Minimum number of columns       (default: 2)
 *   spacing          : real       – Gap between tiles and columns
 *                                   (default: Kirigami.Units.smallSpacing)
 *   scrollBarPolicy  : enumeration – Controls.ScrollBar policy      (default: AsNeeded)
 *
 * Signals
 * ───────
 *   tileClicked(index: int, modelData: var)
 *       Emitted when the user taps a tile.  `index` is the item's position in
 *       the original flat model array.
 *
 * Example
 * ───────
 *   MasonryView {
 *       anchors.fill: parent
 *       model: root.imagesList
 *       columnWidth: 280
 *
 *       // Tell the layout how to derive aspect ratio from your model objects.
 *       aspectRatioOf: (item) => (item.width > 0 && item.height > 0)
 *                                ? item.width / item.height
 *                                : 1.5
 *
 *       delegate: ImageCard {
 *           // modelData and modelIndex are injected automatically.
 *           imageUrl: modelData.url
 *       }
 *
 *       onTileClicked: (index, data) => console.log("tapped", index, data.url)
 *   }
 */
Item {
    id: root

    // ── Public API ─────────────────────────────────────────────────────────
    required property var       model
    required property Component delegate

    property var  aspectRatioOf:   function(item) {
        return (item && item.width > 0 && item.height > 0)
               ? item.width / item.height
               : 1.5
    }
    property real columnWidth:     240
    property int  minColumns:      2
    property real spacing:         Kirigami.Units.smallSpacing
    property int  scrollBarPolicy: Controls.ScrollBar.AsNeeded

    signal tileClicked(index: int, modelData: var)

    // ── Internal layout engine ─────────────────────────────────────────────
    readonly property int _numColumns: Math.max(minColumns, Math.floor(width / columnWidth))

    /*
     * _masonryData : { columns: Array<Array<{ modelData, computedHeight, sourceIndex }>>,
     *                  totalHeight: real }
     *
     * Recomputes whenever model, width, or column count changes.
     * Heights are pre-calculated here so ListView delegates are pure renderers
     * with no layout logic of their own.
     */
    readonly property var _masonryData: {
        if (root.width <= 0 || !root.model || root.model.length === 0)
            return { columns: [], totalHeight: 0 }

        var cols    = root._numColumns
        var g       = root.spacing
        var colW    = (root.width - g * (cols - 1)) / cols
        var colH    = new Array(cols).fill(0.0)
        var buckets = Array.from({ length: cols }, () => [])

        for (var i = 0; i < root.model.length; i++) {
            var item  = root.model[i]
            var ar    = root.aspectRatioOf(item)
            if (!(ar > 0)) ar = 1.5          // guard against NaN / 0 / negative

            var tileH = colW / ar

            // Greedy shortest-column packing
            var sc = 0
            for (var c = 1; c < cols; c++) {
                if (colH[c] < colH[sc]) sc = c
            }

            buckets[sc].push({
                modelData:      item,
                computedHeight: tileH,
                sourceIndex:    i
            })
            colH[sc] += tileH + g
        }

        var maxH = 0
        for (var c2 = 0; c2 < cols; c2++) {
            if (colH[c2] > maxH) maxH = colH[c2]
        }

        return { columns: buckets, totalHeight: maxH }
    }

    // ── Scroll container ───────────────────────────────────────────────────
    Flickable {
        id: flickable
        anchors.fill:   parent
        contentWidth:   width
        contentHeight:  root._masonryData.totalHeight
        clip:           true
        boundsBehavior: Flickable.StopAtBounds

        Controls.ScrollBar.vertical: Controls.ScrollBar {
            policy:      root.scrollBarPolicy
            minimumSize: 0.05
        }

        /*
         * The RowLayout is pinned to contentY so it always occupies exactly the
         * visible viewport rectangle.  Each column ListView then virtualises
         * only the tiles within that window; the Flickable owns all scrolling.
         */
        RowLayout {
            width:   flickable.width
            height:  flickable.height
            y:       flickable.contentY
            spacing: root.spacing

            Repeater {
                model: root._numColumns

                delegate: ListView {
                    id: colView

                    // Capture `index` before it can be shadowed by the inner delegate.
                    readonly property int colIndex: index

                    Layout.fillWidth:  true
                    Layout.fillHeight: true

                    spacing:     root.spacing
                    interactive: false   // Flickable handles all touch/wheel input
                    clip:        true

                    contentY: flickable.contentY   // mirror master scroll

                    model: (root._masonryData.columns && colIndex < root._masonryData.columns.length)
                           ? root._masonryData.columns[colIndex]
                           : []

                    delegate: Item {
                        id: tileWrapper
                        width:  colView.width
                        height: modelData.computedHeight   // pre-computed by layout engine

                        Loader {
                            anchors.fill:    parent
                            sourceComponent: root.delegate

                            /*
                             * Inject context properties the caller's delegate can bind.
                             * Using Loader's own property scope is the idiomatic QML way
                             * to pass data into a dynamically loaded component without
                             * requiring any specific property to exist on it.
                             */
                            property var modelData:  tileWrapper.ListView.view.model[index].modelData
                            property int modelIndex: tileWrapper.ListView.view.model[index].sourceIndex
                        }

                        TapHandler {
                            onTapped: root.tileClicked(
                                tileWrapper.ListView.view.model[index].sourceIndex,
                                tileWrapper.ListView.view.model[index].modelData
                            )
                        }
                    }
                }
            }
        }
    }
}
