import SwiftUI

struct WalletView: View {
    @Environment(\.presentationMode) var presentationMode

    @Binding var isConnected: Bool
    @State private var showCopyTooltip = false
    @State private var walletAddress: String = UserDefaults.standard.string(forKey: "walletAddress") ?? "0x"
    @State private var tokens: [ERC20Token] = []
    @State private var isLoading = true
    @State private var errorMessage: String?

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
                        
                        HStack(alignment: .center) {
                            Spacer()
                            Image("base")
                                .resizable()
                                .frame(width: 16, height: 16, alignment: .leading)
                            Text("Base Sepolia")
                                .font(.subheadline)
                                .foregroundColor(.white)
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
                    
                    if isLoading {
                        ProgressView("Fetching balances...")
                            .padding(.top, 30)
                    } else if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .font(.headline)
                            .foregroundColor(.red)
                            .padding(.top, 30)
                    } else {
                        Text("Token Balances")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.top, 30)

                        ForEach(tokens) { token in
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
                                Text(FormatHelper.trimTrailingZeroes(from: token.balance))
                                    .foregroundColor(.white)
                                    .font(.body)
                                Text("$\(token.priceInUSD * Double(token.balance)!, specifier: "%.2f")")
                                    .foregroundColor(.gray)
                                    .font(.caption)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
                .onAppear {
                    fetchBalances()
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

    private func fetchBalances() {
        Task {
            do {
                // Get balances
                let ethBalance = try await WalletManager.shared.getETHBalance(address: walletAddress)
                let usdcBalance = try await WalletManager.shared.getERC20TokenBalance(address: walletAddress, contractAddress: Constants.Networks.BaseSepolia.Tokens.usdcToken)
                
                // TODO: Fetch BEES balance
                
                // TODO: Fetch total balance in Flowers + Hives
                
                // Get prices
                let ethPrice = try await WalletManager.shared.getTokenPriceUSD(tokenId: "ethereum")
                let usdcPrice = try await WalletManager.shared.getTokenPriceUSD(tokenId: "usd-coin")
                
                // Instantiate tokens
                let ethToken = ERC20Token(name: "Ether", symbol: "ETH", logo: "eth", balance: ethBalance, priceInUSD: ethPrice)
                let usdcToken = ERC20Token(name: "USD Coin", symbol: "USDC", logo: "usdc", balance: usdcBalance, priceInUSD: usdcPrice)

                tokens = [ethToken, usdcToken]
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}
