pragma Singleton

import Quickshell
import Quickshell.Services.Mpris

Singleton {
  readonly property list<MprisPlayer> players: Mpris.players.values
  readonly property MprisPlayer active: manualActive ?? players[0] ?? null
  property MprisPlayer manualActive
}
