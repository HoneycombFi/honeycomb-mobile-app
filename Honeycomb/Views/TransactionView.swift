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
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    VStack {
                        Spacer()
                        ProgressView(statusText)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                    }

                    List(transactionHashes, id: \.self) { hash in
                        Link("View Transaction \(hash)", destination: URL(string: "https://sepolia.basescan.org/tx/\(hash)")!)
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
            return "Transaction Complete"
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
