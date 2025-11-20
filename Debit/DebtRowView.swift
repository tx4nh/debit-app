import SwiftUI

struct DebtRowView: View {
    let debt: DebtItem
    let onToggle: (DebtItem) -> Void
    let onAdd: (DebtItem, Double) -> Void
    let onSubtract: (DebtItem, Double) -> Void
    
    @State private var showingAmountAlert = false
    @State private var alertInput = ""
    @State private var isAdding = true
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(debt.name)
                    .font(.headline)
                    .foregroundColor(.primaryText)
                Text("\(debt.amount, specifier: "%.0f") VNĐ")
                    .font(.subheadline)
                    .foregroundColor(.secondaryText)
            }
            Spacer()
            
            HStack(spacing: 15) {
                Button(action: {
                    isAdding = false
                    showingAmountAlert = true
                }) {
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(.borrowed)
                }
                
                Button(action: {
                    isAdding = true
                    showingAmountAlert = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.lent)
                }
            }
            .buttonStyle(BorderlessButtonStyle())

            Button(action: { onToggle(debt) }) {
                Text(debt.type.rawValue)
                    .font(.caption)
                    .fontWeight(.medium)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(debt.type.color.opacity(0.2))
                    .foregroundColor(debt.type.color)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.surface)
        .cornerRadius(10)
        .shadow(radius: 2)
        .alert("Sửa số tiền", isPresented: $showingAmountAlert, actions: {
            TextField("Số tiền", text: $alertInput)
                .keyboardType(.decimalPad)
            Button("Hủy", role: .cancel) { alertInput = "" }
            Button("OK") {
                if let amount = Double(alertInput) {
                    if isAdding {
                        onAdd(debt, amount)
                    } else {
                        onSubtract(debt, amount)
                    }
                }
                alertInput = ""
            }
        }, message: {
            Text("Nhập số tiền để \(isAdding ? "thêm" : "bớt").")
        })
    }
}

#Preview{
    DebtRowView(
        debt: DebtItem(name: "Nguyễn A", amount: 150_000, type: .lent),
        onToggle: { _ in },
        onAdd: { _, _ in },
        onSubtract: { _, _ in }
    )
}

