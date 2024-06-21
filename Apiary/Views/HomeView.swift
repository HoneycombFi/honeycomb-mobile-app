import SwiftUI

import SwiftUI

struct HomeView: View {
    @Binding var isConnected: Bool
    @Binding var showTooltip: Bool
    @Binding var showConnectionPrompt: Bool
    @Binding var selectedTab: Int

    let vaults = [
        Vault(name: "Apiary Aggregated Hive", yield: 12.0, riskRating: "A", info: "Some information about this vault."),
        Vault(name: "Apiary Aggregated Hive", yield: 12.0, riskRating: "A", info: "Some information about this vault."),
        Vault(name: "New Hives Coming Soon", yield: 0.0, riskRating: "", info: "")
    ]

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Welcome to Apiary")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)

                if isConnected {
                    PortfolioBalanceView(isConnected: $isConnected, showTooltip: $showTooltip, showConnectionPrompt: $showConnectionPrompt, selectedTab: $selectedTab)
                } else {
                    ConnectWalletView(showConnectionPrompt: $showConnectionPrompt)
                }

                Text("Trending Hives")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .padding(.horizontal)

                ScrollView {
                    VStack {
                        ForEach(vaults) { vault in
                            VaultItemView(vault: vault, isConnected: $isConnected, showTooltip: $showTooltip, showConnectionPrompt: $showConnectionPrompt)
                                .padding(.horizontal)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
            }
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
            .blur(radius: showConnectionPrompt ? 5 : 0)
        }
        .navigationBarHidden(true)
    }
}

import SwiftUI

struct PortfolioBalanceView: View {
    @Binding var isConnected: Bool
    @Binding var showTooltip: Bool
    @Binding var showConnectionPrompt: Bool
    @Binding var selectedTab: Int

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(gradient: Gradient(colors: [Color(hex: "0xFFCB31"), Color(hex: "0xEC6A5E")]), startPoint: .leading, endPoint: .trailing))
                .frame(height: 180)
            
            VStack(alignment: .leading) {
                Text("MY PORTFOLIO BALANCE")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding(.top, 4)
                
                HStack {
                    Text("$88.00")
                        .font(.system(size: 48).bold())
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Button(action: {
                        selectedTab = 1
                    }) {
                        Image(systemName: "chevron.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.black)
                            .frame(width: 28, height: 28, alignment: .trailing)
                    }
                }
                .padding(.bottom, 20)
                
                HStack(spacing: 16) {
                    Button(action: {
                        // TODO: Deposit action
                    }) {
                        HStack {
                            Image(systemName: "building.columns")
                                .font(.system(size: 16))
                            Text("Deposit")
                                .font(.system(size: 16).bold())
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    
                    Button(action: {
                        // TODO: Withdraw action
                    }) {
                        HStack {
                            Image(systemName: "creditcard")
                                .font(.system(size: 16))
                            Text("Withdraw")
                                .font(.system(size: 16).bold())
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
        .padding(.horizontal)
    }
}

struct ConnectWalletView: View {
    @Binding var showConnectionPrompt: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(gradient: Gradient(colors: [Color(hex: "0xFFCB31"), Color(hex: "0xEC6A5E")]), startPoint: .leading, endPoint: .trailing))
                .frame(height: 180)
            
            VStack(alignment: .leading) {
                Text("Connect your wallet to\n deposit funds & earn yield")
                    .font(.system(size: 24).bold())
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 20)
                
                Button(action: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        showConnectionPrompt.toggle()
                    }
                }) {
                    HStack {
                        Image(systemName: "creditcard")
                            .font(.system(size: 16))
                        Text("Connect Wallet")
                            .font(.system(size: 16).bold())
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding()
        }
        .padding(.horizontal)
    }
}
