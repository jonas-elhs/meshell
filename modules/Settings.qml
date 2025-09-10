import qs.io
import Quickshell
import QtQuick

PersistentProperties {
  id: root

  required property ShellScreen screen
  property bool showBar: true
  property string barCenterWidget: ""
  property string colorPickerColorType: ""
  property string wallpaperPath: "/home/ilzayn/.wall"

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
