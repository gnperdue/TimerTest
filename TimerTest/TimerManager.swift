//
//  TimerManager.swift
//  TimerTest
//
//  Created by Gabriel Perdue on 1/16/21.
//

import SwiftUI

enum timerMode {
  case running, paused, stopped
}


public func convertCountToTimeString(elapsedSeconds: Double) -> String {
  if elapsedSeconds < 0 { // want all 0's to have a chance to show
    return "00:00:00"
  }
  let counter = Int(elapsedSeconds * 100)
  let miliseconds = counter % 100
  let seconds = counter / 100
  let minutes = seconds / 60
  var milisecondsString = "\(miliseconds)"
  var secondsString = "\(seconds % 60)"
  var minutesString = "\(minutes)"
  
  if miliseconds < 10 {
    milisecondsString = "0" + milisecondsString
  }
  if (seconds % 60) < 10 {
    secondsString = "0" + secondsString
  }
  if minutes < 10 {
    minutesString = "0" + minutesString
  }
  
  return "\(minutesString):\(secondsString):\(milisecondsString)"
}


public class TimerManager: ObservableObject {
  @Published var elapsedSeconds: Double = 0.0
  @Published var mode: timerMode = .stopped
  private(set) var timer = Timer()
  
  func start() {
    mode = .running
    timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) {_ in
      self.elapsedSeconds += 0.01
    }
    print("started timer...")
  }
  
  func pause() {
    timer.invalidate()
    mode = .paused
  }
  
  func stop() {
    timer.invalidate()
    elapsedSeconds = 0.0
    mode = .stopped
    print("stopped timer...")
  }
}
