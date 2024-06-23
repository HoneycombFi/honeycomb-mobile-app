import SwiftUI

struct VaultDetailView: View {
    let vault: Vault

    @Environment(\.presentationMode) var presentationMode
    @Binding var isConnected: Bool
    @Binding var showConnectionPrompt: Bool
    @State private var selectedTimeframe = 0
    let timeframes = ["1D", "1W", "1M", "YTD", "1Y", "ALL"]

    var body: some View {
        VStack(alignment: .leading) {
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
                
                Text(vault.name)
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .padding([.top, .bottom, .trailing])
                
                Spacer()
            }
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text("MY BALANCE")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.leading)
                    
                    HStack {
                        Text("$44.00") // TODO: replace with actual data
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        HStack {
                            if isConnected {
                                Button(action: {
                                    // TODO: Add buy action
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.yellow5)
                                        .font(.title)
                                }
                                Text("BUY")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                Button(action: {
                                    // TODO: Add sell action
                                }) {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.yellow5)
                                        .font(.title)
                                }
                                Text("SELL")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            } else {
                                Button(action: {}) {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.gray)
                                        .font(.title)
                                        .opacity(0.2)
                                    
                                }
                                .disabled(true)
                                
                                Text("BUY")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                Button(action: {}) {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.gray)
                                        .font(.title)
                                        .opacity(0.2)
                                    
                                }
                                .disabled(true)
                                Text("SELL")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                VStack(alignment: .leading) {
                    Text("Apiary Hive Performance")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding([.leading, .top, .trailing])
                    
                    TimeframePicker().padding()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                            .fill(Color.gray13)
                            .frame(height: 200)
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
                }
                .background(Color.gray13)
                .cornerRadius(10)
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("About This Hive")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding([.leading, .top, .bottom])
                        
                        Spacer()
                        
                        Text("Chain: 🟦 Base")
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding([.trailing, .top, .bottom])
                    }
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("HOLDINGS")
                                .font(.caption)
                                .foregroundColor(.gray)
                            HStack {
                                // TODO: holdings icons
                                Image(systemName: "bitcoinsign.circle")
                                    .foregroundColor(.yellow5)
                                Image(systemName: "bitcoinsign.circle")
                                    .foregroundColor(.yellow5)
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
                    .padding([.leading, .trailing, .bottom])
                    
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
                                .foregroundColor(.yellow5)
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
                                .foregroundColor(.yellow5)
                        }
                    }
                    .padding([.leading, .trailing, .bottom])
                }
                .background(Color.gray13)
                .cornerRadius(10)
                .padding()
            }
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
        }
        .navigationBarHidden(true)
    }
}
