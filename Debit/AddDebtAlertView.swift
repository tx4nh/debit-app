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
                .foregroundStyle(Color.black)
                .padding()
            
            TextField("", text: $name, prompt: Text("Tên người").foregroundColor(.gray))
                .foregroundStyle(.black)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.green, lineWidth: 2)
                }
                .padding()
            
            TextField("", text: $amount, prompt: Text("Số tiền").foregroundStyle(.gray))
                .foregroundStyle(.black)
                .keyboardType(.decimalPad)
                .padding()
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.green, lineWidth: 2)
                }
                .padding()
            
            Picker("Loại", selection: $type) {
                ForEach(DebtType.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .onAppear {
                // Màu nền khi chọn
                UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.black.withAlphaComponent(0.7)
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
            }
            
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
//        .padding(.bottom, 100)
    }
    
    private func addDebt() {
        guard let amountValue = Double(amount), amountValue > 0 else {
            return
        }
        
        let newDebt = DebtItem(name: name, amount: amountValue, type: type)
        debts.append(newDebt)
    }
}

#Preview{
    AddDebtAlertView(
        isPresented: .constant(true),
        debts: .constant([
            DebtItem(name: "Nguyễn A", amount: 100_000, type: .lent)
        ])
    )
}
