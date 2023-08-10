//
//  AddView.swift
//  iExpenses
//
//  Created by Zehra Coşkun on 21.03.2023.
//

import SwiftUI

struct AddView: View {
    
    @ObservedObject var expenses : Expenses
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var currency = "USD"

    let currencies = ["USD", "EUR", "TRY"]
    
    
    let types = ["Personal", "Business"]
    
    var body: some View {
        NavigationView {
            VStack{
                Picker("Choose currency", selection: $currency){
                    ForEach(currencies, id: \.self){
                        Text($0)
                    }
                }
                
                Form {
                    TextField("Name", text: $name)
                    Picker("Type", selection: $type){
                        ForEach(types, id: \.self){
                            Text($0)
                        }
                    }
                    TextField("Amount", value: $amount, format: .currency(code: "USD"))
                } .navigationTitle("Add new expense")
                    .toolbar {
                        Button("Save") {
                            let item = ExpenseItem(currency: currency, name: name, type: type, amount: amount)
                            expenses.items.append(item)
                            dismiss()
                        }
                    }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses:  Expenses())
    }
}
