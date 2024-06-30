import SwiftUI

struct HiveView: View {
    @Binding var isConnected: Bool
    @Binding var showConnectionPrompt: Bool
    @Binding var selectedTab: Int
    
    @StateObject private var viewModel = FlowersViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text("My Hive Performance")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    Spacer()
                }
                .padding(.leading)
                .padding(.trailing)
                
                TimeframePickerView().padding()
                
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
                            Text("My Flowers")
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
                            let filteredFlowers = viewModel.flowers.filter { Double($0.balance) ?? 0 > 0 }
                            
                            if filteredFlowers.isEmpty {
                                NoBalanceFlowerView()
                            } else {
                                ForEach(filteredFlowers) { flower in
                                    FlowerCellView(viewModel: viewModel, flower: flower, isConnected: $isConnected, showConnectionPrompt: $showConnectionPrompt)
                                        .padding(.horizontal)
                                }
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
        .onAppear {
            viewModel.fetchFlowerBalances(walletAddress: UserDefaults.standard.string(forKey: "walletAddress") ?? "0x")
        }
    }
}
