import qs.components.bar
import qs.io

BarModule {
  horizontalPadding: false

  BarItem {
    icon: "memory"
    text: SystemUsage.cpuPercentageDisplay + "%"
  }

  BarItem {
    visible: SystemUsage.gpuType != "NONE"

    icon: ""
    text: SystemUsage.gpuPercentageDisplay + "%"
  }

  BarItem {
    icon: "memory_alt"
    text: SystemUsage.memoryPercentageDisplay + "%"
  }

  BarItem {
    icon: "hard_drive"
    text: SystemUsage.storagePercentageDisplay + "%"
  }
}
