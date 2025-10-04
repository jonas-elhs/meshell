pragma Singleton

import Quickshell
import Qt.labs.folderlistmodel
import QtQuick

Singleton {
  id: root

  property string current: "/home/ilzayn/wallpapers/moon.png"
  property list<string> list: []

  function set(wallpaper: string) {
    root.current = wallpaper
  }

  function updateList() {
    list = []

    for (let index = 0; index < folderModel.count; index++) {
      list.push(folderModel.get(index, "filePath"))
    }
  }

  FolderListModel {
    id: folderModel

    folder: "file:///home/ilzayn/wallpapers"
    nameFilters: [ "*.png", "*.jpg", "*.jpeg" ]
    showDirs: false

    onStatusChanged: if (status == FolderListModel.Ready) root.updateList()
  }
}
