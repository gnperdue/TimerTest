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
        Text("Time")
        Text(convertCountToTimeString(
              elapsedSeconds: timerManager.elapsedSeconds))
          .font(.custom("courier", size: 32, relativeTo: .headline))
          .padding()
        Button(action: { timerManager.start() },
               label: { Label("Start timer",
                              systemImage: "clock.arrow.circlepath") })
        Button(action: { timerManager.stop() },
               label: { Label("Stop timer",
                              systemImage: "clock.arrow.circlepath") })
      }
      .navigationBarTitle(Text("Nav Bar Title"))
      .navigationBarItems(
        leading: timerManager.mode == .stopped ?
          AnyView(EditButton()) :AnyView(EmptyView()),
        trailing: timerManager.mode == .stopped ?
          AnyView(Button(action: { modalIsPresented = true }) {
                    Label("Show modal", systemImage: "gear") }) :
          AnyView(EmptyView())
      )
      .sheet(isPresented: $modalIsPresented) {
        SheetView()
      }
    }
  }
}


struct SheetView: View {
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>

  var body: some View {

    Button(action: {
      self.mode.wrappedValue.dismiss()
    }, label: {
      Label("Enter data", systemImage: "hand.point.up.left")
    })
    .padding()
    
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
