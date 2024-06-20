import SwiftUI

struct ConnectionPromptView: View {
    @Binding var isConnected: Bool
    @Binding var showConnectionPrompt: Bool

    var body: some View {
        VStack(spacing: 20) {
            Text("Connect to Wallet")
                .font(.title)
                .padding()

            Button(action: {
                // TODO: connect to wallet
                isConnected = true
                showConnectionPrompt = false
            }) {
                Text("Connect")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }

            Button(action: {
                showConnectionPrompt = false
            }) {
                Text("Cancel")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}
