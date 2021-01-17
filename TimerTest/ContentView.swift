//
//  ContentView.swift
//  TimerTest
//
//  Created by Gabriel Perdue on 1/16/21.
//

import SwiftUI

struct ContentView: View {
  @State private var elapsed: Double = 0.0
  @StateObject private var timerManager = TimerManager()
  
  var body: some View {
    VStack {
      Text(convertCountToTimeString(
            elapsedSeconds: timerManager.elapsedSeconds))
        .font(.custom("courier", size: 70))
        .modifier(Shadow())
        .padding()
      HStack {
        //
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
            Label("Start", systemImage: "play.circle")
          } else {
            Label("Pause", systemImage: "pause.circle")
          }
        })
        .padding()
        .background((timerManager.mode != .running) ?
                      Color.green.opacity(0.1) : Color.yellow.opacity(0.1))
        .overlay(
          RoundedRectangle(cornerRadius: 6)
            .stroke((timerManager.mode != .running) ?
                      Color.green : Color.yellow, lineWidth: 5))
        //
        Spacer()
        //
        Button(action: {
          print("pressed stop")
          timerManager.stop()
        }, label: {
          Label("Stop", systemImage: "stop.circle")
        })
        .padding()
        .background(Color.red.opacity(0.1))
        .overlay(
          RoundedRectangle(cornerRadius: 6)
            .stroke(Color.red, lineWidth: 5))
      }
      .padding(.horizontal)
    }
  }
}


struct Shadow: ViewModifier {
  func body(content: Content) -> some View {
    return content.shadow(color: Color.black, radius: 5, x: 2, y: 2)
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
