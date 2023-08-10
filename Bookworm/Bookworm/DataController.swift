//
//  DataController.swift
//  Bookworm
//
//  Created by Zehra Coşkun on 7.08.2023.
//

import Foundation
import CoreData

class DataController : ObservableObject {
    
    let container = NSPersistentContainer(name: "Bookworm")
    init(){
        container.loadPersistentStores { description, error in
            if let error = error {
                print("core data error : \(error.localizedDescription)")
            }
        }
    }
}
