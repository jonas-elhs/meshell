pragma Singleton

import Quickshell
import Quickshell.Services.Notifications

Singleton {
  id: root

  readonly property list<Notification> list: []

  NotificationServer {
    id: server

    keepOnReload: false
    actionIconsSupported: false
    bodySupported: true
    imageSupported: false
    persistenceSupported: false
    bodyHyperlinksSupported: false
    bodyMarkupSupported: false
    bodyImagesSupported: false
    actionsSupported: false

    onNotification: (notification) => {
      notification.tracked = true
      root.list.push(notification)
    }
  }
}
