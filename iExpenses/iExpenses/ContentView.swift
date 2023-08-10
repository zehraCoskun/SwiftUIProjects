//
//  ContentView.swift
//  iExpenses
//
//  Created by Zehra Coşkun on 20.03.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView{
                List {
                    ForEach(expenses.items, id: \.id) { item in
                        HStack {
                            VStack {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            } 
                            Spacer()
                            Text(item.amount, format: .currency(code: item.currency))
                                .foregroundColor(item.amount > 15 ? .red : .green)
                        }
                    }
                    .onDelete(perform: removeItems)
                    //.listRowBackground(Color.blue)
                }
                .navigationTitle("iExpenses")
                .toolbar {
                    Button {
                        showingSheet = true
                    } label: {
                        Image(systemName: "plus")}
                } .sheet(isPresented: $showingSheet) {
                    AddView(expenses: expenses)
                }
        }
    }
    func removeItems ( at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
