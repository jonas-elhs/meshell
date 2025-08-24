import qs.io
import Quickshell
import QtQuick

PersistentProperties {
  id: root

  required property ShellScreen screen
  property bool bar: true
  property string barCenterWidget: ""

  function toggleBarCenterWidget(widget: string) {
    if (root.barCenterWidget == widget) {
      root.barCenterWidget = ""
    } else {
      root.barCenterWidget = widget
    }
  }

  onBarChanged: {
    root.barCenterWidget = ""
  }

  Component.onCompleted: VisibilitiesStorage.save(screen, this)
}
