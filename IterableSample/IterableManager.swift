//
//  IterableManager.swift
//  IterableSample
//
//  Created by Christina Schell on 5/11/21.
//

import SwiftUI
import UserNotifications
import IterableSDK

public protocol IterableNotifier {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
}

class IterableManager {

    static let shared = IterableManager()

    static let config = IterableConfig()

    private init() { }

    class func start(with launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) {
        IterableAPI.initialize(apiKey: Tokens.apiKey,
                               launchOptions: launchOptions,
                               config: config)
//          { success in
//            guard success else {
//                return
//            }
            IterableAPI.email = Tokens.email
//        }
    }
    
    class func updateUser(with fields: [String: Any]) {
        IterableAPI.updateUser(fields, mergeNestedObjects: true)
    }
    
    class func track(event name: String, data: [String: Any]? = nil) {
        IterableAPI.track(event: name, dataFields: data)
    }
    
    class func track(purchase: NSNumber, items: CommerceItems, data: [String: Any]? = nil) {
        guard let items = items as? [CommerceItem] else {
            return
        }
        IterableAPI.track(purchase: purchase, items: items, dataFields: data)
    }
    
    class func track(pushOpen info: [String: Any]) {
        IterableAPI.track(pushOpen: info)
    }
    
    class func register(token: Data) {
        IterableAPI.register(token: token)
    }
    
    class func didReceiveRemoteNotification(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        IterableAppIntegration.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
    }
    
    class func didReceiveDeeplink(with url: URL) {
        IterableAPI.handle(universalLink: url)
    }

}

extension IterableManager: IterableNotifier {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        IterableAppIntegration.userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
    }
}

// https://support.iterable.com/hc/en-us/articles/360035536791-In-App-Messages-on-iOS-
// TODO: Set up custom URL and Action delegates
class CustomIterableAppDelegate: IterableInAppDelegate {
    
    // Overriding default behavior for certain messages
    func onNew(message: IterableInAppMessage) -> InAppShowResponse {
        if message.messageId == "messgageToSkip" {
            return .skip
        }
        return .show
    }
}


