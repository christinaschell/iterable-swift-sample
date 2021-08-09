//
//  EventsView.swift
//  IterableSample
//
//  Created by Christina Schell on 5/11/21.
//

import SwiftUI
import SchellySwiftUI

struct EventsView: View {
    
    var body: some View {
        VStack {
            Image("iterable")
                .padding(.bottom, 20)
            SchellyTextButton(title: "Send Custom Event",
                              backgroundColor: .lightGreen,
                              foregroundColor: .white) {
                IterableManager.track(event: "iOS Custom Event", data: [
                    "platform": "iOS",
                    "custom_key": true
                ])
            }
            SchellyTextButton(title: "Product List View",
                              backgroundColor: .lightBlue,
                              foregroundColor: .white) {
                 IterableManager.track(event: "Product List View", data: [
                     "productImpressions": Items.listView
                 ])
             }
             SchellyTextButton(title: "Add To Cart",
                               backgroundColor: .lightRed,
                               foregroundColor: .white) {
                IterableManager.updateUser(with: ["shoppingCartItems": Items.addToCart])
                 IterableManager.track(event: "Add To Cart", data: [
                     "updatedShoppingCartItems": Items.addToCart
                 ])
             }
            SchellyTextButton(title: "Remove From Cart",
                              backgroundColor: .darkPurple,
                              foregroundColor: .white) {
                IterableManager.updateUser(with: ["shoppingCartItems": Items.removeFromCart])
                IterableManager.track(event: "Remove From Cart", data: [
                    "updatedShoppingCartItems": Items.removeFromCart
                ])
            }
             SchellyTextButton(title: "Track Purchase",
                               backgroundColor: .lightPurple,
                               foregroundColor: .white) {
                IterableManager.track(purchase: 8.98, items: CommerceItems.purchase, data: [
                     "is_rewards_member": true,
                     "rewards_available": 11200,
                     "order_discount_code": "Summer2021"
                 ])
             }
        }
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}
