import qs.components
import qs.modules
import qs.modules.bar
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

        Bar {
          id: bar
          visibilities: visibilities
        }

        // Notifications {
        //   id: notifications
        // }
      }

      Visibilities {
        id: visibilities
        screen: scope.modelData
      }

      Exclusions {
        visibilities: visibilities
      }
    }
  }

  HyprlandShortcuts {}
}
