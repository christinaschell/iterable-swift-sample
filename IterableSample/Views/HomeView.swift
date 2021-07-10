//
//  HomeView.swift
//  IterableSample
//
//  Created by Christina Schell on 5/11/21.
//

import SwiftUI
import SchellySwiftUI

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
                IterableManager.updateUser(with: [
                    "customer_first_name": user.firstName,
                    "is_registered_user": true
                ])
            }.onAppear {
                Deeplinker().manage(url: URL(string: "https://schellyapps.com/products?q=maplebar")!)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
