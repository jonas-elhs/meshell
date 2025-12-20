pragma Singleton

import Quickshell
import Quickshell.Services.Notifications
import QtQuick

Singleton {
  id: root

  readonly property list<Notif> list: []
  readonly property list<Notif> popups: list.filter(notif => notif.popup)

  NotificationServer {
    id: server

    keepOnReload: false
    actionIconsSupported: false // TODO
    bodySupported: true
    imageSupported: false // TODO
    persistenceSupported: false // TODO
    bodyHyperlinksSupported: false // TODO
    bodyMarkupSupported: true
    bodyImagesSupported: true
    actionsSupported: false // TODO

    onNotification: notification => {
      notification.tracked = true;

      root.list.push(notifComponent.createObject(root, {
        notification: notification
      }));
    }
  }

  component Notif: QtObject {
    id: notif

    property bool popup: true
    property date time: new Date()
    readonly property string timeString: {
      const difference = Time.date.getTime() - time.getTime();
      const minutes = Math.floor(difference / 60000);

      if (minutes < 1) {
        return "now";
      }

      const hours = Math.floor(minutes / 60);
      const days = Math.floor(hours / 24);

      if (days > 0) {
        return `${days}d`;
      }
      if (hours > 0) {
        return `${hours}h`;
      }

      return `${minutes}m`;
    }
    property Notification notification

    property string id: notification.id
    property string summary: notification.summary
    property string body: notification.body
    property string appIcon: notification.appIcon
    property string appName: notification.appName
    property string image: notification.image
    property real expireTimeout: 5000
    property int urgency: notification.urgency
    property bool resident: notification.resident
    property bool hasActionIcons: notification.hasActionIcons
    property list<var> actions: notification.actions

    readonly property Timer timer: Timer {
      running: true
      interval: notif.expireTimeout > 0 ? notif.expireTimeout : Config.notifs.defaultExpireTimeout
      onTriggered: {
        notif.popup = false;
      }
    }

    function close() {
      root.list = root.list.filter(notif => notif !== this);
      notification.dismiss();
      destroy();
    }
  }
  Component {
    id: notifComponent

    Notif {}
  }
}
