//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Zehra Coşkun on 5.03.2023.
//

import SwiftUI
struct OptionsView : View {
    var options : [String]
    var number : Int
    var body: some View {
        Image(options[number])
            .resizable()
            .scaledToFit()
            .padding(10)
            .background(.yellow)
            .cornerRadius(20)
            .foregroundColor(.white)
    }
}
struct TitleView : ViewModifier {
    func body(content : Content) -> some View {
        content
            .padding(20)
            .background(.white)
            .cornerRadius(20)
            .foregroundColor(.mint)
            .font(.largeTitle)
    }
}
extension View {
    func titleView() -> some View{
        modifier(TitleView())
    }
    
}
struct ContentView: View {
    @State private var options = ["rock", "paper", "scissors"]
    @State private var appChoice = " Mmmm düşüneyim..."
    @State private var alertText = ""
    @State private var appWin = 0
    @State private var playerWin = 0
    
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color.yellow, location: 0.8),
                .init(color: Color.mint, location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 300)
            .ignoresSafeArea()
            VStack {
                Spacer ()
                Button("Baştan Başlayalım mı?", action: restart)
                    .foregroundColor(.mint)
                Spacer(minLength: 60)
                Text("Oyun Başlasın")
                    .titleView()
                VStack{
                    Spacer()
                    Text("Ben \(appWin) - Sen \(playerWin) ")
                        .padding()
                        .background(.yellow)
                        .cornerRadius(20)
                    Spacer()
                    Text("\(appChoice)")
                        .titleView()
                    Image("\(appChoice)")
                        .titleView()
                    Spacer()
                    Text("\(alertText)")
                }
                HStack {
                    ForEach (0..<3) { number in
                        Button {
                            randomAppChoice()
                            optionTapped(options[number])
                        } label: {
                            OptionsView(options: options, number: number)
                        }
                    }
                }
                .padding()
               
            }
        }
        //.background(.gray)
    }
    func optionTapped (_ playerChoice: String) {
        if playerChoice == appChoice {
            alertText = "Tüh aynısını seçtik, tekrar oynayalım"}
        else if (playerChoice == "rock" && appChoice == "scissors") {
            alertText = "Ah sen kazandın"
            playerWin += 1
        }
        else if (playerChoice == "rock" && appChoice == "paper") {
            alertText = "Yihhu ben kazandım"
            appWin += 1
        }
        else if (playerChoice == "paper" && appChoice == "rock" ) {
            alertText = "Ah sen kazandın"
            playerWin += 1
        }
        else if (playerChoice == "paper" && appChoice == "scissors" ) {
            alertText = "Yihhu ben kazandım"
            appWin += 1
        }
        else if (playerChoice == "scissors" && appChoice == "paper" ) {
            alertText = "Ah sen kazandın"
            playerWin += 1
        }
        else if (playerChoice == "scissors" && appChoice == "rock" ) {
            alertText = "Yihhu ben kazandım"
            appWin += 1
        }
    }
    func randomAppChoice ()
    {
        appChoice = options[Int.random(in: 0...2)]
    }
    func restart (){
        appWin = 0
        playerWin = 0
        appChoice = " Mmmm düşüneyim..."
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
