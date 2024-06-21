import SwiftUI

struct VaultItemView: View {
    let vault: Vault
    @Binding var isConnected: Bool
    @Binding var showTooltip: Bool
    @Binding var showConnectionPrompt: Bool

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(vault.name)
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                if vault.name != "New Hives Coming Soon" {
                    if isConnected {
                        Button(action: {
                            // TODO: add Vault action
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 28, height: 28)
                                .foregroundColor(.yellow)
                        }
                    } else {
                        Button(action: {}) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 28, height: 28)
                                .foregroundColor(.gray)
                                .opacity(0.2)
                        }
                        .disabled(true)
                    }
                }
            }
            .padding(.bottom, 10)
            
            Text("Chain: 🟦 Base")
                .font(.caption2)
                .foregroundColor(.white)
                .padding(.bottom, 10)
            
            Divider().background(Color.gray)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("HOLDINGS")
                        .font(.caption)
                        .foregroundColor(.gray)
                    ZStack {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .foregroundColor(.purple)
                            .offset(x: 18)
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .foregroundColor(.blue)
                            .offset(x: -2)
                    }
                    .frame(width: 34, height: 28)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading) {
                    Text("APR")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("\(vault.yield, specifier: "%.0f")%")
                        .font(.system(size: 28).bold())
                        .foregroundColor(.white)
                        .frame(width: 60, height: 28, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading) {
                    Text("RISK RATING")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(.green)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                NavigationLink(destination: VaultDetailView(vault: vault, isConnected: $isConnected, showTooltip: $showTooltip, showConnectionPrompt: $showConnectionPrompt)) {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .frame(height: 20)
                        .padding(.top, 20)
                }
            }
            .padding(.bottom, 10)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}
