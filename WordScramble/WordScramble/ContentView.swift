//
//  ContentView.swift
//  WordScramble
//
//  Created by Zehra Coşkun on 9.03.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var useWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorMessage = ""
    @State private var errorTitle = ""
    @State private var showingError = false
    
    @State private var score = 0
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    Section {
                        TextField("Enter your word", text: $newWord)
                            .textInputAutocapitalization(.never)
                    }
                    Section{
                        ForEach (useWords, id: \.self) { word in
                            HStack{
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }
                        }
                    }
                } .navigationTitle(rootWord)
                    .onSubmit(addNewWord)
                    .onAppear(perform: startGame)
                    .alert(errorTitle, isPresented: $showingError) {
                        Button("Ok", role: .cancel){ }
                    } message: { Text(errorMessage)}
                
                ZStack {
                    Color.green
                    HStack {
                        ZStack {
                            Circle()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.white)
                            Text("\(score)")
                                .font(.title)
                        }
                        .padding(.leading)
                        
                        Text("SCORE")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding(.leading)
                        
                        Spacer()
                        
                    }
                }.clipShape(Capsule())
                    .frame(width: 300, height: 100, alignment: .bottom)
                
                
                Button("New Word", action: startGame)
                    .padding()
                    .foregroundColor(.green)
                Button("Start Again", action: reStart)
                    .padding()
                    .foregroundColor(.red)
            }
        }
        
        
    }
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 1 else {return}
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't speel that world from \(rootWord) !")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isDifferent(word: answer) else {
            wordError(title: "Root Word Alert!", message: "You can't write the root word !")
            return
        }
        
        guard isShortWord(word: answer) else {
            wordError(title: "Too short", message: "The answer must be at least 3 letters")
            return
        }
        
        withAnimation{
            useWords.insert(answer, at: 0)}
        calScore()
        newWord = ""
        
    }
    
    func startGame() {
        if let startWorldsUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWorldsUrl) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func reStart() {
        startGame()
        useWords.removeAll()
        score = 0
    }
    
    func isOriginal (word : String) -> Bool {
        !useWords.contains(word)
    }
    
    func isPossible (word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word{
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal ( word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func isDifferent (word: String) -> Bool {
        if (rootWord == word)
        {return false}
        else {return true}
    }
    
    func isShortWord (word: String) -> Bool {
        if (word.count < 3)
        {return false}
        else { return true}
    }
    
    func calScore (){
        score += newWord.count + 1
    }
    
    func wordError (title: String, message: String) {
        errorMessage = message
        errorTitle = title
        showingError = true
    }
    
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
