//
//  AuthenticationScreen.swift
//  DelicaciaSphere
//
//  Created by Zohaib Ahmed on 8/15/24.
//

import SwiftUI
import SwiftData

struct AuthenticationScreen: View {
    @Query var user: [User]
    @AppStorage("user") var userData: Data?
    
    @State var isAuthenticated: Bool = false
    @State var showSignupScreen = false
    var body: some View {
        ZStack {
            if showSignupScreen {
                Signupscreen(showSignupScreen: $showSignupScreen)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
            } else {
                if !isAuthenticated {
                    Loginscreen(showSignupScreen: $showSignupScreen)
                        .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
                } else {
                    Homescreen()
                }
                
            }
        }.onAppear{
            guard let userData else { return }
            
            do{
                let userRecord = try? JSONDecoder().decode(UserPersistent.self, from: userData)
                
                if let index = user.firstIndex(where: {$0.username == userRecord?.username}){
                    if user[index].password == userRecord?.password {
                        isAuthenticated = true
                    }
                }
                
                
            }
        }
    }
}

#Preview {
    AuthenticationScreen()
}
