import qs.config
import qs.components.bar
import Quickshell
import QtQuick

BarModule {
  id: root

  required property var settings

  Component.onCompleted: shutdown.forceActiveFocus()

  PowerButton {
    id: suspend
    icon: ""
    command: "systemctl suspend"

    KeyNavigation.up: lock
    KeyNavigation.down: hibernate
  }
  PowerButton {
    id: hibernate
    icon: ""
    command: "systemctl hibernate"

    KeyNavigation.up: suspend
    KeyNavigation.down: shutdown
  }
  PowerButton {
    id: shutdown
    icon: "⏻"
    command: "systemctl poweroff"

    KeyNavigation.up: hibernate
    KeyNavigation.down: reboot
  }
  PowerButton {
    id: reboot
    icon: ""
    command: "systemctl reboot"

    KeyNavigation.up: shutdown
    KeyNavigation.down: lock
  }
  PowerButton {
    id: lock
    icon: ""
    command: "loginctl lock-session"

    KeyNavigation.up: reboot
    KeyNavigation.down: suspend
  }

  component PowerButton : Rectangle {
    id: button

    property string icon
    property string command

    function execute() {
      Quickshell.execDetached(command.split(" "))

      root.settings.barCenterWidget = ""
    }

    width: 100
    height: width
    radius: Config.layout.border.radius.inner
    color: "transparent"
    border.width: Config.layout.border.width
    border.color: activeFocus ? Config.colors.accent : "transparent"

    Keys.onEnterPressed: execute()
    Keys.onReturnPressed: execute()
    Keys.onEscapePressed: root.settings.barCenterWidget = ""
    Keys.onPressed: event => {
      if (event.key === Qt.Key_J && KeyNavigation.down) {
        KeyNavigation.down.focus = true
        event.accepted = true
      } else if (event.key === Qt.Key_K && KeyNavigation.up) {
        KeyNavigation.up.focus = true
        event.accepted = true
      }
    }

    Text {
      text: icon
      anchors.centerIn: parent
      color: Config.colors.foreground.base
      font.pixelSize: 100
    }

    MouseArea {
      anchors.fill: parent
      onClicked: execute()
    }
    HoverHandler {
      id: hoverState
      onHoveredChanged: button.focus = true
    }

    Behavior on border.color {
      ColorAnimation {
        duration: 200
        easing.type: Easing.InOutQuad
      }
    }
  }
}
