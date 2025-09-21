import QtQuick

ColorAnimation {
  duration: 200
  easing.type: Easing.BezierSpline
  easing.bezierCurve: [0.25, 0.1, 0.25, 1, 1, 1]
}
