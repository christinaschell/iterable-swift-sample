//
//  DonutDetailView.swift
//  IterableSample
//
//  Created by Christina Schell on 7/9/21.
//

import SwiftUI
import SchellySwiftUI

struct DonutDetailView: View {
    var donut: Donut
    var body: some View {
        VStack {
            Image(donut.image)
                .resizable()
                .frame(width: 250, height: 250, alignment: .center)
                .modifier(CircleImageView())
            Text(donut.name)
                .font(.largeTitle)
            Text(String(donut.price))
                .italic()
                .padding(.bottom, 20)
            SchellyTextButton(title: "Order Now!", backgroundColor: .darkPurple, foregroundColor: .white) {
                print("order now")
            }
            .padding(.bottom, 40)
        }
    }
}

struct DonutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DonutDetailView(donut: Donut(id: 1, name: "Maple Bar", price: 2.99, image: "maplebar"))
    }
}
