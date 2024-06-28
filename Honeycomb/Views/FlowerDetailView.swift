import SwiftUI

struct FlowerDetailView: View {
    let flower: Flower

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
                
                Image(flower.logo)
                    .resizable()
                    .frame(width: 48, height: 48)
                
                Text(flower.name)
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
                                    .foregroundColor(.gray6)
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
                                    .foregroundColor(.gray6)
                            } else {
                                Image("pollinate")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .opacity(0.2)
                                Text("POLLINATE")
                                    .font(.subheadline)
                                    .foregroundColor(.gray6)
                                    .padding(.trailing)

                                Image("harvest")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .opacity(0.2)
                                Text("HARVEST")
                                    .font(.subheadline)
                                    .foregroundColor(.gray6)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(flower.logo)
                            .resizable()
                            .frame(width: 28, height: 28)
                            .padding([.top, .leading])
                        Text("\(flower.name) Performance")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding([.top, .trailing])
                    }
                    
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
                        Text("About This Flower")
                            .font(.system(size: 24).bold())
                            .foregroundColor(.white)
                            .padding([.leading, .top, .bottom])
                        
                        Spacer()
                    }
                    
                    HStack(alignment: .top, spacing: 28) {
                        VStack(alignment: .leading) {
                            Text("APR")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("\(flower.yield, specifier: "%.0f")%")
                                .font(.system(size: 24).bold())
                                .foregroundColor(.white)
                                .frame(width: 100, height: 28, alignment: .leading)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading) {
                            Text("BALANCE")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("$\(0, specifier: "%.2f")")
                                .font(.system(size: 24).bold())
                                .foregroundColor(.white)
                                .frame(width: 100, height: 28, alignment: .leading)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading) {
                            Text("CHAIN")
                                .font(.caption)
                                .foregroundColor(.gray)
                            HStack(alignment: .center) {
                                Image("base")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("Base")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                            }
                            .frame(height: 28)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding([.leading, .trailing, .bottom])
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image("snx")
                                .resizable()
                                .frame(width: 24, height: 24)
                            Text("Synthetix V3 Vault")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
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
