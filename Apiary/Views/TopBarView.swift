import SwiftUI

struct TopBarView: View {
    @Binding var isConnected: Bool
    @Binding var showConnectionPrompt: Bool

    var body: some View {
        HStack {
            Image(systemName: "circle.grid.hex")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.yellow5)
            Text("APIARY")
                .font(.title)
                .foregroundColor(.white)
            Spacer()
            if isConnected {
                Button(action: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        showConnectionPrompt.toggle()
                    }
                }) {
                    Text("0x19t6...9m88") // TODO: Display actual address
                        .lineLimit(1)
                        .truncationMode(.middle)
                        .font(.caption)
                        .foregroundColor(.yellow5)
                        .padding(10)
                        .background(Color.black)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.yellow5, lineWidth: 1)
                        )
                }
                .sheet(isPresented: $showConnectionPrompt) {
                    WalletView(isConnected: $isConnected)
                }
            } else {
                Button(action: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        showConnectionPrompt.toggle()
                    }
                }) {
                    Text("Connect")
                        .font(.caption)
                        .foregroundColor(.yellow5)
                        .padding(10)
                        .background(Color.black)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.yellow5, lineWidth: 1)
                        )
                }
                .sheet(isPresented: $showConnectionPrompt) {
                    WalletView(isConnected: $isConnected)
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 20)
        .background(Color.black)
    }
}
