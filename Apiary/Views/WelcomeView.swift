import SwiftUI

struct WelcomeView: View {
    @Binding var showWelcomeView: Bool
    @State private var isCreatingWallet = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            Spacer()
            VStack {
                HStack {
                    Image(systemName: "circle.grid.hex")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)

                    Text("APIARY")
                        .font(.title)
                        .foregroundColor(.black)
                }.padding(.top, 50)
                
                Text("Let's Build Your Hive")
                    .font(.system(size: 42, weight: .bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.top, 100)
                    .frame(width: 250)
                
                Spacer()
            }

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
            LinearGradient(gradient: Gradient(colors: [Color(hex: "0xFFCB31"), Color(hex: "0xF5A623")]), startPoint: .top, endPoint: .bottom)
                .overlay(
                    Image("honeycomb")
                        .resizable()
                        .scaledToFill()
                        .opacity(0.1)
                )
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
                }
            } catch {
                alertMessage = "Failed to create wallet: \(error.localizedDescription)"
                showAlert = true
            }
            isCreatingWallet = false
        }
    }
}
