//
//  ContentView.swift
//  TimerTest
//
//  Created by Gabriel Perdue on 1/16/21.
//

import Foundation
import SwiftUI

struct ContentView: View {
  @StateObject private var timerManager = TimerManager()
  @State var modalIsPresented = false

  var body: some View {
    VStack {
      TimerView(timerManager: timerManager)
        .padding(.vertical)
      //
      Button(action: { print("\(Int16(round(timerManager.elapsedSeconds)))") },
             label: { Label("Log time", systemImage: "folder.badge.plus")})
        .padding()
        .background(Color.blue.opacity(0.1))
        .overlay(
          RoundedRectangle(cornerRadius: 6)
            .stroke(Color.blue, lineWidth: 5))
      Button(action: { modalIsPresented = true },
             label: { Label("Show modal", systemImage: "gear") })
    }
    .sheet(isPresented: $modalIsPresented) {
      SheetView()
    }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
