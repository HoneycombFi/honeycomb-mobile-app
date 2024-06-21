import SwiftUI

struct YieldVaultsView: View {
    @State private var selectedTimeframe = 0
    @Binding var isConnected: Bool
    @Binding var showTooltip: Bool
    @Binding var showConnectionPrompt: Bool

    let timeframes = ["1D", "1W", "1M", "YTD", "1Y", "ALL"]

    let vaults = [
        Vault(name: "Apiary Aggregated Vault", yield: 12.0, riskRating: "A", info: "Some information about this vault."),
        // Add more vaults as needed
    ]

    var body: some View {
        VStack {
            Picker("Timeframe", selection: $selectedTimeframe) {
                ForEach(timeframes.indices, id: \.self) { index in
                    Text(self.timeframes[index])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.top, 100)

            // Placeholder for chart
            Rectangle()
                .fill(Color.gray)
                .frame(height: 200)
                .padding()

            ScrollView {
                VStack {
                    ForEach(vaults) { vault in
                        NavigationLink(destination: VaultDetailView(vault: vault, isConnected: $isConnected, showTooltip: $showTooltip, showConnectionPrompt: $showConnectionPrompt)) {
                            VaultItemView(vault: vault, isConnected: $isConnected, showTooltip: $showTooltip, showConnectionPrompt: $showConnectionPrompt)
                                .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .frame(maxWidth: .infinity) // Make vault items wider
                .padding(.horizontal)
            }
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}
