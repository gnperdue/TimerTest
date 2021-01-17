//
//  ContentView.swift
//  TimerTest
//
//  Created by Gabriel Perdue on 1/16/21.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var timerManager = TimerManager()

  var body: some View {
    VStack {
      TimerView(timerManager: timerManager)
        .padding(.vertical)
      //
      Button(action: { print("\(timerManager.elapsedSeconds)") },
             label: { Label("Log time", systemImage: "folder.badge.plus")})
        .padding()
        .background(Color.blue.opacity(0.1))
        .overlay(
          RoundedRectangle(cornerRadius: 6)
            .stroke(Color.blue, lineWidth: 5))

    }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
