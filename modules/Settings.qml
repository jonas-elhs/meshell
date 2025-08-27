import qs.io
import Quickshell
import QtQuick

PersistentProperties {
  id: root

  required property ShellScreen screen
  property bool showBar: true
  property string barCenterWidget: ""
  property string colorPickerColorType: ""

  function toggleBarCenterWidget(widget: string) {
    if (root.barCenterWidget == widget) {
      root.barCenterWidget = ""
    } else {
      root.barCenterWidget = widget
    }
  }

  onShowBarChanged: {
    root.barCenterWidget = ""
  }

  Component.onCompleted: SettingsStorage.save(screen, this)
}
