import SwiftUI
import BigInt

struct FlowerCellView: View {
    @ObservedObject var viewModel: FlowersViewModel
    let flower: Flower
    @Binding var isConnected: Bool
    @Binding var showConnectionPrompt: Bool
    @State private var walletAddress: String = UserDefaults.standard.string(forKey: "walletAddress") ?? "0x"
    @State private var showTransactionView: Bool = false
    @State private var transactionState: TransactionState = .checkingApproval
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(flower.logo)
                    .resizable()
                    .frame(width: 48, height: 48)
                Text(flower.name)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding(.bottom, 10)
                        
            HStack(alignment: .top) {
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
                    Text("$\(Double(flower.balance)!, specifier: "%.2f")")
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
                
                NavigationLink(destination: FlowerDetailView(flower: flower, isConnected: $isConnected)) {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .frame(height: 20)
                        .padding(.top, 20)
                }
            }
            
            Divider().background(Color.gray).padding([.top, .bottom])
            
            HStack {
                if isConnected {
                    NavigationLink(destination: TransactionView(isPresented: $showTransactionView, transactionState: $transactionState, handleTransaction: {
                        try await viewModel.handlePollinate(flower: flower, transactionState: $transactionState)
                    })) {
                        Image("pollinate")
                            .resizable()
                            .frame(width: 32, height: 32)
                    }
                    Text("POLLINATE")
                        .font(.subheadline)
                        .foregroundColor(.gray6)
                        .padding(.trailing)
                    
                    NavigationLink(destination: TransactionView(isPresented: $showTransactionView, transactionState: $transactionState, handleTransaction: {
                        try await viewModel.handleHarvest(flower: flower)
                    })) {
                        Image("harvest")
                            .resizable()
                            .frame(width: 32, height: 32)
                    }
                    Text("HARVEST")
                        .font(.subheadline)
                        .foregroundColor(.gray6)
                } else {
                    // Disabled state UI
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
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

struct EmptyFlowerCell: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 0.098, green: 0.098, blue: 0.098))
                .shadow(color: Color.black.opacity(0.2), radius: 32, x: 0, y: 0)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("New Flowers Coming Soon")
                        .foregroundColor(.white)
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Image("harvest")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(.gray)
                        .opacity(0.2)
                }
                .padding(.horizontal, 16)
                
                Spacer()
                
                HStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 100, height: 10)
                    
                    Spacer()
                }
                .padding([.bottom, .horizontal], 16)
                
                Divider()
                    .background(Color.gray)
                    .opacity(0.2)
                    .padding([.bottom, .horizontal], 16)

                HStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 80, height: 10)
                    
                    Spacer()
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 40, height: 10)
                    
                    Spacer()
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 80, height: 10)
                }
                .padding(.horizontal, 16)
                
                Spacer()
            }
            .padding(.vertical, 16)
        }
        .padding(.horizontal, 16)
        .padding(.top, 2)
        .padding(.bottom, 20)
    }
}

struct NoBalanceFlowerView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 0.098, green: 0.098, blue: 0.098))
                .shadow(color: Color.black.opacity(0.2), radius: 32, x: 0, y: 0)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("No Flower Balance")
                        .foregroundColor(.white)
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Image("pollinate")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(.gray)
                        .opacity(0.2)
                }
                .padding(.horizontal, 16)
                
                Spacer()
                
                HStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 100, height: 10)
                    
                    Spacer()
                }
                .padding([.bottom, .horizontal], 16)
                
                Divider()
                    .background(Color.gray)
                    .opacity(0.2)
                    .padding([.bottom, .horizontal], 16)

                HStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 80, height: 10)
                    
                    Spacer()
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 40, height: 10)
                    
                    Spacer()
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 80, height: 10)
                }
                .padding(.horizontal, 16)
                
                Spacer()
                
                Text("Pollinate your first flower to see the balance here.")
                    .foregroundColor(.white)
                    .font(.caption)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
            }
            .padding(.vertical, 16)
        }
        .padding(.horizontal, 16)
        .padding(.top, 2)
        .padding(.bottom, 20)
    }
}
