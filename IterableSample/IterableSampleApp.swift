//
//  IterableSampleApp.swift
//  IterableSample
//
//  Created by Christina Schell on 5/11/21.
//

import SwiftUI

@main
struct IterableSampleApp: App {
    @StateObject var appState = AppState()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $appState.selectedTab) {
                HomeView()
                    .tabItem {
                        VStack {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                    }
                    .environmentObject(appState)
                    .tag(TabIdentifier.home)
                EventsView()
                    .tabItem {
                        VStack {
                            Image(systemName: "dot.radiowaves.left.and.right")
                            Text("Events")
                        }
                    }
                    .environmentObject(appState)
                    .tag(TabIdentifier.events)
                DonutListView()
                    .tabItem {
                        VStack {
                            Image(systemName: "cart.fill")
                            Text("Shop")
                        }
                    }
                    .environmentObject(appState)
                    .tag(TabIdentifier.products)
                MobileInboxView()
                    .tabItem {
                        VStack {
                            Image(systemName: "envelope.fill")
                            Text("Messages")
                        }
                    }
                    .tag(TabIdentifier.inbox)
            }
            .accentColor(.darkPurple)
            .onOpenURL { url in
                print("url: \(url)")
                let state = Deeplinker().handle(url)
                appState.selectedTab = state.tab
                appState.selectedDonut = state.donut
                IterableManager.didReceiveUniversalLink(with: url)
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        IterableManager.shared.start(with: launchOptions)
        UNUserNotificationCenter.current().delegate = self
        //setupNotifications()
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("😀 device token: \(token)")
        IterableManager.register(token: deviceToken)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        IterableManager.didReceiveRemoteNotification(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
    }
    
//    private func setupNotifications() {
//        UNUserNotificationCenter.current().delegate = self
//        UNUserNotificationCenter.current().getNotificationSettings { settings in
//            if settings.authorizationStatus != .authorized {
//                // not authorized, ask for permission
//                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, _ in
//                    if success {
//                        DispatchQueue.main.async {
//                            UIApplication.shared.registerForRemoteNotifications()
//                        }
//                    }
//                    // TODO: Handle error etc.
//                }
//            } else {
//                // already authorized
//                DispatchQueue.main.async {
//                    UIApplication.shared.registerForRemoteNotifications()
//                }
//            }
//        }
//    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    public func userNotificationCenter(_: UNUserNotificationCenter, willPresent _: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound])
    }

    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        IterableManager.userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
    }
}
