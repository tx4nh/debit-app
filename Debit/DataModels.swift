import SwiftUI

struct DebtItem: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var amount: Double
    var type: DebtType
}

enum DebtType: String, CaseIterable {
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
