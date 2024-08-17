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
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        ZStack {
            if viewModel.showSignupScreen {
                Signupscreen(showSignupScreen: $viewModel.showSignupScreen)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
            } else {
                if !viewModel.isAuthenticated {
                    Loginscreen(showSignupScreen: $viewModel.showSignupScreen)
                        .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
                } else {
                    Homescreen()
                }
                
            }
        }.onAppear{
            let userRecord = viewModel.retrieveUser()
            if let index = user.firstIndex(where: {$0.username == userRecord?.username}){
                if user[index].password == userRecord?.password {
                    viewModel.isAuthenticated = true
                }
            }
        }
    }
}

#Preview {
    AuthenticationScreen()
}
