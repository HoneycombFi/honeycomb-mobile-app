import SwiftUI

struct WelcomeView: View {
    @Binding var showWelcomeView: Bool
    
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

            Button(action: {
                withAnimation {
                    showWelcomeView = false
                }
            }) {
                Text("Get Started")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .padding(.bottom, 50)
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
    }
}
