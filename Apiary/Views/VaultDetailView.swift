import SwiftUI

struct VaultDetailView: View {
    let vault: Vault

    @Environment(\.presentationMode) var presentationMode
    @Binding var isConnected: Bool

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
                    Text("MY POSITION")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding([.top, .leading])
                    
                    HStack {
                        Text("$0.00") // TODO: replace with actual data
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        HStack {
                            if isConnected {
                                Button(action: {
                                    // TODO: Add buy action
                                }) {
                                    Image("pollinate")
                                        .resizable()
                                        .frame(width: 32, height: 32)
                                }
                                Text("POLLINATE")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .padding(.trailing)
                                
                                Button(action: {
                                    // TODO: Add sell action
                                }) {
                                    Image("harvest")
                                        .resizable()
                                        .frame(width: 32, height: 32)
                                }
                                Text("HARVEST")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                            } else {
                                Image("pollinate")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .opacity(0.2)
                                Text("POLLINATE")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .padding(.trailing)

                                Image("harvest")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .opacity(0.2)
                                Text("HARVEST")
                                    .font(.subheadline)
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
                    
                    TimeframePickerView().padding()
                    
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
                            .font(.system(size: 24).bold())
                            .foregroundColor(.white)
                            .padding([.leading, .top, .bottom])
                        
                        Spacer()
                        
                        HStack(alignment: .center) {
                            Text("Chain:")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            Image("base")
                                .resizable()
                                .frame(width: 16, height: 16, alignment: .leading)
                            Text("Base Sepolia")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        .padding(.trailing, 20)
                    }
                    
                    HStack(alignment: .top, spacing: 28) {
                        VStack(alignment: .leading) {
                            Text("Flowers")
                                .font(.caption)
                                .foregroundColor(.gray)
                            ZStack {
                                Image("pan")
                                    .resizable()
                                    .frame(width: 28, height: 28)
                                    .offset(x: 18)
                                Image("snx")
                                    .resizable()
                                    .frame(width: 28, height: 28)
                                    .offset(x: -2)
                            }
                            .frame(width: 34, height: 28)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("Estimated APR")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("\(vault.yield, specifier: "%.0f")%")
                                .font(.system(size: 28).bold())
                                .foregroundColor(.white)
                                .frame(width: 60, height: 28, alignment: .leading)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
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
