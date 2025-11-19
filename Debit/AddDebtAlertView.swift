import SwiftUI

struct AddDebtAlertView: View {
    @Binding var isPresented: Bool
    @Binding var debts: [DebtItem]
    
    @State private var name = ""
    @State private var amount = ""
    @State private var type: DebtType = .lent
    
    var body: some View {
        VStack {
            Text("Thêm khoản nợ mới")
                .font(.headline)
                .padding()
            
            TextField("Tên người", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Số tiền", text: $amount)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Picker("Loại", selection: $type) {
                ForEach(DebtType.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            HStack {
                Button("Hủy") {
                    isPresented = false
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                
                Button("Thêm") {
                    addDebt()
                    isPresented = false
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.lent)
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(name.isEmpty || amount.isEmpty)
            }
            .padding()
        }
        .frame(width: 300, height: 450)
        .background(Color.surface)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
    
    private func addDebt() {
        guard let amountValue = Double(amount), amountValue > 0 else {
            return
        }
        
        let newDebt = DebtItem(name: name, amount: amountValue, type: type)
        debts.append(newDebt)
    }
}