//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Aktilek Ishanov on 07.01.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland",  "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var selectedFlag = ""
    @State private var attempt = 1
    @State private var gameOverTitle = "Game Over"
    @State private var showingGameOver = false
    @State private var totalScore = 0

    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.75, green: 0.15, blue: 0.25), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                
                VStack {
                    Text("Score: \(score)")
                    Text("Attempt: \(attempt) / 8")
                }
                .foregroundColor(.white)
                .font(.title.bold())
                
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            Text("""
                Selected flag: \(selectedFlag)
                Your score is \(score)
            """)
        }
        
        .alert(gameOverTitle, isPresented: $showingGameOver){
            Button("Reset", action: askQuestion)
        } message: {
            Text("""
                Your final score is \(totalScore)
            """)
        }    }
    
    func flagTapped(_ number: Int) {
        if attempt < 8 {
            if number == correctAnswer {
                scoreTitle = "Correct"
                score += 1
            } else {
                scoreTitle = "Wrong"
                score -= 1
            }
            showingScore = true
            selectedFlag = countries[number]
            attempt += 1
        } else {
            if number == correctAnswer {
                score += 1
            } else {
                score -= 1
            }
            showingGameOver = true
            attempt = 1
            totalScore = score
            score = 0
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
