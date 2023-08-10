//
//  ContentView.swift
//  TimeConversation
//
//  Created by Zehra Coşkun on 28.02.2023.
//

import SwiftUI
struct ContentView: View {
    @State private var input = 60.0
    @State private var inputTur = "Dakika"
    @State private var outputTur = "Saniye"
    @State private var sonuc = 0.0
    
    let tur = ["Saniye","Dakika","Saat","Gün"]
    
    var saniyeyeCevir : Double {
        switch inputTur {
        case "Saniye" :
            return input
        case "Dakika" :
            return input * 60
        case "Saat" :
            return input * 3600
        case "Gün" :
            return input * 3600 * 24
        default : return 0
        }
    }
    
    var final : Double {
        switch outputTur {
        case "Saniye" :
            return saniyeyeCevir
        case "Dakika" :
            return saniyeyeCevir / 60
        case "Saat" :
            return saniyeyeCevir / 3600
        case "Gün" :
            return saniyeyeCevir / 3600 / 24
        default : return 2
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Girilen saniye", value: $input, format: .number)
                        .keyboardType(.numberPad)
                
                    Picker("Girdinizin türü", selection: $inputTur){
                        ForEach(tur,id: \.self){
                            Text($0)
                        }
                    } .pickerStyle(.segmented)
                } header: {
                    Text("Giriş yapınız")
                }
                
                Section {
                    Picker("Çıktınızın türü", selection: $outputTur){
                        ForEach(tur,id: \.self){
                            Text($0)
                        }
                    } .pickerStyle(.segmented)
                } header: {
                    Text("Çıktınızın Türü")
                }
                
                Section {
                    Text(final, format : .number)
                } header: {
                    Text("\(input, format: .number) \(inputTur) =")
                }
            }  .navigationTitle("Zaman Dönüştürücü")
        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
