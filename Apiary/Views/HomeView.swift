import SwiftUI

struct HomeView: View {
    @Binding var isConnected: Bool
    @Binding var showTooltip: Bool
    @Binding var showConnectionPrompt: Bool

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

                // Portfolio Balance or Connect Wallet
                if isConnected {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color(hex: "0xFFCB31"), Color(hex: "0xEC6A5E")]), startPoint: .leading, endPoint: .trailing))
                            .frame(height: 180)
                        
                        VStack {
                            Text("YOUR PORTFOLIO BALANCE")
                                .font(.caption)
                                .foregroundColor(.black)
                            
                            Text("$88.00")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.black)
                            
                            HStack {
                                Button(action: {
                                    // TODO: Deposit action
                                }) {
                                    Text("Deposit")
                                        .font(.caption)
                                        .padding(10)
                                        .background(Color.black)
                                        .foregroundColor(.white)
                                        .cornerRadius(5)
                                }
                                Button(action: {
                                    // TODO: Withdraw action
                                }) {
                                    Text("Withdraw")
                                        .font(.caption)
                                        .padding(10)
                                        .background(Color.black)
                                        .foregroundColor(.white)
                                        .cornerRadius(5)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color(hex: "0xFFCB31"), Color(hex: "0xEC6A5E")]), startPoint: .leading, endPoint: .trailing))
                            .frame(height: 180)
                        
                        VStack(alignment: .leading) {
                            Text("Connect your wallet to\("\n")deposit funds & earn yield")
                                .font(.system(size: 24).bold())
                                .foregroundColor(.black)
                                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
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
