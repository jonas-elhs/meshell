import qs.components.bar
import qs.io

BarModule {
  horizontalPadding: false

  BarItem {
    icon: ""
    text: SystemUsage.cpuPercentageDisplay + "%"
  }

  BarItem {
    visible: SystemUsage.gpuType != "NONE"

    icon: "󰢮"
    text: SystemUsage.gpuPercentageDisplay + "%"
  }

  BarItem {
    icon: ""
    text: SystemUsage.memoryPercentageDisplay + "%"
  }

  BarItem {
    icon: ""
    text: SystemUsage.storagePercentageDisplay + "%"
  }
}
