import SwiftUI

import Foundation

enum DebtType: String, Codable, CaseIterable {
    case lent = "Cho vay"
    case borrowed = "Đi vay"
    
    var color: Color {
        switch self {
        case .lent:
            return .lent
        case .borrowed:
            return .borrowed
        }
    }
}

struct DebtItem: Identifiable, Codable {
    var id = UUID()
    var name: String
    var amount: Double
    var type: DebtType
    var date: Date
    
    init(name: String, amount: Double, type: DebtType, date: Date = Date()) {
        self.name = name
        self.amount = amount
        self.type = type
        self.date = date
    }
}
