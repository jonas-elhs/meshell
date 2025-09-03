import QtQuick

Text {
  id: root

  property string icon
  property real fill: 0
  property int grade: 0
  property int size: 10
  property int weight: 10

  text: root.icon
  font.family: "Material Symbols Rounded"
  font.pointSize: root.size
  font.weight: root.weight
  font.variableAxes: ({
    FILL: root.fill.toFixed(1),
    GRAD: root.grade,
    wght: fontInfo.weight,
    opsz: fontInfo.pixelSize,
  })
}
