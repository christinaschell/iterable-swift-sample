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

}

