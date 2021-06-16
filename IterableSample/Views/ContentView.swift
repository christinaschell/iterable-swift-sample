//
//  ContentView.swift
//  IterableSample
//
//  Created by Christina Schell on 5/11/21.
//

import SwiftUI
import SchellySwiftUI

struct User {
    var username = ""
    var password = ""
}

struct ContentView: View {
    @State private var user = User()
    @State private var showAccountModal = false
    
    var body: some View {
        VStack {
            Image("iterable")
            SchellyTextField($user.username,
                             secure: false,
                             imageName: "person.fill",
                             placeholder: "Username",
                             color: .darkPurple)
                .padding(.top, 20)
            SchellyTextField($user.password,
                             secure: true,
                             imageName: "lock.fill",
                             placeholder: "Password",
                             color: .darkPurple)
                .padding(.bottom, 20)
            SchellyTextButton(title: "Login",
                              backgroundColor: .darkPurple,
                              foregroundColor: .white) {
                IterableManager.updateUser(with: [
                    "customer_first_name": "Christina",
                    "is_registered_user": true
                ])
                self.showAccountModal.toggle()
            }
            .sheet(isPresented: $showAccountModal, content: {
                AccountView()
            })

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
