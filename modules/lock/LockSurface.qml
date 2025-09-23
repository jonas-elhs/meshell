import qs.io
import qs.config
import qs.modules
import qs.components
import qs.components.animations
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls

WlSessionLockSurface {
  id: root

  required property WlSessionLock lock
  required property Pam pam
  property string user: ""

  color: "transparent"

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.BlankCursor
  }

  Item {
    id: content

    anchors.fill: parent
    focus: true
    Keys.onPressed: event => {
      pam.handleKey(event)
    }

    CustomText {
      id: time

      anchors.bottom: date.top
      anchors.bottomMargin: -25
      anchors.horizontalCenter: parent.horizontalCenter

      text: Time.format("hh:mm")
      size: 70
    }
    CustomText {
      id: date

      anchors.bottom: inputContainer.top
      anchors.bottomMargin: 50
      anchors.horizontalCenter: parent.horizontalCenter

      text: Time.format("dddd, d. of MMMM yyyy")
      size: 20
    }

    Rectangle {
      id: inputContainer

      anchors.bottomMargin: 500
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.verticalCenter: parent.verticalCenter
      anchors.verticalCenterOffset: -100

      property int targetWidth: Math.max(
        250,
        user.width + 2 * Config.layout.gap.inner,
        message.width + 2 * Config.layout.gap.inner,
        password.width + 2 * Config.layout.gap.inner
      )

      width: targetWidth
      height: 50
      radius: width / 2
      border.width: Config.layout.border.width * 1.5
      border.color: Config.colors.accent
      color: Config.colors.foreground.base

      CustomText {
        id: user

        opacity: pam.buffer.length == 0 && pam.state == "" && !pam.authenticating ? 1 : 0
        inverse: true
        anchors.centerIn: parent
        size: 10

        text: " " + root.user

        Behavior on opacity {
          CustomNumberAnimation {
            duration: 150
          }
        }
      }

      CustomText {
        id: message

        opacity: pam.buffer.length == 0 && pam.state != "" && !pam.authenticating ? 1 : 0
        inverse: true
        anchors.centerIn: parent
        size: 10
        color: Config.colors.error
        font.italic: true

        text: {
          switch (pam.state) {
            case "fail": return "Incorrect password. Please try again."
            case "max": return "Maximum password attempts reached."
            case "error": return "Error while authenticating."
            default: return pam.state
          }
        }

        Behavior on opacity {
          CustomNumberAnimation {
            duration: 150
          }
        }
      }

      Row {
        id: password

        anchors.verticalCenter: parent.verticalCenter
        x: inputContainer.targetWidth / 2 - width / 2
        spacing: Config.layout.gap.inner / 2

        ListModel { id: lengthModel }
        Connections {
          target: pam

          function onBufferChanged() {
            if (pam.buffer.length > lengthModel.count) {
              lengthModel.append({})
            } else if (pam.buffer.length == 0) {
              lengthModel.clear()
            } else if (pam.buffer.length < lengthModel.count) {
              lengthModel.remove(lengthModel.count - 1)
            }
          }
        }
        Instantiator {
          id: dots

          model: lengthModel

          Rectangle {
            opacity: 0
            width: 10
            height: width
            radius: width / 2
            color: Config.colors.background.base

            Component.onCompleted: opacity = 1
            Behavior on opacity {
              CustomNumberAnimation {}
            }
          }

          onObjectAdded: (index, dot) => dot.parent = password
        }

        Behavior on x {
          CustomNumberAnimation {}
        }
      }

      SequentialAnimation on border.color {
        running: pam.authenticating
        alwaysRunToEnd: true
        loops: Animation.Infinite

        CustomColorAnimation {
          to: Qt.darker(Config.colors.accent, 1.3)
          duration: 800
        }
        CustomColorAnimation {
          to: Config.colors.accent
          duration: 800
        }
      }

      Behavior on width {
        CustomNumberAnimation {}
      }
      Behavior on border.color {
        CustomColorAnimation {}
      }
    }
  }

  Process {
    running: true

    command: [ "whoami" ]
    stdout: StdioCollector {
      onStreamFinished: root.user = text.trim()
    }
  }

  Connections {
    target: root.lock

    function onUnlock() {
      unlockAnimation.running = true
    }
  }

  ParallelAnimation {
    id: lockAnimation

    CustomNumberAnimation {
      target: time
      property: "scale"
      from: 0
      to: 1
    }
    CustomNumberAnimation {
      target: date
      property: "scale"
      from: 0
      to: 1
    }
    CustomNumberAnimation {
      target: inputContainer
      property: "scale"
      from: 0
      to: 1
    }

    running: true
  }
  SequentialAnimation {
    id: unlockAnimation

    ParallelAnimation {
      CustomNumberAnimation {
        target: time
        property: "scale"
        from: 1
        to: 0
      }
      CustomNumberAnimation {
        target: time
        property: "opacity"
        from: 1
        to: 0
        duration: 100
      }
      CustomNumberAnimation {
        target: date
        property: "scale"
        from: 1
        to: 0
      }
      CustomNumberAnimation {
        target: date
        property: "opacity"
        from: 1
        to: 0
        duration: 100
      }
      CustomNumberAnimation {
        target: inputContainer
        property: "scale"
        from: 1
        to: 0
      }
      CustomNumberAnimation {
        target: inputContainer
        property: "opacity"
        from: 1
        to: 0
        duration: 100
      }
    }
    PropertyAction {
      target: root.lock
      property: "locked"
      value: false
    }
  }
}
