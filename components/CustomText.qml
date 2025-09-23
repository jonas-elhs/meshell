import qs.config
import QtQuick

Text {
  // TODO: animate text transition
  property bool inverse: false
  property int size

  color: inverse ? Config.colors.background.base : Config.colors.foreground.base
  font.family: Config.layout.font.name
  font.pointSize: size
}
