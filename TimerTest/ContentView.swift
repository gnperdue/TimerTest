//
//  ContentView.swift
//  TimerTest
//
//  Created by Gabriel Perdue on 1/16/21.
//

import SwiftUI

struct ContentView: View {
  @State var modalIsPresented = false
  @State var totalElapsedTime: Double = 0.0
  
  var body: some View {
    NavigationView {
      VStack {
        TimerView(totalElapsedTime: $totalElapsedTime)
        Button(action: { modalIsPresented = true },
               label: { Label("Show modal", systemImage: "gear") })
        Text("Total elapsed time: \(totalElapsedTime)")

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


struct TimerView: View {
  @StateObject private var timerManager = TimerManager()
  @Binding var totalElapsedTime: Double
  
  var body: some View {
    VStack {
      Text(String(Int(timerManager.elapsedSeconds)))
      Button(action: {
        totalElapsedTime = 0.0
        timerManager.start()
      }, label: { Label("Start timer", systemImage: "play") })
      Button(action: {
        timerManager.pause()
      }, label: { Label("Pause timer", systemImage: "pause") })
      Button(action: {
        totalElapsedTime = timerManager.elapsedSeconds
        timerManager.stop()
      }, label: { Label("Stop timer", systemImage: "stop") })
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
    print("timer start")
  }
  
  func pause() {
    timer.invalidate()
    mode = .paused
    print("timer pause at \(elapsedSeconds)")
  }
  
  func stop() {
    timer.invalidate()
    elapsedSeconds = 0.0
    mode = .stopped
    print("timer stop")
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
