import SwiftUI

struct WalletView: View {
    @Environment(\.presentationMode) var presentationMode

    @Binding var isConnected: Bool
    @State private var showCopyTooltip = false
    @State private var walletAddress: String = UserDefaults.standard.string(forKey: "walletAddress") ?? "0x"

    // TODO: Get actual token balances
    let cryptoTokens: [ERC20Token] = [
        ERC20Token(name: "USD Coin", symbol: "USDC", logo: "usdc", balance: 3000.0, priceInUSD: 1.0),
        ERC20Token(name: "Ether", symbol: "ETH", logo: "eth", balance: 200.09, priceInUSD: 2000.0),
    ]
    
    let apiaryTokens: [ERC20Token] = [
        ERC20Token(name: "Apiary Aggregated Hive", symbol: "BEE", logo: "bee", balance: 120.0, priceInUSD: 1.0),
        ERC20Token(name: "Apiary Aggregated Hive", symbol: "BEE", logo: "bee", balance: 80.0, priceInUSD: 1.0)
    ]

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
                VStack(alignment: .leading, spacing: 20) {
                    HStack(alignment: .center, spacing: 20) {
                        Button(action: {
                            UIPasteboard.general.string = walletAddress
                            withAnimation(.easeInOut(duration: 0.3)) {
                                showCopyTooltip = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    showCopyTooltip = false
                                }
                            }
                        }) {
                            Text(AddressHelper.shared.formatAddress(walletAddress))
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
                    
                    Text("Token Balances")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.top, 30)

                    ForEach(cryptoTokens) { token in
                        HStack {
                            Image(token.logo)
                                .resizable()
                                .frame(width: 32, height: 32)
                            VStack(alignment: .leading) {
                                Text(token.name)
                                    .foregroundColor(.white)
                                    .font(.body)
                                Text(token.symbol)
                                    .foregroundColor(.gray)
                                    .font(.caption)
                            }
                            Spacer()
                            Text("\(token.balance, specifier: "%.2f")")
                                .foregroundColor(.white)
                                .font(.body)
                            Text("$\(token.priceInUSD * token.balance, specifier: "%.2f")")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                        .padding(.vertical, 5)
                    }
                    
                    Text("Apiary Positions")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.top, 10)

                    ForEach(apiaryTokens) { token in
                        HStack {
                            Image(token.logo)
                                .resizable()
                                .frame(width: 32, height: 32)
                            VStack(alignment: .leading) {
                                Text(token.name)
                                    .foregroundColor(.white)
                                    .font(.body)
                                Text(token.symbol)
                                    .foregroundColor(.gray)
                                    .font(.caption)
                            }
                            Spacer()
                            Text("\(token.balance, specifier: "%.2f")")
                                .foregroundColor(.white)
                                .font(.body)
                            Text("$\(token.priceInUSD * token.balance, specifier: "%.2f")")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                        .padding(.vertical, 5)
                    }

                }
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
                }
            }
            Spacer()
        }
        .padding()
        .cornerRadius(10)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
