import SwiftUI

struct CustomTabBarView: View {
    @Binding var selectedTab: Int
    let onAddButtonTapped: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                selectedTab = 0
            }) {
                VStack {
                    Image(systemName: "arrow.up.circle")
                        .font(.system(size: 24))
                    Text("Cho vay")
                        .font(.caption)
                }
            }
            .foregroundColor(selectedTab == 0 ? .lent : .gray)
            .frame(maxWidth: .infinity)
            
            Spacer()
            
            Button(action: onAddButtonTapped) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.lent)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(radius: 4)
            }
            .offset(y: -25)
            
            Spacer()
            
            Button(action: {
                selectedTab = 1
            }) {
                VStack {
                    Image(systemName: "arrow.down.circle")
                        .font(.system(size: 24))
                    Text("Đi vay")
                        .font(.caption)
                }
            }
            .foregroundColor(selectedTab == 1 ? .borrowed : .gray)
            .frame(maxWidth: .infinity)
        }
        .padding()
        .background(Color.surface)
        .frame(height: 80)
    }
}
