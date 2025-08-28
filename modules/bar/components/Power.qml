import qs.components.bar
import Quickshell

BarModule {
  required property var settings

  BarItem {
    icon: "⏻"

    acceptedButtons: Qt.LeftButton | Qt.RightButton
    onClicked: (event) => {
      if (event.button == Qt.LeftButton) {
        settings.toggleBarCenterWidget("powerMenu")
      } else {
        Quickshell.execDetached([ "systemctl", "poweroff" ])
      }
    }
  }
}
