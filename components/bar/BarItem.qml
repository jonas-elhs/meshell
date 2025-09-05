import qs.config
import qs.components
import QtQuick

Item {
  id: root

  property string text: ""
  property string icon: ""
  // Not working properly (text not positioned correctly)
  property bool verticalText: false
  property bool boldIcon: false
  property int textSize: Config.layout.font.title
  property int acceptedButtons: Qt.AllButtons

  signal leftClicked(MouseEvent event)
  signal middleClicked(MouseEvent event)
  signal rightClicked(MouseEvent event)
  signal clicked(MouseEvent event)

  implicitWidth: content.implicitWidth
  implicitHeight: content.implicitHeight
  anchors.horizontalCenter: parent.horizontalCenter

  BarGroup {
    id: content

    MaterialIcon {
      id: icon

      icon: root.icon
      size: 15
      weight: root.boldIcon ? 600 : 500
      color: Config.colors.accent

      anchors.horizontalCenter: parent.horizontalCenter
    }
    CustomText {
      id: text

      text: root.text
      font.pixelSize: root.textSize
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
    onClicked: (event) => {
      switch (event.button) {
        case Qt.LeftButton:
          root.leftClicked(event)
          break
        case Qt.MiddleButton:
          root.middleClicked(event)
          break
        case Qt.RightButton:
          root.rightClicked(event)
          break
      }

      root.clicked(event)
    }
  }
}
