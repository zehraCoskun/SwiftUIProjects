//
//  ContentView.swift
//  WeSplit
//
//  Created by Zehra Coşkun on 27.02.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountFocus : Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerson : Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let totalAmount = checkAmount * (100 + tipSelection)
        let amountPerPerson = totalAmount / 100 / peopleCount
        return amountPerPerson }
    var totalMoney : Double {
        let tipSelection = Double(tipPercentage)
        return checkAmount * (100 + tipSelection) / 100
    }
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Bakiye hesap", value: $checkAmount, format: .currency(code:  "TRY"))
                        .keyboardType(.decimalPad)
                        .focused($amountFocus)
                    Picker("Toplam kişi", selection: $numberOfPeople){
                        ForEach(2..<10){
                            Text("\($0) Kişi")
                        }
                    }
                }
                Section {
                    Picker("Bahşiş yüzdesi", selection: $tipPercentage ){
                        //                        ForEach(tipPercentages, id: \.self) {
                        //                            Text($0, format: .percent)
                        //                        }
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.menu)
                } header : {
                    Text("Ne kadar bahşiş bırakacaksınız?")
                }
                Section {
                    Text(totalMoney, format: .currency(code:  "TRY"))
                } header : {
                    Text("Toplam tutar")
                }
                Section {
                    Text(totalPerson, format: .currency(code:  "TRY"))
                } header : {
                    Text("Kişi başına düşen tutar")
                }
            }
            .navigationTitle("We Split")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Tamam") {amountFocus = false}
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

