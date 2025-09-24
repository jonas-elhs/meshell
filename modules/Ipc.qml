import qs.io
import Quickshell
import Quickshell.Io

Scope {
  id: root

  IpcHandler {
    target: "bar"

    function toggle(): void {
      let settings = SettingsStorage.getForActive()

      settings.showBar = !settings.showBar
    }
    function display(show: bool): void {
      SettingsStorage.getForActive().showBar = show
    }
  }

  IpcHandler {
    target: "power"

    function toggle(): void {
      SettingsStorage.getForActive().toggleBarCenterWidget("powerMenu")
    }
    function display(show: bool): void {
      let settings = SettingsStorage.getForActive()

      if (show) {
        settings.barCenterWidget = "powerMenu"
      } else {
        if (settings.barCenterWidget == "powerMenu") {
          settings.barCenterWidget = ""
        }
      }
    }
  }

  IpcHandler {
    target: "colorpicker"

    function pick(format: string, copy: bool) {
      if (["rgb", "hex", "hsl", "hsv"].includes(format)) {
        ColorPicker.pickColor(format, SettingsStorage.getForActive(), copy)
      }
    }
    function hide(): void {
      settings = SettingsStorage.getForActive()

      if (settings.barCenterWidget == "colorPicker") {
        settings.barCenterWidget = ""
      }
    }
  }

  IpcHandler {
    target: "wallpaper"

    function set(path: string): void {
      SettingsStorage.getForActive().wallpaperPath = path
    }
  }
}
