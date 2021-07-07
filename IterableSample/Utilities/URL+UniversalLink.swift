//
//  URL+UniversalLink.swift
//  IterableSample
//
//  Created by Christina Schell on 6/30/21.
//

import Foundation

enum TabIdentifier: Hashable {
  case home, events
}

extension URL {
  var isDeeplink: Bool {
    return scheme?.lowercased() == "iterablesampleios" || self.absoluteString.contains("schellyapps.com")
  }

  var tabIdentifier: TabIdentifier? {
    guard isDeeplink else { return nil }
    switch true {
    case self.absoluteString.contains("events"): return .events
    default: return .home
    }
  }
    
}


