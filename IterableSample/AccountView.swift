//
//  AccountView.swift
//  IterableSample
//
//  Created by Christina Schell on 5/11/21.
//

import SwiftUI
import SchellySwiftUI

struct AccountView: View {
    var body: some View {
        VStack {
            Image("iterable")
                .padding(.bottom, 20)
            SchellyTextButton(title: "Send Custom Event", backgroundColor: .lightGreen, foregroundColor: .white) {
                IterableManager.trackEvent("mobileSATestEvent", data: [
                    "platform": "iOS",
                    "isTestEvent": true,
                    "url": "https://iterable.com/sa-test/Christina",
                    "secret_code_key": "Code_123"
                ])
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
