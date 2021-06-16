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
                IterableManager.track(event: "Custom Event 1", data: [
                    "platform": "iOS",
                    "custom_key": true
                ])
            }
            SchellyTextButton(title: "Product View",
                              backgroundColor: .lightBlue,
                              foregroundColor: .white) {
                 IterableManager.track(event: "Product View", data: [
                     "item_id": CommerceItems.productView.map(\.id),
                     "item_name": CommerceItems.productView.map(\.name),
                     "item_price": CommerceItems.productView.map(\.price)
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
             SchellyTextButton(title: "Track Purchase",
                               backgroundColor: .darkPurple,
                               foregroundColor: .white) {
                 IterableManager.track(purchase: 20.96, items: CommerceItems.productView, data: [
                     "is_rewards_member": true,
                     "rewards_available": 11200,
                     "order_discount_code": "Summer2021"
                 ])
             }
            SchellyTextButton(title: "Mobile Inbox",
                              backgroundColor: .lightGreen,
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
