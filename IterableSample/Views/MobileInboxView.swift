//
//  MobileInboxView.swift
//  IterableSample
//
//  Created by Christina on 6/15/21.
//

import SwiftUI
import UIKit
import IterableSDK

// TODO: https://support.iterable.com/hc/en-us/articles/360039091471
struct MobileInboxView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some IterableInboxNavigationViewController {
        return IterableInboxNavigationViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        uiViewController.navTitle = "Inbox"
        //uiViewController.noMessagesTitle = "No saved messages"
        //uiViewController.noMessagesBody = "Check again later!"
    }
    
}


