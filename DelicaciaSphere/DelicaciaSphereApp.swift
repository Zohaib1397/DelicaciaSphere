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
    var body: some Scene {
        WindowGroup {
            AuthenticationScreen()
        }
        .modelContainer(for: [User.self])
    }
}
