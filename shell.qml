import qs.components
import qs.modules
import qs.modules.bar
import qs.modules.background
import qs.modules.notifications
import Quickshell

ShellRoot { 
  Variants {
    model: Quickshell.screens

    Scope {
      id: scope
      property ShellScreen modelData

      ShellWindow {
        id: shell
        settings: settings

        Bar {
          id: bar
          settings: settings
        }

        // Notifications {
        //   id: notifications
        // }
      }

      Background {
        id: background
        screen: scope.modelData
        settings: settings
      }

      Settings {
        id: settings
        screen: scope.modelData
      }

      Exclusions {
        settings: settings
        bar: bar
      }
    }
  }

  HyprlandShortcuts {}
}
