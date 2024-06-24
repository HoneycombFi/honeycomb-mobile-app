import SwiftUI

@main
struct ApiaryApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var showWelcomeView: Bool
    @State private var isConnected: Bool
    @State private var showConnectionPrompt = false
    @State private var selectedTab = 0

    init() {
        if let _ = WalletManager.shared.getSavedWalletAddress() {
            _isConnected = State(initialValue: true)
            _showWelcomeView = State(initialValue: false)
        } else {
            _isConnected = State(initialValue: false)
            _showWelcomeView = State(initialValue: true)
        }
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                Group {
                    if showWelcomeView {
                        WelcomeView(showWelcomeView: $showWelcomeView)
                            .transition(.opacity)
                    } else {
                        VStack {
                            TopBarView(isConnected: $isConnected, showConnectionPrompt: $showConnectionPrompt)
                            TabView(selection: $selectedTab) {
                                HomeView(isConnected: $isConnected, showConnectionPrompt: $showConnectionPrompt, selectedTab: $selectedTab)
                                    .tabItem {
                                        Image(systemName: "house.fill")
                                        Text("Home")
                                    }
                                    .tag(0)
                                
                                ApiaryView(isConnected: $isConnected, showConnectionPrompt: $showConnectionPrompt, selectedTab: $selectedTab)
                                    .tabItem {
                                        Image(systemName: "circle.grid.hex")
                                        Text("My Apiary")
                                    }
                                    .tag(1)
                                
                                HivesView(isConnected: $isConnected, showConnectionPrompt: $showConnectionPrompt)
                                    .tabItem {
                                        Image(systemName: "hexagon.fill")
                                        Text("Hives")
                                    }
                                    .tag(2)
                            }
                        }
                        .transition(.opacity)
                    }
                }
                .animation(.easeInOut(duration: 0.5), value: showWelcomeView)
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // handle other types of deep links
        return false
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundEffect = UIBlurEffect(style: .systemMaterial)
        appearance.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        return true
    }
}
