pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root

  // CPU
  property real cpuUsed: 0
  property real cpuTotal: 0
  property real cpuPercentage: cpuTotal > 0 ? cpuUsed / cpuTotal : 0
  property int cpuPercentageDisplay: cpuPercentage * 100

  // GPU
  property string gpuType
  property real gpuPercentage: 0
  property int gpuPercentageDisplay: gpuPercentage * 100

  // RAM
  property real ramUsed: 0
  property real ramTotal: 0
  property real ramPercentage: ramTotal > 0 ? ramUsed / ramTotal : 0
  property int ramPercentageDisplay: ramPercentage * 100

  // STORAGE
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
      cpu.reload();
      gpuType.running = true;
      gpu.running = true;
      ram.reload();
      storage.running = true;
    }
  }

  FileView {
    id: cpu

    path: "/proc/stat"
    onLoaded: {
      const data = this.text().match(/^cpu  (\d+) (\d+) (\d+) (\d+) (\d+) (\d+) (\d+)/);

      if (data) {
        const stats = data.slice(1).map(number => parseInt(number));

        root.cpuTotal = stats.reduce((accumulator, stat) => accumulator + stat);
        root.cpuUsed = root.cpuTotal - stats[3] + (stats[4] ?? 0);
      }
    }
  }

  Process {
    id: gpuType

    command: ["sh", "-c", "nvidia-smi -L 2>/dev/null | grep -q '^GPU ' && echo nvidia || { grep -q . /sys/class/drm/card*/device/gpu_busy_percent 2>/dev/null && echo generic || echo none; }"]
    stdout: StdioCollector {
      onStreamFinished: root.gpuType = text.trim()
    }
  }
  Process {
    id: gpu

    command: root.gpuType === "generic" ? ["sh", "-c", "cat /sys/class/drm/card*/device/gpu_busy_percent"] : root.gpuType === "nvidia" ? ["nvidia-smi", "--query-gpu=utilization.gpu", "--format=csv,noheader,nounits"] : ["echo"]
    stdout: StdioCollector {
      onStreamFinished: {
        if (root.gpuType == "generic") {
          const percentages = text.trim().split("\n");
          const sum = percentages.reduce((accumulator, number) => accumulator + parseInt(number));

          // If there is only one gpu, it's the integrated one, otherwise subtract one for the integreted graphics card
          let gpuCount = percentages.length == 1 ? 1 : percentages.length - 1;

          root.gpuPercentage = sum / gpuCount / 100;
        } else if (root.gpuType = "nvidia") {
          root.gpuPercentage = parseInt(text.trim());
        } else {
          root.gpuPercentage = 0;
        }
      }
    }
  }

  FileView {
    id: ram

    path: "/proc/meminfo"
    onLoaded: {
      const text = ram.text();

      ramTotal = parseInt(text.match(/MemTotal:\s*(\d+)/)[1]) || 1;
      ramUsed = (ram.memoryTotal - parseInt(text.match(/MemAvailable:\s*(\d+)/)[1])) || 1;
    }
  }

  Process {
    id: storage

    // Run "df" with "/", as to not target other devices. Doesn't work with other partitions mounted on other paths
    command: ["sh", "-c", "df / | grep '^/dev/' | awk '{print $3, $4}'"]
    stdout: StdioCollector {
      onStreamFinished: {
        const parts = text.trim().split(/\s+/);

        if (parts.length >= 2) {
          root.storageUsed = parseInt(parts[0]) || 0;
          root.storageTotal = storageUsed + parseInt(parts[1]) || 0;
        }
      }
    }
  }
}
