//
//  IterableManager.swift
//  IterableSample
//
//  Created by Christina Schell on 5/11/21.
//

import SwiftUI
import UserNotifications
import IterableSDK
import Combine

public protocol IterableNotifier {
    static func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
}

class IterableManager {

    static let shared = IterableManager()

    let config = IterableConfig()

    private init() { }

    func start(with launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) {
        IterableAPI.initialize(apiKey: Tokens.apiKey,
                               launchOptions: launchOptions,
                               config: config)
        
        
        IterableAPI.email = Tokens.email
//        IterableManager.updateUser(with: ["userId": "YOUR_USER_ID", "InstallationId": ".."])
    }
    
    class func updateUser(with fields: [String: Any]) {
        IterableAPI.updateUser(fields, mergeNestedObjects: true) { _ in
            print("Iterable User ID: \(String(describing: IterableAPI.userId))")
        }
    }
    
    class func track(event name: String, data: [String: Any]? = nil) {
        IterableAPI.track(event: name, dataFields: data)
    }
    
    // TODO: update cart
    
    class func track(purchase: NSNumber, items: CommerceItems, data: [String: Any]? = nil) {
        guard let items = items as? [CommerceItem] else {
            return
        }
        IterableAPI.track(purchase: purchase, items: items, dataFields: data)
    }
    
    class func register(token: Data) {
        IterableAPI.register(token: token)
    }
    
    class func didReceiveRemoteNotification(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        IterableAppIntegration.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
    }
    
    class func didReceiveUniversalLink(with url: URL) {
        IterableAPI.handle(universalLink: url)
    }

}

extension IterableManager: IterableNotifier {
    class func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        IterableAppIntegration.userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
    }
}

class CustomIterableAppDelegate: IterableInAppDelegate {
    
    // Overriding default behavior for certain messages
    func onNew(message: IterableInAppMessage) -> InAppShowResponse {
        if message.messageId == "messgageToSkip" {
            return .skip
        }
        return .show
    }
}

// TODO: Manage State
class CustomInAppAction: IterableCustomActionDelegate {
    func handle(iterableCustomAction action: IterableAction, inContext context: IterableActionContext) -> Bool {
        return true
    }
}

class CustomInAppUrl: IterableURLDelegate {
  // TODO: to get universal/deep links working from an inapp message
//    let selectedTab = PassthroughSubject<TabIdentifier, Never>()
//    let selectedDonut = PassthroughSubject<Int, Never>()
//
    func handle(iterableURL url: URL, inContext context: IterableActionContext) -> Bool {
//        let state = Deeplinker().handle(url)
//        selectedTab.send(state.tab)
//        if let donut = state.donut {
//            selectedDonut.send(donut)
//        }
        return true
    }
}
