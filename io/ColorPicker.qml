pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
  id: root

  property string color: ""
  property string colorType: ""

  function pickColor(colorType: string) {
    root.colorType = colorType
    picker.running = true
  }

  Process {
    id: picker

    command: [ "hyprpicker", "--no-fancy", "--format", root.colorType ]
    stdout: StdioCollector {
      onStreamFinished: root.color = this.text
    }
  }
}
