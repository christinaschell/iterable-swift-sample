//
//  AccountView.swift
//  IterableSample
//
//  Created by Christina Schell on 5/11/21.
//

import SwiftUI
import SchellySwiftUI

struct AccountView: View {
    @State private var mobileInboxPresented = false
    
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
                 IterableManager.track(event: "Product View", data: [
                     "item_id": CommerceItems.listView.map(\.id),
                     "item_name": CommerceItems.listView.map(\.name),
                     "item_price": CommerceItems.listView.map(\.price)
                 ])
             }
             SchellyTextButton(title: "Add To Cart",
                               backgroundColor: .lightRed,
                               foregroundColor: .white) {
                 CommerceItems.addToCart.forEach {
                     IterableManager.track(event: "Add To Cart", data: [
                         "item_id": $0.id,
                         "item_name": $0.name,
                         "item_price": $0.price,
                         "item_quantity": $0.quantity,
                     ])
                 }
             }
            SchellyTextButton(title: "Remove From Cart",
                              backgroundColor: .darkPurple,
                              foregroundColor: .white) {
                CommerceItems.removeFromCart.forEach {
                    IterableManager.track(event: "Remove From Cart", data: [
                        "item_id": $0.id,
                        "item_name": $0.name,
                        "item_price": $0.price,
                        "item_quantity": $0.quantity,
                    ])
                }
            }
             SchellyTextButton(title: "Track Purchase",
                               backgroundColor: .lightGreen,
                               foregroundColor: .white) {
                IterableManager.track(purchase: 8.98, items: CommerceItems.purchase, data: [
                     "is_rewards_member": true,
                     "rewards_available": 11200,
                     "order_discount_code": "Summer2021"
                 ])
             }
            SchellyTextButton(title: "Mobile Inbox",
                              backgroundColor: .lightBlue,
                              foregroundColor: .white) {
                self.mobileInboxPresented.toggle()
            }
            .sheet(isPresented: $mobileInboxPresented) {
                MobileInboxView()
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
