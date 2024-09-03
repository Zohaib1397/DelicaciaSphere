//
//  Loginscreen.swift
//  DelicaciaSphere
//
//  Created by Zohaib Ahmed on 8/13/24.
//

import SwiftUI
import SwiftData

struct Loginscreen: View {
    @Binding var showSignupScreen: Bool
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var path: [NavigationDestinations] = []
    @State var isAuthentication = false
    
    
    var body: some View {
        
        
        VStack(spacing: 10){
            
            //Main title of the page
            Text("Login")
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.black)
            //Fields of the page
            CustomTextField(title: "Email or Phone Number", icon: "envelope", fieldData: $username)
            CustomTextField(title: "Password", icon: "lock", isSecureField: true, fieldData: $password)
            
            //Forget password row
            HStack{
                Spacer()
                Button{
                    
                } label : {
                    Text("Forget Password?")
                }
                .tint(.secondary)
            }
            
            //Login button that authenticate the user
            Button{
                viewModel.loginUser(email: username, password: password)
            } label: {
                Text("Login")
                    .frame(maxWidth: .infinity)
            }
            .controlSize(.large)
            .buttonStyle(.borderedProminent)
            .tint(.accentColor)
            
            //Guest mode for user if he/she doesn't like to login right now
            //but will require login on order booking
            Button{
                viewModel.loginUser(email: username, password: password)
            } label: {
                Text("Continue as Guest")
                    .frame(maxWidth: .infinity)
            }
            .controlSize(.large)
            .buttonStyle(.bordered)
            .tint(.accentColor)
            
            //Don't have an account then this row comes with signup button
            HStack{
                Text("Don't have an account?")
                Button{
                    withAnimation{
                        showSignupScreen.toggle()
                    }
                } label: {
                    Text("Sign up")
                        .underline()
                }
            }
            Spacer()
        }
        .padding()
    }
    
}

#Preview {
    @Previewable @Namespace var transition
    Loginscreen(showSignupScreen: .constant(false))
}



