//
//  CustomInboxCellView.swift
//  IterableSample
//
//  Created by Christina Schell on 8/15/21.
//

import SwiftUI
import SchellySwiftUI

struct CustomInboxCellView: View {
    var message: InAppMessageStub
    var body: some View {
        HStack {
            DonutIconImageView(image: message.inboxMetadata.icon)
            VStack(alignment: .leading) {
                Text(message.inboxMetadata.title)
                    .bold()
                Text(message.inboxMetadata.subtitle)
                    .font(.caption2)
            }
            Spacer()
            VStack {
                if let discount = message.customPayload.discount {
                    DiscountView(discount)
                }
                CustomCellButton(message.inboxMetadata.buttonText) {
                    print("button clicked")
                }
            }
        }
        .padding()

    }
}

struct DiscountView: View {
    var discount: String
    init(_ discount: String) { self.discount = discount }
    var body: some View {
        Text(discount)
            .font(.caption)
            .bold()
            .foregroundColor(.lightRed)
    }
}

struct CustomCellButton: View {
    var text: String
    var action: () -> Void
    init(_ text: String,
         _ action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
    var body: some View {
        Button(action: action) {
            PaddedView(text, color: .darkPurple)
        }
    }
}

struct PaddedView: View {
    var text: String
    var color: Color
    init(_ text: String, color: Color) {
        self.text = text
        self.color = color
    }
    var body: some View {
        Text(text)
            .font(.caption)
            .bold()
            .padding(5)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(5)
            .shadow(radius: 2)
    }
}

struct CustomInboxCellView_Previews: PreviewProvider {
    static var previews: some View {
        CustomInboxCellView(message: InAppMessageStub(createdAt: 1579577586000, saveToInbox: true, content: InAppMessageContent(contentType: "html", html: "<a href='iterable://dismiss'>Click Here3</a><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'>"), trigger: InAppMessageTrigger(type: "never"), messageId: "testMessageId", campaignId: "testCampaignId", inboxMetadata: InAppMessageMeta(title: "Hot Old Fashioned", subtitle: "Old fashioned is on sale right now, get one for 30% off!", icon: "oldfashioned", buttonText: "Buy Now"), customPayload: InAppMessageCustomPayload(discount: "30%")))
    }
}
