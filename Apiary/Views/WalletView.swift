import SwiftUI

struct WalletView: View {
    @Environment(\.presentationMode) var presentationMode

    @Binding var isConnected: Bool
    @State private var showCopyTooltip = false
    
    let address = "0x19t6...9m88" // TODO: Display actual address

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("My Wallet")
                    .font(.system(size: 36))
                    .foregroundColor(.white)
                    .padding([.top, .bottom], 20)

                Spacer()

                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image("xcircle")
                        .resizable()
                        .frame(width: 32, height: 32)
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            if isConnected {
                HStack(alignment: .center, spacing: 20) {
                    Button(action: {
                        UIPasteboard.general.string = address
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showCopyTooltip = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                showCopyTooltip = false
                            }
                        }
                    }) {
                        Text(address)
                            .font(.caption)
                            .foregroundColor(.yellow5)
                            .padding(10)
                            .background(Color.gray12)
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.yellow5, lineWidth: 1)
                            )
                    }

                    Button(action: {
                        isConnected = false
                    }) {
                        Text("Disconnect")
                            .font(.caption)
                            .foregroundColor(.yellow5)
                            .padding(10)
                            .background(Color.gray12)
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.yellow5, lineWidth: 1)
                            )
                    }
                }
                .overlay(
                    Group {
                        if showCopyTooltip {
                            Text("Copied to clipboard")
                                .font(.caption)
                                .padding(8)
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                                .transition(.opacity)
                                .offset(y: 40)
                        }
                    },
                    alignment: .bottomLeading
                )
                Spacer()

            } else {
                VStack(alignment: .leading, spacing: 20) {
                    Button(action: {
                        isConnected = true
                    }) {
                        Text("Connect Wallet")
                            .font(.caption)
                            .foregroundColor(.yellow5)
                            .padding(10)
                            .background(Color.gray12)
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.yellow5, lineWidth: 1)
                            )
                    }
                    Spacer()
                }
            }
        }
        .padding()
        .cornerRadius(10)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
