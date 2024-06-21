import SwiftUI

struct VaultDetailView: View {
    let vault: Vault

    @Environment(\.presentationMode) var presentationMode
    @Binding var isConnected: Bool
    @Binding var showTooltip: Bool
    @Binding var showConnectionPrompt: Bool
    @State private var selectedTimeframe = 0
    let timeframes = ["1D", "1W", "1M", "YTD", "1Y", "ALL"]

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Button(action: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding()
                    }
                    Spacer()
                }
                
                VStack(alignment: .leading) {
                    Text(vault.name)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .padding([.leading, .bottom, .trailing])

                    VStack {
                        HStack {
                            Text("Apiary Hive Performance")
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                            Button(action: {
                                // TODO: add action
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.yellow)
                                    .font(.title)
                            }
                        }
                        .padding([.leading, .trailing, .top])

                        Picker("Timeframe", selection: $selectedTimeframe) {
                            ForEach(timeframes.indices, id: \.self) { index in
                                Text(self.timeframes[index])
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding([.leading, .trailing])

                        // Placeholder for chart
                        Rectangle()
                            .fill(Color.gray)
                            .frame(height: 200)
                            .padding()

                        HStack {
                            Text("$8.33%")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.white)
                            Spacer()
                            Text("+1.6%")
                                .font(.headline)
                                .foregroundColor(.green)
                        }
                        .padding([.leading, .trailing, .bottom])
                    }
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(10)
                    .padding([.leading, .trailing])
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("About This Hive")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding([.leading, .top])

                        HStack {
                            VStack(alignment: .leading) {
                                Text("HOLDINGS")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                HStack {
                                    // Example holdings icons
                                    Image(systemName: "bitcoinsign.circle")
                                        .foregroundColor(.yellow)
                                    Image(systemName: "bitcoinsign.circle")
                                        .foregroundColor(.yellow)
                                }
                            }

                            Spacer()

                            VStack(alignment: .leading) {
                                Text("APR")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text("\(vault.yield, specifier: "%.1f")%")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }

                            Spacer()

                            VStack(alignment: .leading) {
                                Text("RISK RATING")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text(vault.riskRating)
                                    .font(.headline)
                                    .foregroundColor(.green)
                            }
                        }
                        .padding([.leading, .trailing])

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Synthetix V3 Vault")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                                .foregroundColor(.white)
                            Button(action: {
                                // TODO: Learn more about Synthetix
                            }) {
                                Text("Learn More About Synthetix")
                                    .foregroundColor(.yellow)
                            }
                        }
                        .padding([.leading, .trailing, .bottom])

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Panoptic Vault")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                                .foregroundColor(.white)
                            Button(action: {
                                // TODO: Learn more about Panoptic
                            }) {
                                Text("Learn More About Panoptic")
                                    .foregroundColor(.yellow)
                            }
                        }
                        .padding([.leading, .trailing, .bottom])
                    }
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(10)
                    .padding()

                    Button(action: {
                        // TODO: Add to Hive action
                    }) {
                        Text("Add To Apiary")
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.yellow)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
            }
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
        }
        .navigationBarHidden(true)
    }
}
