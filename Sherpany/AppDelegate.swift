import UIKit
import DataStore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Fetcher.shared.launch()
        window = defaultWindow
    
        return true
    }
    
    // MARK: - Private functions
    
    private var defaultWindow: UIWindow {
        let window = UIWindow()
        window.backgroundColor = .clear
        window.rootViewController = SplitViewController()
        window.makeKeyAndVisible()
        
        return window
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        Fetcher.shared.pullFromNetwork()

    }
}
