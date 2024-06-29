import SwiftUI

struct FlowersView: View {
    @Binding var isConnected: Bool
    @Binding var showConnectionPrompt: Bool
    @StateObject private var viewModel = FlowersViewModel()

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
                        ForEach(viewModel.flowers) { flower in
                            FlowerCellView(flower: flower, isConnected: $isConnected, showConnectionPrompt: $showConnectionPrompt)
                                .padding(.horizontal)
                        }
                        EmptyFlowerCell()
                    }
                    .frame(maxWidth: .infinity)
                }
                .background(Color.black)
                .edgesIgnoringSafeArea(.all)
                .blur(radius: showConnectionPrompt ? 5 : 0)
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            viewModel.fetchFlowerBalances(walletAddress: UserDefaults.standard.string(forKey: "walletAddress") ?? "0x")
        }
    }
}
