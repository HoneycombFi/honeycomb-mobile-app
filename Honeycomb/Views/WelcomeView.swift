import SwiftUI

struct WelcomeView: View {
    @Binding var showWelcomeView: Bool
    @Binding var isConnected: Bool
    
    @State private var isCreatingWallet = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {

            Spacer()

            Button(action: createWalletAndContinue) {
                if isCreatingWallet {
                    HStack(alignment: .center) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .padding(.horizontal)
                        Text("Creating account...")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(10)
                    .padding(.horizontal)
                } else {
                    Text("Get Started")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            .padding(.bottom, 80)
            .disabled(isCreatingWallet)
        }
        .background(
            Image("splash")
                .resizable()
                .scaledToFill()
        )
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private func createWalletAndContinue() {
        isCreatingWallet = true
        Task {
            do {
                _ = try await WalletManager.shared.createWallet()
                withAnimation {
                    showWelcomeView = false
                    isConnected = true
                }
            } catch {
                alertMessage = "Failed to create wallet: \(error.localizedDescription)"
                showAlert = true
            }
            isCreatingWallet = false
        }
    }
}
