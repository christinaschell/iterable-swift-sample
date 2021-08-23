//
//  Deeplinker.swift
//  IterableSample
//
//  Created by Christina Schell on 7/9/21.
//

import SwiftUI

typealias TabIdentifier = Deeplinker.Deeplink

class AppState: ObservableObject {
    @Published var selectedTab: TabIdentifier = .home
    @Published var selectedDonut: Int?
}

class Deeplinker {
    
    enum Deeplink: Equatable, Hashable {
        case home
        case events
        case products
        case details(reference: Int)
        case inbox
    }
    
    @discardableResult
    func manage(url: URL) -> Deeplink? {
        switch true {
        case url.absoluteString.contains("mobileinbox"): return .inbox
        case url.absoluteString.contains("events"): return .events
        default:
            guard url.scheme?.lowercased() == URL.appScheme || url.absoluteString.contains("schellyapps.com") else { return nil }
            guard url.pathComponents.contains(URL.appDetailsPath) else { return .home }
            guard url.absoluteString.contains(".html") else { return .products }
            
            guard let donut = url.absoluteString.components(separatedBy: ".html").first?.split(separator: "/").last else {
                return .products
            }
            
            guard let donutType = DonutType(from: String(donut)) else {
                return nil
            }
            
            return .details(reference: donutType.rawValue)
        }
    }
    
    public func handle(_ url: URL) -> (tab: TabIdentifier, donut: Int?) {
        let selection = Deeplinker().manage(url: url)
        if case let .details(reference) = selection {
            return (tab: .products, donut: reference)
        } else if let selection = selection {
            return (tab: selection, donut: nil)
        } else {
            return (tab: .home, donut: nil)
        }
    }
    
    enum DonutType: Int {
        //https://schellyapps.com/products/[donut].html
        case oldfashioned = 1, glazed, icedsprinkles, maplebar, jelly, applefritter
        
        init?(from string: String) {
            switch string {
            case "oldfashioned":
                self = .oldfashioned
            case "glazed":
                self = .glazed
            case "icedsprinkles":
                self = .icedsprinkles
            case "maplebar":
                self = .maplebar
            case "jelly":
                self = .jelly
            case "applefritter":
                self = .applefritter
            default:
                return nil
            }
        }
        
    }
    
}
