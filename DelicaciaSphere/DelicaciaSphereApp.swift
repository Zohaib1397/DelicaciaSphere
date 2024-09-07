//
//  DelicaciaSphereApp.swift
//  DelicaciaSphere
//
//  Created by Zohaib Ahmed on 8/13/24.
//

import SwiftUI
import SwiftData

@main
struct DelicaciaSphereApp: App {
    
    var authenticationViewModel = AuthenticationViewModel()
    var body: some Scene {
        WindowGroup {
//            AuthenticationScreen().environmentObject(authenticationViewModel)
            Homescreen().environmentObject(authenticationViewModel)
        }
        .modelContainer(for: [User.self])
    }
}
