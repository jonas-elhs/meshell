import qs.config
import qs.components.bar

BarModule {
  id: root

  required property var screen

  width: screen.width + parseInt(Config.layout.border.width)
  height: screen.height + parseInt(Config.layout.border.width)
  leftMargin: -20 - parseInt(Config.layout.border.width)
  transparent: true
  showWhenLocked: true

  onClicked: GlobalSettings.locked = false
}
