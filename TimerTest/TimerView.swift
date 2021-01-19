//
//  TimerView.swift
//  WeightliftingLog
//
//  Created by Gabriel Perdue on 1/17/21.
//

import SwiftUI

struct TimerView: View {
  @ObservedObject var timerManager: TimerManager

  var body: some View {
    VStack {
      Text(convertCountToTimeString(
            elapsedSeconds: timerManager.elapsedSeconds))
        .font(.custom("courier", size: 32, relativeTo: .headline))
        .modifier(Shadow())
        .padding()
      HStack(spacing: 22) {
        Button(action: {
          print("pressed play/pause")
          switch timerManager.mode {
          case .running:
            timerManager.pause()
          case .paused:
            timerManager.start()
          case .stopped:
            timerManager.start()
          }
        }, label: {
          if (timerManager.mode != .running) {
            TimerButtonLabel(
              title: "Start", systemImage: "play.circle", color: .green)
          } else {
            TimerButtonLabel(
              title: "Pause", systemImage: "pause.circle", color: .yellow)
          }
        })
        Button(action: {
          print("pressed stop")
          timerManager.stop()
        }, label: {
          TimerButtonLabel(
            title: "Stop", systemImage: "stop.circle", color: .red)
        })
      }
      .padding(.horizontal)
    }
  }
}


struct TimerButtonLabel: View {
  let title: String
  let systemImage: String
  let color: Color

  var body: some View {
    HStack {
      Spacer()
      Label(title, systemImage: systemImage)
      Spacer()
    }
    .frame(height: 44)
    .background(color.opacity(0.25))
    .overlay(
      RoundedRectangle(cornerRadius: 6)
        .stroke(color, lineWidth: 5))
  }
}


struct Shadow: ViewModifier {
  func body(content: Content) -> some View {
    return content.shadow(color: Color.black, radius: 5, x: 2, y: 2)
  }
}


struct TimerView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      TimerView(timerManager: TimerManager())
        .preferredColorScheme(.light)
        .previewLayout(.fixed(width: 400, height: 200))

      TimerButtonLabel(
        title: "Start", systemImage: "play.circle", color: Color.green)
        .preferredColorScheme(.light)
        .previewLayout(.fixed(width: 400, height: 80))

      TimerButtonLabel(
        title: "Pause", systemImage: "pause.circle", color: Color.yellow)
        .preferredColorScheme(.light)
        .previewLayout(.fixed(width: 400, height: 80))

      TimerButtonLabel(
        title: "Stop", systemImage: "stop.circle", color: Color.red)
        .preferredColorScheme(.light)
        .previewLayout(.fixed(width: 400, height: 80))

      TimerView(timerManager: TimerManager())
        .preferredColorScheme(.dark)
        .previewLayout(.fixed(width: 400, height: 200))

      TimerButtonLabel(
        title: "Start", systemImage: "play.circle", color: Color.green)
        .preferredColorScheme(.dark)
        .previewLayout(.fixed(width: 400, height: 80))
      
      TimerButtonLabel(
        title: "Pause", systemImage: "pause.circle", color: Color.yellow)
        .preferredColorScheme(.dark)
        .previewLayout(.fixed(width: 400, height: 80))

      TimerButtonLabel(
        title: "Stop", systemImage: "stop.circle", color: Color.red)
        .preferredColorScheme(.dark)
        .previewLayout(.fixed(width: 400, height: 80))
    }
  }
}
