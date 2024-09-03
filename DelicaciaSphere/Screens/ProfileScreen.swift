//
//  ProfileScreen.swift
//  DelicaciaSphere
//
//  Created by Zohaib Ahmed on 8/18/24.
//

import SwiftUI

struct ProfileScreen: View {
    
//    @State var userFields: 
    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("Personal Info")){
                    
                    Text("Phone Number")
                }
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileScreen()
}
