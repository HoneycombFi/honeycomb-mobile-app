# Apiary

Apiary is an iOS app that lets you earn passive income from ERC-4626 yield-bearing vaults.

_This project was built during the Base Onchain Summer buildathon._

## Overview

Apiary aims to simplify DeFi by providing an intuitive mobile interface for interacting with aggregator vaults on Ethereum. We're on a mission to make DeFi easier for everyone by abstracting away as much of the Web3 jargon and financial complexity as possible.

Please note this is an experimental proof-of-concept application that runs on the Base Sepolia test network. No real ETH or funds are used and it is under active development.

## Prerequisites

Ensure you have the following installed:

- [Xcode](https://developer.apple.com/xcode/) (Version 12.0 or later)
- macOS 10.15.7 or later

## Installation

1. **Clone the Repository**

   ```bash
   git clone <repository-url>
   cd ApiaryApp
   ```

2. **Open the Project in Xcode**

   ```bash
   open ApiaryApp.xcodeproj
   ```

3. **Install Dependencies**

   - Xcode should automatically resolve and download the necessary dependencies via Swift Package Manager (SPM). If it doesn't, manually update the packages through Xcode:
     1. Open Xcode.
     2. Select your project in the Project Navigator.
     3. Select the `Swift Packages` tab.
     4. Click the `+` button to add or update packages.

4. **Configure Signing & Capabilities**

   - In Xcode, select the `ApiaryApp` project.
   - Select the `ApiaryApp` target.
   - Go to the `Signing & Capabilities` tab.
   - Ensure a valid `Team` is selected under the `Signing` section.
   - Ensure the `Bundle Identifier` is unique.

5. **Build and Run the Project**
   - Select the target device (simulator or physical device).
   - Click the `Run` button (or press `Cmd + R`) to build and run the project.

## Usage

Upon running the app, you can:

- Connect your wallet to Base Sepolia.
- View your portfolio balance.
- Deposit and withdraw into (test) yield vaults.
- Navigate through different tabs (Home, My Apiary, Hives).

## Project Structure

- `ApiaryApp.swift`: The main entry point of the app.
- `HomeView.swift`: The main view for the home screen.
- `ApiaryView.swift`: The view for managing hives in the apiary.
- `PortfolioBalanceView.swift`: The view displaying the user's portfolio balance.
- `ConnectWalletView.swift`: The view prompting the user to connect their wallet.
- `VaultItemView.swift`: The view displaying individual vault items.

## Support

If you encounter any issues or have any questions, please open an issue in the repository or contact the project maintainers.

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.
