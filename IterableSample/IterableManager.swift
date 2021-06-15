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

    class func start(with launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) {
        IterableAPI.initialize(apiKey: Tokens.apiKey,
                               launchOptions: launchOptions,
                               config: config)
        IterableAPI.email = Tokens.email
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
    
    class func didReceiveRemoteNotification(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        IterableAppIntegration.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
    }

}
