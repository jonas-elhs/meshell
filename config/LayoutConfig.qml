import QtQuick

QtObject {
  property QtObject border: QtObject {
    property string width: "2"
    property QtObject radius: QtObject {
      property string size: "10"
      property string inner: "7"
    }
  }

  property QtObject font: QtObject {
    property string name: "MapleMono Nerd Font Propo"
    property string mono: "MapleMono Nerd Font Mono"
    property string sub: "10"
    property string size: "12"
    property string title: "18"
  }

  property QtObject background: QtObject {
    property real opacity: 0.5
    property string opacity_hex: "80"
  }

  property QtObject gap: QtObject {
    property string size: "20"
    property string inner: "10"
  }

  property QtObject blur: QtObject {
    property string size: "3"
    property string passes: "4"
  }
}
