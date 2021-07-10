//
//  Donut.swift
//  IterableUIKitSample
//
//  Created by Christina Schell on 7/7/21.
//

import Foundation

typealias Donuts = [Donut]

struct Donut: Codable, Identifiable {
    var id: Int
    var name: String
    var price: Double
    var image: String
}

extension Donuts {
    static let all = Bundle.main.decode(Donuts.self, from: "donuts.json")
}
