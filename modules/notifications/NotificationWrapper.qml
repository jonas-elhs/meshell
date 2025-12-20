import qs.config
import qs.modules
import qs.components
import qs.components.bar
import qs.components.animations
import QtQuick

Rectangle {
  id: root

  required property var modelData

  property bool expanded
  property int notifHeight: summary.implicitHeight + (expanded ? appName.height + body.implicitHeight + 2 : bodyPreview.implicitHeight) + Config.layout.gap.inner * 2

  implicitWidth: parent ? parent.width : 0
  implicitHeight: content.implicitHeight

  radius: Config.layout.border.radius.size
  color: `#${Config.layout.background.opacity_hex}${Config.colors.background.base.substring(1)}`
  border.width: Config.layout.border.width
  border.color: hoverState.hovered ? Config.colors.accent : Config.colors.inactive
  opacity: GlobalSettings.locked ? 0 : 1

  HoverHandler {
    id: hoverState
  }

  MouseArea {
    anchors.fill: parent
    propagateComposedEvents: true

    hoverEnabled: true
    acceptedButtons: Qt.LeftButton | Qt.MiddleButton
    onClicked: event => {
      if (event.button == Qt.LeftButton) {
        root.expanded = !root.expanded;
      } else if (event.button == Qt.MiddleButton) {
        modelData.close();
      }
    }

    onEntered: root.modelData.timer.stop()
    onExited: root.modelData.timer.start()
  }

  Item {
    id: content

    anchors.topMargin: Config.layout.gap.inner
    anchors.rightMargin: Config.layout.gap.inner
    anchors.leftMargin: Config.layout.gap.inner

    anchors.top: parent.top
    anchors.right: parent.right
    anchors.left: parent.left
    implicitHeight: root.notifHeight

    CustomText {
      id: appName

      text: root.modelData.appName
      size: 10

      opacity: root.expanded ? 1 : 0

      Behavior on opacity {
        CustomNumberAnimation {}
      }
    }

    CustomText {
      id: summary

      anchors.top: parent.top
      anchors.topMargin: root.expanded ? 2 : 0

      text: root.modelData.summary
      size: 13

      states: State {
        name: "expanded"
        when: root.expanded

        AnchorChanges {
          target: summary
          anchors.top: appName.bottom
        }
      }
      transitions: Transition {
        AnchorAnimation {
          duration: 200
          easing.type: Easing.BezierSpline
          easing.bezierCurve: [0.25, 0.1, 0.25, 1, 1, 1]
        }
      }
    }

    CustomText {
      id: timeSeparator

      anchors.top: parent.top
      anchors.topMargin: root.expanded ? 0 : 3
      anchors.left: summary.right
      anchors.leftMargin: Config.layout.gap.inner

      text: "•"
      size: 10

      states: State {
        name: "expanded"
        when: root.expanded

        AnchorChanges {
          target: timeSeparator
          anchors.left: appName.right
        }
      }
      transitions: Transition {
        AnchorAnimation {
          duration: 200
          easing.type: Easing.BezierSpline
          easing.bezierCurve: [0.25, 0.1, 0.25, 1, 1, 1]
        }
      }

      Behavior on anchors.topMargin {
        CustomNumberAnimation {}
      }
    }

    CustomText {
      id: time

      anchors.left: timeSeparator.right
      anchors.leftMargin: Config.layout.gap.inner
      anchors.verticalCenter: timeSeparator.verticalCenter

      text: root.modelData.timeString
      size: 10
    }

    MaterialIcon {
      id: expandIcon

      anchors.top: parent.top
      anchors.right: parent.right

      icon: root.expanded ? "expand_less" : "expand_more"
      size: 12
    }

    CustomText {
      id: bodyPreview

      anchors.top: summary.bottom
      anchors.right: expandIcon.right
      anchors.left: summary.left
      width: parent.width - Config.layout.gap.inner * 5

      text: bodyPreviewMetrics.elidedText
      size: 10
      textFormat: Text.MarkdownText
      opacity: root.expanded ? 0 : 1

      Behavior on opacity {
        CustomNumberAnimation {}
      }
    }
    TextMetrics {
      id: bodyPreviewMetrics

      text: root.modelData.body
      font.family: bodyPreview.font.family
      font.pointSize: bodyPreview.font.pointSize
      elide: Text.ElideRight
      elideWidth: bodyPreview.width
    }

    CustomText {
      id: body

      anchors.top: summary.bottom
      anchors.right: parent.right
      anchors.left: summary.left

      text: root.modelData.body
      size: 10
      textFormat: Text.MarkdownText
      opacity: root.expanded ? 1 : 0
      wrapMode: Text.WrapAtWordBoundaryOrAnywhere

      Behavior on opacity {
        CustomNumberAnimation {}
      }
    }
  }
}
