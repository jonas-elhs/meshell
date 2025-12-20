import qs.io
import qs.config
import Quickshell
import Quickshell.Services.Notifications
import QtQuick

Item {
  id: root

  property var list: list

  anchors.top: parent.top
  anchors.right: parent.right
  anchors.bottom: parent.bottom
  anchors.topMargin: Config.layout.gap.inner
  anchors.rightMargin: Config.layout.gap.inner
  width: 300

  ListView {
    id: list

    model: ScriptModel {
      values: [...Notifications.popups]
    }
    anchors.fill: parent
    orientation: ListView.Vertical
    spacing: Config.layout.gap.size

    delegate: NotificationWrapper {}
  }
}
