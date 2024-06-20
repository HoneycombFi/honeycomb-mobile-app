import SwiftUI

struct HomeView: View {
    @State private var isConnected = false
    @State private var showConnectionPrompt = false

    let vaults = [
        Vault(name: "Apiary Aggregated Hive", yield: 12.0, riskRating: "A", info: "Some information about this vault."),
        Vault(name: "Apiary Aggregated Hive", yield: 12.0, riskRating: "A", info: "Some information about this vault."),
        Vault(name: "New Hives Coming Soon", yield: 0.0, riskRating: "", info: "")
    ]

    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading) {
                    // Top Bar
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
                            HStack {
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
                                Button(action: {
                                    isConnected = false
                                }) {
                                    Text("Disconnect Wallet")
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
                            }
                        } else {
                            ConnectButton(showConnectionPrompt: $showConnectionPrompt)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 140)

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
                                .frame(height: 200)
                            
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
                                .frame(height: 200)
                            
                            VStack {
                                Text("Connect wallet to deposit funds")
                                    .font(.caption)
                                    .foregroundColor(.black)
                                
                                HStack {
                                    Button(action: {}) {
                                        Text("Deposit")
                                            .font(.caption)
                                            .padding(10)
                                            .background(Color.black.opacity(0.2))
                                            .foregroundColor(.white)
                                            .cornerRadius(5)
                                    }
                                    .disabled(true)
                                    Button(action: {}) {
                                        Text("Withdraw")
                                            .font(.caption)
                                            .padding(10)
                                            .background(Color.black.opacity(0.2))
                                            .foregroundColor(.white)
                                            .cornerRadius(5)
                                    }
                                    .disabled(true)
                                }
                            }
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
                                NavigationLink(destination: VaultDetailView(vault: vault)) {
                                    VaultItemView(vault: vault)
                                        .padding(.horizontal)
                                }
                                .buttonStyle(PlainButtonStyle())
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
                
                if showConnectionPrompt {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Spacer()
                        ConnectionPromptView(isConnected: $isConnected, showConnectionPrompt: $showConnectionPrompt)
                        Spacer()
                    }
                    .transition(.opacity)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct ConnectButton: View {
    @Binding var showConnectionPrompt: Bool
    @State private var isPressed = false

    var body: some View {
        Button(action: {
            withAnimation {
                isPressed.toggle()
                showConnectionPrompt = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    isPressed.toggle()
                }
            }
        }) {
            Text("Connect")
                .font(.caption)
                .foregroundColor(isPressed ? .black : .yellow)
                .padding(10)
                .background(isPressed ? Color.yellow : Color.black)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.yellow, lineWidth: 1)
                )
        }
    }
}
