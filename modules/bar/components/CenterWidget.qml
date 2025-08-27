import qs.components.bar

MultiWidget {
  id: root

  required property var bar
  required property var settings

  alwaysBorder: root.settings.barCenterWidget == "powerMenu"

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
    condition: root.settings.barCenterWidget == "powerMenu"

    PowerMenu {
      settings: root.settings
      styled: false
    }
  }

  WidgetComponent {
    id: colorPicker
    condition: root.settings.barCenterWidget == "colorPicker"

    ColorPicker {
      settings: root.settings
      styled: false
    }
  }
}
