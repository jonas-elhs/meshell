pragma Singleton

import Quickshell

Singleton {
  readonly property date date: clock.date

  function format(formatString: string): string {
    return Qt.formatDateTime(date, formatString);
  }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
