//
//  MobileInbox.swift
//  IterableSample
//
//  Created by Christina on 6/15/21.
//

import SwiftUI
import UIKit
import IterableSDK

struct MobileInboxView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some IterableInboxNavigationViewController {
        return IterableInboxNavigationViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
}


