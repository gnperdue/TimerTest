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
    NavigationView {
      VStack {
        Text(String(Int(timerManager.elapsedSeconds)))
          .font(.custom("courier", size: 32, relativeTo: .headline))
          .padding()
        Button(action: { timerManager.start() },
               label: { Label("Start timer", systemImage: "play") })
        Button(action: { timerManager.stop() },
               label: { Label("Stop timer", systemImage: "stop") })
        Button(action: { modalIsPresented = true },
               label: { Label("Show modal", systemImage: "gear") })
      }
      .navigationBarTitle(Text("Nav Bar Title"))
      .navigationBarItems(
        trailing: Button(action: { modalIsPresented = true }) {
                    Label("Show modal", systemImage: "gear") }
      )
      .sheet(isPresented: $modalIsPresented) {
        SheetView()
      }
    }
  }
}

enum timerMode {
  case running, paused, stopped
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
  }
  
  func pause() {
    timer.invalidate()
    mode = .paused
  }
  
  func stop() {
    timer.invalidate()
    elapsedSeconds = 0.0
    mode = .stopped
  }
}

struct SheetView: View {
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>

  var body: some View {
    Button(action: { mode.wrappedValue.dismiss() },
           label: { Label("Enter data", systemImage: "hand.point.up.left") })
      .padding()
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
