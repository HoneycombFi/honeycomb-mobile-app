import SwiftUI

struct HomeView: View {
    @Binding var isConnected: Bool
    @Binding var showConnectionPrompt: Bool
    @Binding var selectedTab: Int

    let flowers = [
        Flower(name: "Synthetix Flower", logo: "synthetix", yield: 12.0, info: "Some information about this vault."),
        Flower(name: "Aerodrome Flower", logo: "aerodrome", yield: 12.0, info: "Some information about this vault."),
    ]

    var body: some View {
        ScrollView {
            ZStack {
                VStack(alignment: .leading) {
                    Text("Welcome to Honeycomb")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top, 10)
                        .padding(.bottom, 20)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if isConnected {
                        RewardsBalanceView(isConnected: $isConnected, showConnectionPrompt: $showConnectionPrompt, selectedTab: $selectedTab)
                    } else {
                        ConnectWalletView(showConnectionPrompt: $showConnectionPrompt)
                    }
                    
                    Text("Trending Flowers")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                        .padding(.horizontal)
                    
                    VStack {
                        ForEach(flowers) { flower in
                            FlowerCellView(flower: flower, isConnected: $isConnected, showConnectionPrompt: $showConnectionPrompt)
                                .padding(.horizontal)
                        }
                        EmptyFlowerCell()
                    }
                    .frame(maxWidth: .infinity)
                }
                .background(Color.black)
                .edgesIgnoringSafeArea(.all)
                .blur(radius: showConnectionPrompt ? 5 : 0)
            }
            .navigationBarHidden(true)
        }
    }
}

struct RewardsBalanceView: View {
    @Binding var isConnected: Bool
    @Binding var showConnectionPrompt: Bool
    @Binding var selectedTab: Int

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(gradient: Gradient(colors: [Color(hex: "0xFFD700"), Color(hex: "0xFF69B4")]), startPoint: .leading, endPoint: .trailing))
                .frame(height: 200)
            
            VStack(alignment: .leading) {
                Text("MY REWARDS BALANCE")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding(.top, 4)
                
                HStack {
                    Text("$0.00") // TODO: Display total vault balance and/or wallet balance
                        .font(.system(size: 48).bold())
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    if selectedTab != 1 {
                        Button(action: {
                            selectedTab = 1
                        }) {
                            Image(systemName: "chevron.right")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.black)
                                .frame(width: 20, height: 20, alignment: .trailing)
                                .padding(.top, 4)
                        }
                    }
                }
                .padding(.bottom, 20)
                
                Button(action: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        // TODO: Withdraw action
                    }
                }) {
                    HStack {
                        Image("cash")
                            .aspectRatio(contentMode: .fit)
                        
                        Text("Withdraw Rewards")
                            .font(.system(size: 16).bold())
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }.padding(.bottom, 10)
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
                .fill(LinearGradient(gradient: Gradient(colors: [Color(hex: "0xFFD700"), Color(hex: "0xFF69B4")]), startPoint: .leading, endPoint: .trailing))
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
                        Image("wallet")
                            .aspectRatio(contentMode: .fit)
                        
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
