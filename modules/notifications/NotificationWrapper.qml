import QtQuick

Text {
  required property var modelData

  text: (modelData.appName ? modelData.appName + " | " : "") + modelData.summary
  color: "black"
  width: parent.width

  Rectangle {
    anchors.fill: parent
    color: "red"
    z: -1
  }

  MouseArea {
    anchors.fill: parent

    onPressed: console.log("notif pressed")
  }
}
