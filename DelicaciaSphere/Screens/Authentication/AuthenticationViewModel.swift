//
//  AuthenticationViewModel.swift
//  DelicaciaSphere
//
//  Created by Zohaib Ahmed on 8/15/24.
//

import Foundation
import SwiftData
import SwiftUI

class AuthenticationViewModel: ObservableObject{
    
    
    
    @AppStorage("user") var userData: Data?
    @Published var isAuthenticated: Bool = false
    @Published var showSignupScreen: Bool = false
    
    func retrieveUser() -> User? {
        guard let userData else { return nil}
        
        do {
            let userRecord = try? JSONDecoder().decode(UserPersistent.self, from: userData)
            return User(name: userRecord!.username, email: userRecord?.email ?? "", username: userRecord!.username, password: userRecord?.password ?? "")
        }
    }
    
    func loginUser(email: String, password: String){
        let newUser = UserPersistent(email: email, username: email, password: password)
        do {
            let loginUser = try? JSONEncoder().encode(newUser)
            userData = loginUser
            isAuthenticated = true
        }
    }
    
    func logoutUser() {
        userData = nil
        isAuthenticated = false
    }
    
}
