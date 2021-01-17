//
//  SheetView.swift
//  TimerTest
//
//  Created by Gabriel Perdue on 1/17/21.
//

import SwiftUI

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

struct SheetView_Previews: PreviewProvider {
  static var previews: some View {
    SheetView()
  }
}
