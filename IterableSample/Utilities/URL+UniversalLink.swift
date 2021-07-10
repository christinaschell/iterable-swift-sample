//
//  URL+UniversalLink.swift
//  IterableSample
//
//  Created by Christina Schell on 6/30/21.
//

import Foundation

public extension URL {
    static let appScheme = "iterablesampleios"
    static let appHost = "schellyapps.com"
    static let appHomeUrl = "\(Self.appScheme)://\(Self.appHost)"
    static let appDetailsPath = "products"
}
