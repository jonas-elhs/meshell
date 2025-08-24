import QtQuick

Text {
  required property var modelData
  text: modelData?.summary ?? modelData.appName
  color: "red"
}
