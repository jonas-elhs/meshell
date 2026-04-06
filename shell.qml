import qs.components
import qs.modules
import qs.modules.bar
import qs.modules.lock
import qs.modules.background
import qs.modules.notifications
import Quickshell

ShellRoot {
  Lock {}

  Ipc {}
  HyprlandShortcuts {}

  Variants {
    model: Quickshell.screens

    Scope {
      id: scope
      property ShellScreen modelData

      Background {
        id: background
        screen: scope.modelData
      }

      LockBackground {
        barCenter: bar.center
        settings: settings
      }

      ShellWindow {
        id: shell
        settings: settings
        bar: bar
        notifications: notifications

        Bar {
          id: bar
          settings: settings
          screen: scope.modelData
        }

        Notifications {
          id: notifications
        }
      }

      Exclusions {
        settings: settings
        bar: bar
      }

      Settings {
        id: settings
        screen: scope.modelData
      }
    }
  }
}
