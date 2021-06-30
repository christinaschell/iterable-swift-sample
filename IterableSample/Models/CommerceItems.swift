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
    
    static let purchase = [CommerceItem(id: "item1", name: "Item 1", price: 2.99, quantity: 2),
                           CommerceItem(id: "item2", name: "Item 2", price: 5.99, quantity: 1)]
    
}

extension CommerceItem: CommerceItemTrackable { }

public struct Item: Codable {
    public var id: String
    public var name: String
    public var price: Double
    public var quantity: Int
}

public typealias Items = [Item]

public extension Items {
    
    static let listView = [Item(id: "item1", name: "Item 1", price: 2.99, quantity: 1),
                           Item(id: "item2", name: "Item 2", price: 5.99, quantity: 1),
                           Item(id: "item3", name: "Item 3", price: 8.99, quantity: 1),
                           Item(id: "item4", name: "Item 4", price: 1.99, quantity: 1),
                           Item(id: "item5", name: "Item 5", price: 7.99, quantity: 1),
                           Item(id: "item6", name: "Item 6", price: 9.99, quantity: 1),
                           Item(id: "item7", name: "Item 7", price: 6.99, quantity: 1)].map { $0.dictionary }
    
    static let addToCart = [Item(id: "item1", name: "Item 1", price: 2.99, quantity: 2),
                            Item(id: "item2", name: "Item 2", price: 5.99, quantity: 1),
                            Item(id: "item3", name: "Item 3", price: 8.99, quantity: 1)].map { $0.dictionary }
    
    static let removeFromCart = [Item(id: "item3", name: "Item 3", price: 8.99, quantity: 1)].map { $0.dictionary }
    
}
