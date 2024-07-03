import SwiftUI

enum TransactionState {
    case checkingApproval, approving, depositingToHive, pollinatingFlower, transactionComplete
}

struct TransactionView: View {
    @Binding var isPresented: Bool
    @Binding var transactionState: TransactionState
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    @State private var transactionHashes: [String] = []

    let handleTransaction: () async throws -> [String]

    var body: some View {
        NavigationView {
            VStack {
                if showError {
                    VStack {
                        Image(systemName: "xmark.octagon.fill")
                            .foregroundColor(.red)
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.red)
                            .padding()
                            .multilineTextAlignment(.center)
                    }
                } else {
                    VStack {
                        Spacer()
                        ProgressView(statusText)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                    }

                    List {
                        ForEach(transactionHashes, id: \.self) { hash in
                            TransactionCardView(transactionHash: hash, transactionState: transactionState)
                        }
                    }
                }
            }
        }
        .onAppear {
            Task {
                await startTransaction()
            }
        }
    }

    private var statusText: String {
        switch transactionState {
        case .checkingApproval:
            return "Checking approval..."
        case .approving:
            return "Approving..."
        case .depositingToHive:
            return "Depositing to Hive..."
        case .pollinatingFlower:
            return "Pollinating flower..."
        case .transactionComplete:
            return "Transaction Complete!"
        }
    }

    private func startTransaction() async {
        do {
            transactionState = .checkingApproval
            let hashes = try await handleTransaction()
            transactionHashes = hashes
            transactionState = .transactionComplete
        } catch {
            showError = true
            errorMessage = error.localizedDescription
        }
    }
}

struct TransactionCardView: View {
    var transactionHash: String
    var transactionState: TransactionState

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "link.circle")
                    .foregroundColor(.blue)
                Link(transactionName, destination: URL(string: "https://sepolia.basescan.org/tx/\(transactionHash)")!)
                    .foregroundColor(.blue)
            }
            if transactionState == .transactionComplete {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Text("Transaction Complete!")
                        .foregroundColor(.green)
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
        .padding(.bottom, 10)
    }

    private var transactionName: String {
        switch transactionState {
        case .checkingApproval:
            return "Checking approval"
        case .approving:
            return "Approving"
        case .depositingToHive:
            return "Depositing to Hive"
        case .pollinatingFlower:
            return "Pollinating flower"
        case .transactionComplete:
            return "Transaction Complete"
        }
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView(
            isPresented: .constant(true),
            transactionState: .constant(.checkingApproval),
            handleTransaction: {
                // Mock implementation for preview
                return ["0x12345", "0x67890"]
            }
        )
    }
}
