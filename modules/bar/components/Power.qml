import qs.components.bar

BarModule {
  property var visibilities

  BarItem {
    icon: "⏻"

    onClicked: visibilities.powerMenu = !visibilities.powerMenu
  }
}
