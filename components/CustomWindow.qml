import Quickshell
import Quickshell.Wayland

PanelWindow {
  property string name: ""

  WlrLayershell.namespace: `meshell${name != "" ? "-" + name : ""}`
  color: "transparent"
}
