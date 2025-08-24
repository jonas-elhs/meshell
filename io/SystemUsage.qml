pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root

  property real cpuPercentage: 0
  property int cpuPercentageDisplay: cpuPercentage * 100

  property string gpuType: "NONE"
  property real gpuPercentage: 0
  property int gpuPercentageDisplay: gpuPercentage * 100

  property real memoryUsed: 0
  property real memoryTotal: 0
  property real memoryPercentage: memoryTotal > 0 ? memoryUsed / memoryTotal : 0
  property int memoryPercentageDisplay: memoryPercentage * 100

  property real storageUsed: 0
  property real storageTotal: 0
  property real storagePercentage: storageTotal > 0 ? storageUsed / storageTotal : 0
  property int storagePercentageDisplay: storagePercentage * 100

  Timer {
    running: true
    interval: 500
    repeat: true
    triggeredOnStart: true

    onTriggered: {
      cpu.reload()
      gpuType.running = true
      gpu.running = true
      memory.reload()
      storage.running = true
    }
  }

  FileView {
    id: cpu

    path: "/proc/stat"
    onLoaded: {
      const text = cpu.text()
      const line = text.slice(0, text.indexOf("\n"))

      //cpuPercentageDisplay = line
    }
  }

  Process {
    id: gpuType
    
    command: [ "sh", "-c", "nvidia-smi -L 2>/dev/null | grep -q '^GPU ' && echo nvidia || { grep -q . /sys/class/drm/card*/device/gpu_busy_percent 2>/dev/null && echo generic || echo none; }" ]
    stdout: StdioCollector {
      onStreamFinished: root.gpuType = text.trim()
    }
  }

  Process {
    id: gpu

    command: root.gpuType === "generic" ? ["sh", "-c", "cat /sys/class/drm/card*/device/gpu_busy_percent"]
              : root.gpuType === "nvidia" ? ["nvidia-smi", "--query-gpu=utilization.gpu", "--format=csv,noheader,nounits"]
              : ["echo"]
    stdout: StdioCollector {
      onStreamFinished: {
        if (root.gpuType == "generic") {
          const percentages = text.trim().split("\n")
          const sum = percentages.reduce((accumulator, number) => accumulator + parseInt(number))

          // If there is only one gpu, it's the integrated one, otherwise subtract one for the integreted graphics card
          let gpuCount = percentages.length == 1 ? 1 : percentages.length-1

          root.gpuPercentage = sum / gpuCount / 100
        } else if (root.gpuType = "nvidia") {
          root.gpuPercentage = parseInt(text.trim())
        } else {
          root.gpuPercentage = 0
        }
      }
    }
  }

  FileView {
    id: memory

    path: "/proc/meminfo"
    onLoaded: {
      const text = memory.text()

      root.memoryTotal = parseInt(text.match(/MemTotal:\s*(\d+)/)[1]) || 1
      root.memoryUsed = (memoryTotal - parseInt(text.match(/MemAvailable:\s*(\d+)/)[1])) || 1
    }
  }

  Process {
    id: storage

    // Run "df" with "/", as to not target other devices. Doesn't work with other partitions mounted on other paths
    command: [ "sh", "-c", "df / | grep '^/dev/' | awk '{print $3, $4}'" ]
    stdout: StdioCollector {
      onStreamFinished: {
        const parts = text.trim().split(/\s+/)

        if (parts.length >= 2) {
          const storageUsed = parseInt(parts[0]) || 0
          const storageAvailable = parseInt(parts[1]) || 0

          root.storageUsed = storageUsed
          root.storageTotal = storageUsed + storageAvailable
        }
      }
    }
  }
}
