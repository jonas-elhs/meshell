import qs.modules
import QtQml
import Quickshell
import Quickshell.Services.Pam

Scope {
  id: root

  property string buffer
  property string state
  property bool authenticating: false

  onStateChanged: stateReset.running = true

  function handleKey(event): void {
    const key = event.key

    state = ""

    if (key == Qt.Key_Enter || key == Qt.Key_Return) {
      password.start()
      stateReset.running = false
    } else if (key == Qt.Key_Backspace) {
      if (event.modifiers & Qt.ControlModifier) {
        root.buffer = ""
      } else {
        root.buffer = root.buffer.slice(0, -1)
      }
    } else if (" abcdefghijklmnopqrstuvwxyz1234567890`~!@#$%^&*()-_=+[{]}\\|;:'\",<.>/?".includes(event.text.toLowerCase())) {
      buffer += event.text
    }
  }

  PamContext {
    id: password

    configDirectory: Quickshell.shellDir + "/assets/pam.d"
    config: "password.conf"

    onCompleted: result => {
      root.authenticating = false

      if (result == PamResult.Success) {
        GlobalSettings.locked = false
      }

      switch (result) {
        case PamResult.Error: {
          root.state = "error"
          break
        }
        case PamResult.MaxTries: {
          root.state = "max"
          break
        }
        case PamResult.Failed: {
          root.state = "fail"
          break
        }
      }
    }

    onResponseRequiredChanged: {
      if (!responseRequired) return

      respond(root.buffer)
      root.authenticating = true
      root.buffer = ""
    }
  }

  Timer {
    id: stateReset
    interval: 5000

    onTriggered: state = ""
  }
}
