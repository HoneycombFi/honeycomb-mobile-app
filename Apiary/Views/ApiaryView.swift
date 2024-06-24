import SwiftUI

struct ApiaryView: View {
    @Binding var isConnected: Bool
    @Binding var showConnectionPrompt: Bool
    @Binding var selectedTab: Int

    let vaults = [
        Vault(name: "Apiary Aggregated Vault", yield: 12.0, riskRating: "A", info: "Some information about this vault."),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Apiary Hive Performance")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    Spacer()
                }
                .padding(.leading)
                .padding(.trailing)
                
                TimeframePicker().padding()
                
                // Placeholder for chart
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                        .fill(Color.gray13)
                        .frame(height: 300)
                        .shadow(color: Color.purple.opacity(0.4), radius: 10, x: 0, y: 5)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("8.33%")
                                .font(.system(size: 36, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.leading)
                                                        
                            Text("+1.6%")
                                .font(.system(size: 24))
                                .foregroundColor(.green)
                                .padding(.trailing)
                        }
                        
                        Spacer()
                        
                        PerformanceChartView()
                    }
                    .padding()
                }
                .padding()
                
                if !isConnected {
                    ConnectWalletView(showConnectionPrompt: $showConnectionPrompt)
                } else {
                    RewardsBalanceView(isConnected: $isConnected, showConnectionPrompt: $showConnectionPrompt, selectedTab: $selectedTab)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("My Hives")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.top, 10)
                                .padding(.leading, 10)
                            Spacer()
                        }
                        .padding(.leading)
                        .padding(.trailing)
                        
                        VStack {
                            ForEach(vaults) { vault in
                                VaultItemView(vault: vault, isConnected: $isConnected, showConnectionPrompt: $showConnectionPrompt)
                                    .padding(.horizontal)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 20)
                }
            }
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
        }
    }
}
