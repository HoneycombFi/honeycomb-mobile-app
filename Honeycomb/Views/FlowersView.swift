import SwiftUI

struct FlowersView: View {
    @Binding var isConnected: Bool
    @Binding var showConnectionPrompt: Bool

    let flowers = [
        Flower(name: "Synthetix Flower", logo: "synthetix", yield: 21.92, info: "Some information about this vault."),
        Flower(name: "Aerodrome Flower", logo: "aerodrome", yield: 12.4, info: "Some information about this vault."),
        Flower(name: "Beefy Flower", logo: "beefy", yield: 9.08, info: "Some information about this vault."),
        Flower(name: "Panoptic Flower", logo: "panoptic", yield: 6.70, info: "Some information about this vault."),
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
                        ForEach(flowers) { flower in
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
    }
}
