//
//  ContentView.swift
//  BullseyeSwiftUI
//
//  Created by Hellizar on 24.07.21.
//

import SwiftUI

struct ContentView: View {

    // MARK: Game stats
    @State var score = 0
    @State var round = 1

    // MARK: States

    @State var alertIsVisible: Bool = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)

    // MARK: Properties

    var sliderValueRounded: Int {
        Int(sliderValue.rounded())
    }

    var sliderTargetDifference: Int {
        abs(sliderValueRounded - target)
    }

    // MARK: Views

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Put the bullseye as close as you can to:")
                    Text("\(target)")
                }.padding(.top, 50)
                Spacer()

                HStack {
                    Text("1")
                    Slider(value: $sliderValue, in: 1...100)
                    Text("100")
                }
                Button(action: {
                    print("Button pressed!")
                    self.alertIsVisible = true
                }) {
                    Text("Hit me!")
                }
                .alert(isPresented: self.$alertIsVisible) {
                    Alert(title: Text("Hello there!"),
                          message: Text("The slider's value is \(sliderValueRounded).\n" +
                                            "You earned \(pointsForCurrentRound()), points."),
                          dismissButton: .default(Text("Awesome!")) {
                            self.startNewRound()
                          })
                }
                Spacer()

                HStack {
                    Button(action: {
                        self.startNewGame()
                    }) {
                        Text("Start over")
                    }
                    Spacer()
                    Text("Score:")
                    Text("\(score)")
                    Spacer()
                    Text("Round:")
                    Text("\(round)")
                    Spacer()
                    NavigationLink(destination: AboutView()) {
                        Text("Info")
                    }
                }
                .padding(.bottom, 20)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    // MARK: Methods

    func pointsForCurrentRound() -> Int {
        let points: Int
        if sliderTargetDifference == 0 {
            points = 200
        } else if sliderTargetDifference == 1 {
            points = 150
        } else {
            points = 100 - sliderTargetDifference
        }
        return points
    }

    func startNewRound() {
        score += pointsForCurrentRound()
        round += 1
        target = Int.random(in: 1...100)
    }

    func startNewGame() {
        score = 0
        round = 1
        target = Int.random(in: 1...100)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.device)
            .previewDevice("iPhone 8")
    }
}
