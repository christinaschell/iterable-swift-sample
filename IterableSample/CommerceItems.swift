//
//  CommerceItems.swift
//  IterableSample
//
//  Created by Christina on 6/14/21.
//

import Foundation
import IterableSDK

public protocol CommerceItemTrackable {
    var id: String { get set }
    var name: String { get set }
    var price: NSNumber { get set }
    var quantity: UInt { get set }
}

public typealias CommerceItems = [CommerceItemTrackable]

public extension CommerceItems {
    
    static let productView = [CommerceItem(id: "item1", name: "Item 1", price: 2.99, quantity: 1),
                              CommerceItem(id: "item2", name: "Item 2", price: 5.99, quantity: 1),
                              CommerceItem(id: "item3", name: "Item 3", price: 8.99, quantity: 1),
                              CommerceItem(id: "item4", name: "Item 4", price: 1.99, quantity: 1),
                              CommerceItem(id: "item5", name: "Item 5", price: 7.99, quantity: 1),
                              CommerceItem(id: "item6", name: "Item 6", price: 9.99, quantity: 1),
                              CommerceItem(id: "item7", name: "Item 7", price: 6.99, quantity: 1)]
    
    static let addToCart = [CommerceItem(id: "item1", name: "Item 1", price: 2.99, quantity: 2),
                           CommerceItem(id: "item2", name: "Item 2", price: 5.99, quantity: 1),
                           CommerceItem(id: "item3", name: "Item 3", price: 8.99, quantity: 1)]
    
    static let purchase = [CommerceItem(id: "item1", name: "Item 1", price: 2.99, quantity: 2),
                           CommerceItem(id: "item2", name: "Item 2", price: 5.99, quantity: 1),
                           CommerceItem(id: "item3", name: "Item 3", price: 8.99, quantity: 1)]
}

extension CommerceItem: CommerceItemTrackable { }
