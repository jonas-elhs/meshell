pragma ComponentBehavior: Bound

import qs.modules
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQml
import QtQuick

Scope {
  id: root

  Connections {
    target: GlobalSettings

    function onLockedChanged() {
      if (GlobalSettings.locked == true) {
        lock.locked = true
      }
      else {
        lock.unlock()
      }
    }
  }

  WlSessionLock {
    id: lock

    signal unlock

    LockSurface {
      id: surface

      lock: lock
      pam: pam
    }
  }

  Pam {
    id: pam
  }
}
