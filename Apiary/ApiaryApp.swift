import SwiftUI

@main
struct ApiaryApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var showWelcomeView = true
    @State private var isConnected = false
    @State private var showTooltip = false
    @State private var showConnectionPrompt = false

    var body: some Scene {
        WindowGroup {
            Group {
                if showWelcomeView {
                    WelcomeView(showWelcomeView: $showWelcomeView)
                        .transition(.opacity)
                } else {
                    TabView {
                        NavigationView {
                            VStack {
                                TopBarView(isConnected: $isConnected, showTooltip: $showTooltip, showConnectionPrompt: $showConnectionPrompt)
                                HomeView(isConnected: $isConnected, showTooltip: $showTooltip, showConnectionPrompt: $showConnectionPrompt)
                            }
                        }
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                        
                        NavigationView {
                            VStack {
                                TopBarView(isConnected: $isConnected, showTooltip: $showTooltip, showConnectionPrompt: $showConnectionPrompt)
                                YieldVaultsView(isConnected: $isConnected, showTooltip: $showTooltip, showConnectionPrompt: $showConnectionPrompt)
                            }
                        }
                        .tabItem {
                            Image(systemName: "circle.grid.hex")
                            Text("My Apiary")
                        }
                        
                        NavigationView {
                            VStack {
                                TopBarView(isConnected: $isConnected, showTooltip: $showTooltip, showConnectionPrompt: $showConnectionPrompt)
                                Text("Hives")
                            }
                        }
                        .tabItem {
                            Image(systemName: "hexagon.fill")
                            Text("Hives")
                        }
                    }
                    .transition(.opacity)
                }
            }
            .animation(.easeInOut(duration: 0.5), value: showWelcomeView)
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
