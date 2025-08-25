import qs.components.bar

BarModule {
  required property var settings

  BarItem {
    icon: "⏻"

    onClicked: settings.toggleBarCenterWidget("powerMenu")
  }
}
