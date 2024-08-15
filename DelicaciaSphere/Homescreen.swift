//
//  Homescreen.swift
//  DelicaciaSphere
//
//  Created by Zohaib Ahmed on 8/13/24.
//

import SwiftUI

struct Homescreen: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Home Screen")
            Button{
                UserDefaults.standard.set(nil, forKey: "user")
            } label: {
                Text("Logout")
            }
        }
        .padding()
    }
}

#Preview {
    Homescreen()
}
