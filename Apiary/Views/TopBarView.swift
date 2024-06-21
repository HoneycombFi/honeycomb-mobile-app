import SwiftUI

struct TopBarView: View {
    @Binding var isConnected: Bool
    @Binding var showTooltip: Bool
    @Binding var showConnectionPrompt: Bool

    var body: some View {
        HStack {
            Image(systemName: "circle.grid.hex")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.yellow)
            Text("APIARY")
                .font(.title)
                .foregroundColor(.white)
            Spacer()
            if isConnected {
                Button(action: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        showTooltip.toggle()
                    }
                }) {
                    Text("0x19t6...9m88") // TODO: Display actual address
                        .lineLimit(1)
                        .truncationMode(.middle)
                        .font(.caption)
                        .foregroundColor(.yellow)
                        .padding(10)
                        .background(Color.black)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.yellow, lineWidth: 1)
                        )
                }
                .sheet(isPresented: $showTooltip) {
                    VStack {
                        Button(action: {
                            isConnected = false
                            showTooltip = false
                        }) {
                            HStack {
                                Text("Disconnect Wallet")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                Image(systemName: "wallet.pass")
                                    .foregroundColor(.white)
                            }
                            .padding(10)
                            .background(Color.black)
                            .cornerRadius(5)
                        }
                    }
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.yellow, lineWidth: 1)
                    )
                }
            } else {
                Button(action: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        showConnectionPrompt.toggle()
                    }
                }) {
                    Text("Connect")
                        .font(.caption)
                        .foregroundColor(.yellow)
                        .padding(10)
                        .background(Color.black)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.yellow, lineWidth: 1)
                        )
                }
                .sheet(isPresented: $showConnectionPrompt) {
                    VStack {
                        Button(action: {
                            isConnected = true
                            showConnectionPrompt = false
                        }) {
                            HStack {
                                Text("Connect Wallet")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                Image(systemName: "wallet.pass")
                                    .foregroundColor(.white)
                            }
                            .padding(10)
                            .background(Color.black)
                            .cornerRadius(5)
                        }
                    }
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.yellow, lineWidth: 1)
                    )
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 20)
        .background(Color.black)
    }
}
