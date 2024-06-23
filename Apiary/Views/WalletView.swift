import SwiftUI

struct WalletView: View {
    @Binding var isConnected: Bool
    @Environment(\.presentationMode) var presentationMode

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
                    Text("0x19t6...9m88") // TODO: Display actual address
                        .font(.caption)
                        .foregroundColor(.yellow5)
                        .padding(10)
                        .background(Color.gray12)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.yellow5, lineWidth: 1)
                        )
                    
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

                    // Additional wallet details or actions can be added here
                }
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
