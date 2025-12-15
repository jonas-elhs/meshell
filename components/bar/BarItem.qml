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
  property int textSize: 13
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
    // TODO: figure out right spacing
    spacing: root.verticalText ? 5 : this.spacing

    MaterialIcon {
      id: icon

      icon: root.icon
      size: 15
      weight: root.boldIcon ? 600 : 500
      color: Config.colors.accent

      anchors.horizontalCenter: parent.horizontalCenter
    }
    Item {
      implicitWidth: root.verticalText ? text.implicitHeight : text.implicitWidth
      implicitHeight: root.verticalText ? text.implicitWidth : text.implicitHeight

      CustomText {
        id: text

        text: root.text
        size: root.textSize
        rotation: root.verticalText ? 270 : 0

        anchors.centerIn: parent
      }
    }
  }

  MouseArea {
    id: mouseArea

    anchors.fill: parent
    anchors.margins: -5
    acceptedButtons: root.acceptedButtons
    onClicked: event => {
      switch (event.button) {
      case Qt.LeftButton:
        root.leftClicked(event);
        break;
      case Qt.MiddleButton:
        root.middleClicked(event);
        break;
      case Qt.RightButton:
        root.rightClicked(event);
        break;
      }

      root.clicked(event);
    }
  }
}
