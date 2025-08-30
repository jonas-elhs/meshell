import qs.config
import qs.components
import QtQuick
import QtQuick.Layouts

Item {
  id: root

  property string text: ""
  property string icon: ""
  // Not working properly (text not positioned correctly)
  property bool verticalText: false
  property int acceptedButtons: Qt.AllButtons
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

      anchors.horizontalCenter: parent.horizontalCenter
    }
    CustomText {
      id: text

      text: root.text
      font.pixelSize: Config.layout.font.title
      rotation: root.verticalText ? 270 : 0
      width: root.verticalText ? implicitHeight : implicitWidth
      height: root.verticalText ? implicitWidth : implicitHeight

      anchors.horizontalCenter: parent.horizontalCenter
    }
  }

  MouseArea {
    id: mouseArea

    anchors.fill: parent
    anchors.margins: -5
    acceptedButtons: root.acceptedButtons
    onClicked: (event) => root.clicked(event)
  }
}
