import QtQuick

QtObject {
  property QtObject background: QtObject {
    property string dark: "#191D24"
    property string base: "#242933"
    property string light: "#3B4252"
  }

  property QtObject foreground: QtObject {
    property string dark: "#434C5E"
    property string base: "#C0C8D8"
    property string light: "#ECEFF4"
  }

  property string accent: "#80B3B2"
  property string inactive: "#4C566A"

  property string success: "#97B67C"
  property string error: "#B74E58"

  property string url: "#88C0D0"
  property string cursor: "#C0C8D8"
}
