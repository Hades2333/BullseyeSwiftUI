//
//  ContentView.swift
//  BullseyeSwiftUI
//
//  Created by Hellizar on 24.07.21.
//

import SwiftUI

struct ContentView: View {
    @State var alertIsVisible: Bool = false

    var body: some View {

        VStack {
            Text("Welcome to my first app!")
                .fontWeight(.black)
                .foregroundColor(.green)
            Button(action: {
                print("Button pressed!")
                self.alertIsVisible = true
            }) {
                Text("Hit me!")
            }
            .alert(isPresented: $alertIsVisible) {
                Alert(title: Text("Hello there!"),
                      message: Text("This is my first SwiftUI alert."),
                      dismissButton: .default(Text("Awesome!")))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
