import SwiftUI

struct DebtListView: View {
    @Binding var debts: [DebtItem]
    let type: DebtType
    
    let onToggle: (DebtItem) -> Void
    let onAdd: (DebtItem, Double) -> Void
    let onSubtract: (DebtItem, Double) -> Void
    let onDelete: (IndexSet) -> Void
    
    var body: some View {
        List {
            ForEach(debts.filter { $0.type == type }) { debt in
                DebtRowView(debt: debt, onToggle: onToggle, onAdd: onAdd, onSubtract: onSubtract)
                    .listRowSeparator(.hidden)
            }
            .onDelete(perform: onDelete)
        }
        .listStyle(PlainListStyle())
    }
}

#Preview {
    DebtListView(
        debts: .constant([
            DebtItem(name: "Nguyễn A", amount: 150_000, type: .lent),
            DebtItem(name: "Trần B", amount: 80_000, type: .lent),
            DebtItem(name: "Lê C", amount: 50_000, type: .borrowed)
        ]),
        type: .lent,
        onToggle: { _ in },
        onAdd: { _, _ in },
        onSubtract: { _, _ in },
        onDelete: { _ in }
    )
}
