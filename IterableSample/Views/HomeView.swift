//
//  HomeView.swift
//  IterableSample
//
//  Created by Christina Schell on 5/11/21.
//

import SwiftUI
import SchellySwiftUI
import UserNotifications

struct User {
    var email = ""
    var firstName = ""
}

struct HomeView: View {
    @State private var user = User()
    
    var body: some View {
        VStack(spacing: 20) {
            Image("iterable")
            SchellyTextField($user.email,
                             imageName: "envelope.fill",
                             placeholder: "Email",
                             color: .darkPurple)
            SchellyTextField($user.firstName,
                             imageName: "person.fill",
                             placeholder: "First Name",
                             color: .darkPurple)
                
            SchellyTextButton(title: "Update User",
                              backgroundColor: .darkPurple,
                              foregroundColor: .white) {
                IterableManager.shared.userId = "userId\(user.email)"
                IterableManager.shared.userEmail = user.email
                IterableManager.updateUser(with: [
                    "customer_first_name": user.firstName,
                    "is_registered_user": true
                ])
                setupNotifications()
            }.onAppear {
                Deeplinker().manage(url: URL(string: "https://schellyapps.com/products?q=maplebar")!)
            }
        }
    }
    
    private func setupNotifications() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus != .authorized {
                // not authorized, ask for permission
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, _ in
                    if success {
                        DispatchQueue.main.async {
                            UIApplication.shared.registerForRemoteNotifications()
                        }
                    }
                    // TODO: Handle error etc.
                }
            } else {
                // already authorized
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
