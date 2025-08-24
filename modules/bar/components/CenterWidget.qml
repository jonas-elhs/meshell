import qs.components.bar

MultiWidget {
  id: root

  required property var bar
  required property var visibilities

  alwaysBorder: root.visibilities.barCenterWidget == "powerMenu"

  WidgetComponent {
    id: workspaces
    isDefault: true

    Workspaces {
      implicitWidth: bar.barWidth
      styled: false
    }
  }

  WidgetComponent {
    id: powerMenu
    condition: root.visibilities.barCenterWidget == "powerMenu"

    PowerMenu {
      visibilities: root.visibilities
      styled: false
    }
  }
}
