import SwiftUI

struct VaultItemView: View {
    let vault: Vault

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(vault.name)
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                if vault.name != "New Hives Coming Soon" {
                    Button(action: {
                        // Add Vault action
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.yellow)
                    }
                }
            }
            .padding(.bottom, 10)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("HOLDINGS")
                        .font(.caption)
                        .foregroundColor(.gray)
                    HStack {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.blue)
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.purple)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading) {
                    Text("APR")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("\(vault.yield, specifier: "%.2f")%")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading) {
                    Text("RISK RATING")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(vault.riskRating)
                        .font(.headline)
                        .foregroundColor(.green)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                NavigationLink(destination: VaultDetailView(vault: vault)) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}
