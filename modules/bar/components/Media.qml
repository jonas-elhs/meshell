import qs.io
import qs.config
import qs.components
import qs.components.bar
import QtQuick
import Quickshell.Widgets

BarModule {
  id: root

  required property var settings
  required property var bar

  width: bar.barWidth * 6
  column: false

  ClippingRectangle {
    id: thumbnail

    width: root.width
    height: width
    color: "transparent"
    radius: Config.layout.border.radius.inner

    MaterialIcon {
      icon: "album"

      anchors.centerIn: parent
      font.pointSize: 100
    }

    Image {
      id: image

      anchors.fill: parent

      source: MediaPlayers.active?.trackArtUrl ?? ""
      fillMode: Image.PreserveAspectCrop
      sourceSize.width: width
      sourceSize.height: height
    }
  }

  BarGroup {
    anchors.top: thumbnail.bottom

    CustomText {
      id: title

      anchors.horizontalCenter: parent.horizontalCenter
      horizontalAlignment: Text.AlignHCenter

      text: (MediaPlayers.active?.trackTitle ?? "No Media") || "Unkown title"
      font.pixelSize: 18

      width: root.width
      elide: Text.ElideRight
    }
    CustomText {
      id: album

      visible: MediaPlayers.active?.trackAlbum != "" ?? true

      anchors.horizontalCenter: parent.horizontalCenter
      horizontalAlignment: Text.AlignHCenter

      // text: (MediaPlayers.active?.trackAlbum ?? "No Media") || "Unknown Album"
      text: MediaPlayers.active?.trackAlbum ?? "No Media"
      font.pixelSize: 18

      width: root.width
      elide: Text.ElideRight
    }
    CustomText {
      id: artist

      anchors.horizontalCenter: parent.horizontalCenter
      horizontalAlignment: Text.AlignHCenter

      text: (MediaPlayers.active?.trackArtist ?? "No Media") || "Unknown Artist"
      font.pixelSize: 18

      width: root.width
      elide: Text.ElideRight
    }
  }
  Row {
    anchors.horizontalCenter: parent.horizontalCenter
    width: 100

    Control {
      icon: "skip_previous"
      enabled: MediaPlayers.active?.canGoNext ?? false
      onClicked: MediaPlayers.active?.previous()
    }
    Control {
      icon: "pause"
      enabled: MediaPlayers.active?.canTogglePlaying ?? false
      onClicked: MediaPlayers.active?.togglePlaying()
    }
    Control {
      icon: "skip_next"
      enabled: MediaPlayers.active?.canGoPrevious ?? false
      onClicked: MediaPlayers.active?.next()
    }
  }

  component Control: MaterialIcon {
    id: control

    required property string icon
    required property bool enabled
    signal clicked(MouseEvent event)

    // anchors.centerIn: parent
    // width: icon.implicitWidth
    // height: width

    icon: control.icon
    color: "red"
    size: 18
  }
}
