//
//  ContentView.swift
//  TimerTest
//
//  Created by Gabriel Perdue on 1/16/21.
//

import SwiftUI

struct ContentView: View {
  @State private var elapsed: Double = 0.0
  
  var body: some View {
    VStack {
      Text(convertCountToTimeString(elapsedSeconds: elapsed))
        .font(.custom("courier", size: 70))
        .modifier(Shadow())
        .padding()
      HStack {
        // need play and pause views, "play.circle", "pause.circle"
        Button(action: {
          print("pressed play/pause")
        }, label: {
          Label("Start/Pause", systemImage: "clock.arrow.circlepath")
        })
        .padding()
        Spacer()
        Button(action: {
          print("pressed stop")
        }, label: {
          Label("Stop", systemImage: "stop.circle")
        })
        .padding()
      }
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
