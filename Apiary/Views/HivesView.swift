import SwiftUI

struct HivesView: View {
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
                Text("Explore Hives")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)

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
