import SwiftUI

struct FlowersView: View {
    @Binding var isConnected: Bool
    @Binding var showConnectionPrompt: Bool

    let vaults = [
        Vault(name: "Honeycomb Aggregated Hive", yield: 12.0, info: "Some information about this vault."),
        Vault(name: "Honeycomb Aggregated Hive", yield: 12.0, info: "Some information about this vault."),
    ]

    var body: some View {
        ScrollView {
            ZStack {
                VStack(alignment: .leading) {
                    Text("Explore Hives")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top, 10)
                        .padding(.bottom, 20)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack {
                        ForEach(vaults) { vault in
                            FlowerCellView(vault: vault, isConnected: $isConnected, showConnectionPrompt: $showConnectionPrompt)
                                .padding(.horizontal)
                        }
                        EmptyVaultItem()
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
