//
//  ExpenseItem.swift
//  iExpenses
//
//  Created by Zehra Coşkun on 20.03.2023.
//

import Foundation
import CoreGraphics

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let currency : String
    let name : String
    let type : String
    let amount : Double
}
