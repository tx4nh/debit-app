import SwiftUI

struct ContentView: View {
    @State private var debts = [DebtItem]()
    @State private var showingAddDebtAlert = false
    @State private var selectedTab = 0
    
    @State private var showingDeleteConfirmation = false
    @State private var debtToDelete: IndexSet?
    @State private var debtTypeForDeletion: DebtType?
    
    @State private var showingToggleConfirmation = false
    @State private var debtToToggle: DebtItem?

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    if selectedTab == 0 {
                        DebtListView(
                            debts: $debts,
                            type: .lent,
                            onToggle: { debt in
                                self.debtToToggle = debt
                                self.showingToggleConfirmation = true
                            },
                            onAdd: { debt, amount in
                                updateDebtAmount(debt: debt, amount: amount, isAdding: true)
                            },
                            onSubtract: { debt, amount in
                                updateDebtAmount(debt: debt, amount: amount, isAdding: false)
                            },
                            onDelete: { offsets in
                                self.debtToDelete = offsets
                                self.debtTypeForDeletion = .lent
                                self.showingDeleteConfirmation = true
                            }
                        )
                    } else {
                        DebtListView(
                            debts: $debts,
                            type: .borrowed,
                            onToggle: { debt in
                                self.debtToToggle = debt
                                self.showingToggleConfirmation = true
                            },
                            onAdd: { debt, amount in
                                updateDebtAmount(debt: debt, amount: amount, isAdding: true)
                            },
                            onSubtract: { debt, amount in
                                updateDebtAmount(debt: debt, amount: amount, isAdding: false)
                            },
                            onDelete: { offsets in
                                self.debtToDelete = offsets
                                self.debtTypeForDeletion = .borrowed
                                self.showingDeleteConfirmation = true
                            }
                        )
                    }
                    
                    CustomTabBarView(selectedTab: $selectedTab) {
                        showingAddDebtAlert.toggle()
                    }
                }
                
                if showingAddDebtAlert {
                    AddDebtAlertView(isPresented: $showingAddDebtAlert, debts: $debts)
                }
            }
            .navigationTitle("Sổ nợ")
            .alert("Xác nhận xóa", isPresented: $showingDeleteConfirmation, actions: {
                Button("Xóa", role: .destructive, action: performDelete)
                Button("Hủy", role: .cancel) {}
            }, message: {
                Text("Bạn có chắc chắn muốn xóa mục này không?")
            })
            .alert("Xác nhận thay đổi", isPresented: $showingToggleConfirmation, actions: {
                Button("Có", action: performToggle)
                Button("Không", role: .cancel) {}
            }, message: {
                Text("Xác nhận chuyển sang \(debtToToggle?.type == .lent ? DebtType.borrowed.rawValue : DebtType.lent.rawValue) \(debtToToggle?.name ?? "")?")
            })
        }
    }

    private func performDelete() {
        guard let offsets = debtToDelete, let type = debtTypeForDeletion else { return }
        
        let filteredDebts = debts.filter { $0.type == type }
        let idsToDelete = offsets.map { filteredDebts[$0].id }
        debts.removeAll { idsToDelete.contains($0.id) }
        
        debtToDelete = nil
        debtTypeForDeletion = nil
    }
    
    private func performToggle() {
        if let debtToToggle = debtToToggle, let index = debts.firstIndex(where: { $0.id == debtToToggle.id }) {
            debts[index].type = (debts[index].type == .lent) ? .borrowed : .lent
        }
        self.debtToToggle = nil
    }

    private func updateDebtAmount(debt: DebtItem, amount: Double, isAdding: Bool) {
        guard let index = debts.firstIndex(where: { $0.id == debt.id }) else {
            return
        }
        
        if isAdding {
            debts[index].amount += amount
        } else {
            debts[index].amount -= amount
        }
        
        if debts[index].amount <= 0 {
            debts.remove(at: index)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
