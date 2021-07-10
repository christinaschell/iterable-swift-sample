//
//  CircleImageView.swift
//  IterableSample
//
//  Created by Christina Schell on 7/9/21.
//

import SwiftUI

struct CircleImageView: ViewModifier {
    
    var shadowRadius: CGFloat = 10
    var lineWidth: CGFloat = 5
    var color: Color = .darkPurple

    func body(content: Content) -> some View {
        content
            .clipShape(Circle())
            .shadow(radius: shadowRadius)
            .overlay(Circle().stroke(color, lineWidth: lineWidth))

    }
}
