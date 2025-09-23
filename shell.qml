import qs.components
import qs.modules
import qs.modules.bar
import qs.modules.lock
import qs.modules.background
import qs.modules.notifications
import Quickshell

ShellRoot { 
  Variants {
    model: Quickshell.screens

    Scope {
      id: scope
      property ShellScreen modelData

      LockBackground {
        barCenter: bar.center
        settings: settings
      }

      ShellWindow {
        id: shell
        settings: settings

        Bar {
          id: bar
          settings: settings
          screen: scope.modelData
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

  Lock {}

  HyprlandShortcuts {}
}
