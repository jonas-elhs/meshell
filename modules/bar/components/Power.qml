import qs.components.bar
import Quickshell

BarModule {
  required property var settings

  BarItem {
    icon: "⏻"

    acceptedButtons: Qt.LeftButton | Qt.RightButton
    onLeftClicked: settings.toggleBarCenterWidget("powerMenu")
    onRightClicked: Quickshell.execDetached([ "systemctl", "poweroff" ])
  }
}
