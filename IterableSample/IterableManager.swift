//
//  IterableManager.swift
//  IterableSample
//
//  Created by Christina Schell on 5/11/21.
//

import SwiftUI
import IterableSDK

class IterableManager {

    static let shared = IterableManager()

    static let config = IterableConfig()

    private init() { }

    static public func start(with launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) {
        IterableAPI.initialize(apiKey: Tokens.apiKey,
                               launchOptions: launchOptions,
                               config: config)
        IterableAPI.email = Tokens.email
    }
    
    class func updateUser(with fields: [String: Any]) {
        IterableAPI.updateUser(fields, mergeNestedObjects: true)
    }
    
    class func trackEvent(_ name: String, data: [String: Any]? = nil) {
        IterableAPI.track(event: name, dataFields: data)
    }
    
    class func didReceiveRemoteNotification(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        IterableAppIntegration.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
    }
    
    class func didReceiveDeeplink(with url: URL) {
        IterableAPI.handle(universalLink: url)
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

