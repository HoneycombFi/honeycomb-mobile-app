import SwiftUI

struct ApiaryView: View {
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

            Picker("Timeframe", selection: $selectedTimeframe) {
                ForEach(timeframes.indices, id: \.self) { index in
                    Text(self.timeframes[index])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(25)
            .padding(.horizontal)

            // Placeholder for chart
            ZStack {
                RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                    .fill(Color(hex: "0x191919"))
                    .frame(height: 300)
                    .shadow(color: Color.purple.opacity(0.4), radius: 10, x: 0, y: 5)

                VStack(alignment: .leading) {
                    HStack {
                        Text("8.33%")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.leading)
                        
                        Spacer()
                        
                        Text("+1.6%")
                            .font(.system(size: 24))
                            .foregroundColor(.green)
                            .padding(.trailing)
                    }
                    
                    Spacer()
                    
                    PriceChartView()
                }
                .padding()
            }
            .padding()

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
                ScrollView {
                    VStack {
                        ForEach(vaults) { vault in
                            VaultItemView(vault: vault, isConnected: $isConnected, showTooltip: $showTooltip, showConnectionPrompt: $showConnectionPrompt)
                                .padding(.horizontal)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                }
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}

struct PriceChartView: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                
                let points = [
                    CGPoint(x: 0, y: height * 0.8),
                    CGPoint(x: width * 0.2, y: height * 0.6),
                    CGPoint(x: width * 0.4, y: height * 0.7),
                    CGPoint(x: width * 0.6, y: height * 0.5),
                    CGPoint(x: width * 0.8, y: height * 0.3),
                    CGPoint(x: width, y: height * 0.2)
                ]
                
                path.move(to: points[0])
                
                for i in 1..<points.count {
                    path.addLine(to: points[i])
                }
            }
            .stroke(Color.purple, lineWidth: 3)
        }
        .padding(.horizontal)
    }
}
