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
    
    static let customLogger = CustomLogger()
    
    var userEmail: String {
        get {
            IterableAPI.email ?? ""
        }
        set {
            IterableAPI.email = newValue
        }
    }
    
    var userId: String {
        get {
            IterableAPI.userId ?? ""
        }
        set {
            IterableAPI.email = newValue
        }
    }

    private init() { }

    func start(with launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) {
        config.logDelegate = IterableManager.customLogger
        IterableAPI.initialize(apiKey: Tokens.apiKey,
                               launchOptions: launchOptions,
                               config: config)
        IterableAPI.email = userEmail
    }
    
    class func updateUser(with fields: [String: Any]) {
        IterableAPI.updateUser(fields, mergeNestedObjects: true)
        log(event: "updateUser", payload: fields)
    }
    
    class func track(event name: String, data: [String: Any]? = nil) {
        IterableAPI.track(event: name, dataFields: data)
        log(event: name, payload: data ?? [String: Any]())
    }
    
    // TODO: update cart
    
    class func track(purchase: NSNumber, items: CommerceItems, data: [String: Any]? = nil) {
        guard let items = items as? [CommerceItem] else {
            return
        }
        IterableAPI.track(purchase: purchase, items: items, dataFields: data)
        log(event: "purchase", payload: data ?? [String: Any]())
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
    
    private class func log(event name: String, payload: [String: Any], message: String? = nil) {
        let message = CustomLogger.add(event: name, and: payload)
        customLogger.log(level: .info, message: message)
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

class CustomLogger: IterableLogDelegate {
    func log(level: LogLevel, message: String) {
        // Should probably make `os_log` instead of `print`
        print(markedMessage(level: level, message: message))
    }
    
    static func add(event name: String, and payload: [String: Any], to message: String? = nil) -> String {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: payload, options: []),
              let jsonString = String(data: jsonData, encoding: String.Encoding.ascii) else {
            return message ?? ""
        }
        return "\(message ?? "")\n===========================\neventName: \(name)\npaylaod: \(jsonString)"
    }
    
    func markedMessage(level: LogLevel, message: String) -> String {
        let markerStr = marker(forLevel: level)
        return "\(markerStr) \(message)"
    }
    
    func marker(forLevel level: LogLevel) -> String {
        switch level {
        case .error:
            return "CustomLogger 🛑"
        case .info:
            return "CustomLogger ℹ️"
        case .debug:
            return "CustomLogger 🐛"
        }
    }
}
