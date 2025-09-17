import qs.components.animations
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick

Item {
  id: root

  anchors.fill: parent

  property bool morph: true

  required property var settings
  property bool oneActive: true
  property list<QtObject> wallpapers: []

  // Render wallpaper on start
  Component.onCompleted: spawnWallpaper(true)

  // Update wallpaper
  Connections {
    target: settings

    function onWallpaperPathChanged() {
      spawnWallpaper()
    }
  }

  function spawnWallpaper(immediate: bool): QtObject {
    const wallpaper = wallpaperImage.createObject(root, {
      wallpaperPath: settings.wallpaperPath,
      immediate: immediate ?? false
    })

    root.wallpapers.push(wallpaper)
  }

  IpcHandler {
    target: "wallpaper"

    function set(path: string): void {
      settings.wallpaperPath = path
    }
  }

  Component {
    id: wallpaperImage

    ClippingRectangle {
      id: wallpaper

      required property string wallpaperPath
      property bool immediate: false

      Component.onCompleted: {
        if (root.morph) {
          image.opacity = 1
        } else {
          width = 3 * image.width
        }
      }

      width: root.morph ? root.width : 0
      height: width
      radius: root.morph ? 0 : width / 2
      color: "transparent"

      anchors.centerIn: root.morph ? parent : null

      anchors.top: parent.top
      // anchors.bottom: parent.bottom
      anchors.right: parent.right
      // anchors.left: parent.left
      // anchors.centerIn: parent
      anchors.margins: -0.5 * width

      Image {
        id: image

        opacity: root.morph ? 0 : 1

        x: 0 - wallpaper.x
        y: 0 - wallpaper.y
        width: root.width
        height: root.height

        source: wallpaper.wallpaperPath
        fillMode: Image.PreserveAspectCrop

        Behavior on opacity {
          enabled: !wallpaper.immediate

          SequentialAnimation {
            CustomNumberAnimation {
              duration: 700
            }
            ScriptAction {
              script: {
                if (root.wallpapers.length > 1) {
                  const first = root.wallpapers[0]

                  first.destroy()
                  root.wallpapers.shift()
                }
              }
            }
          }
        }
      }

      Behavior on width {
        enabled: !wallpaper.immediate

        SequentialAnimation {
          CustomNumberAnimation {
            duration: 1500
          }
          ScriptAction {
            script: {
              if (root.wallpapers.length > 1) {
                const first = root.wallpapers[0]

                first.destroy()
                root.wallpapers.shift()
              }
            }
          }
        }
      }
    }
  }
}
