import qs.config
import qs.components
import QtQuick
import QtQuick.Layouts

Item {
  id: root

  property string text: ""
  property string icon: ""
  signal clicked(MouseEvent event)

  implicitWidth: content.implicitWidth
  implicitHeight: content.implicitHeight
  Layout.alignment: Qt.AlignHCenter

  Column {
    id: content

    CustomText {
      id: icon

      text: root.icon
      font.pixelSize: Config.layout.font.title
      color: Config.colors.accent

      Layout.alignment: Qt.AlignHCenter
      anchors.horizontalCenter: parent.horizontalCenter
    }
    CustomText {
      id: text

      text: root.text
      color: Config.colors.foreground.base
      font.pixelSize: Config.layout.font.title

      Layout.alignment: Qt.AlignHCenter
      anchors.horizontalCenter: parent.horizontalCenter
    }
  }

  MouseArea {
    anchors.fill: parent
    anchors.margins: -5
    onClicked: (event) => root.clicked(event)
  }
}
