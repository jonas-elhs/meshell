import qs.io
import Quickshell
import Quickshell.Services.Notifications
import QtQuick

Item {
  anchors.top: parent.top
  anchors.right: parent.right
  anchors.bottom: parent.bottom
  width: 200

  ListView {
    model: ScriptModel {
      values: [...Notifications.list]
    }
    anchors.fill: parent
    orientation: ListView.Vertical
    spacing: 10

    delegate: NotificationWrapper {}
  }
}
