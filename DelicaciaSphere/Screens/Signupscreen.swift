//
//  Signupscreen.swift
//  DelicaciaSphere
//
//  Created by Zohaib Ahmed on 8/15/24.
//

import SwiftUI

struct Signupscreen: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.modelContext) var modelContext
    @Binding var showSignupScreen: Bool
    @State private var userField: User = User(name: "", email: "", username: "", password: "")
    @State private var confirmPassword = ""
    var body: some View {
        VStack(spacing: 10){
            Spacer()
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
            Spacer()
            Text("Signup")
                .font(.system(.largeTitle, design: .rounded, weight: .black))
            CustomTextField(title: "Username", icon: "person", fieldData: $userField.username)
            CustomTextField(title: "Email", icon: "envelope", fieldData: $userField.email)
            CustomTextField(title: "Password", icon: "lock", isSecureField: true, fieldData: $userField.password)
            CustomTextField(title: "Confirm Password", icon: "lock", isSecureField: true, fieldData: $confirmPassword)
            Spacer()
            Button{
                modelContext.insert(User(name: userField.name, email: userField.email, username: userField.username, password: userField.password))
                withAnimation{
                    showSignupScreen.toggle()
                }
            } label: {
                Text("Sign Up")
                    .frame(maxWidth: .infinity)
                    .padding(5)
            }
            .controlSize(.large)
            .buttonStyle(.borderedProminent)
            .tint(.orange)
            
            HStack {
                Text("Already have an account?")
                Button{
                    withAnimation{
                        showSignupScreen.toggle()
                    }
                } label: {
                    Text("Login")
                }
            }
            .font(.system(.callout))
            Spacer()
        }
        .padding()
    }
}

#Preview {
    Signupscreen(showSignupScreen: .constant(false))
}
