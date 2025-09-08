import qs.components.bar

MultiWidget {
  id: root

  required property var bar
  required property var settings

  WidgetComponent {
    id: workspaces
    isDefault: true

    Workspaces {
      width: root.bar.barWidth
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

  WidgetComponent {
    id: mediaPlayer
    condition: root.settings.barCenterWidget == "mediaPlayer"

    Media {
      settings: root.settings
      bar: root.bar
      styled: false
    }
  }
}
