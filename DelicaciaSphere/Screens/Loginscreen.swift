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
    @AppStorage("user") var userData: Data?
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var path: [NavigationDestinations] = []
    @State var isAuthentication = false
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 20){
                Spacer()
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                Spacer()
                Text("Login")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.black)
                
                CustomTextField(title: "Username or Email", icon: "person", fieldData: $username)
                CustomTextField(title: "Password", icon: "lock", isSecureField: true, fieldData: $password)
                
                HStack{
                    Spacer()
                    Button{
                        
                    } label : {
                        Text("Forget Password?")
                    }
                }
                
                Button{
                    let user = UserPersistent(email: username, username: username, password: password)
                    do {
                        let newUser = try? JSONEncoder().encode(user)
                        userData = newUser
                    }
                    
                } label: {
                    Text("Login")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(10)
                }
                
                .buttonStyle(.borderedProminent)
                .tint(.orange)
                HStack{
                    Text("Don't have an account?")
                    Button{
                        withAnimation{
                            showSignupScreen.toggle()
                        }
                    } label: {
                        Text("Sign up")
                    }
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Login")
            .navigationBarHidden(true)
            .navigationDestination(for: NavigationDestinations.self){ destination in
                destination.view
            }
        }
    }
}

#Preview {
    Loginscreen(showSignupScreen: .constant(false))
}


struct CustomTextField: View {
    
    let title: String
    let icon: String
    var isSecureField: Bool = false
    @Binding var fieldData: String
    @State var showPassword: Bool = false
    
    var body: some View{
        ZStack(alignment: .trailing){
            if isSecureField && !showPassword {
                SecureField(title, text: $fieldData)
                    .autocorrectionDisabled()
                    .modifier(TextFieldModifier(icon: icon))
            } else {
                TextField(title, text: $fieldData)
                    .textInputAutocapitalization(.none)
                    .modifier(TextFieldModifier(icon: icon))
            }
            if isSecureField {
                Button{
                    showPassword.toggle()
                } label: {
                    Image(systemName: showPassword ? "eye" :"eye.slash")
                }
                .padding(.horizontal, 13)
                .tint(Color(.systemGray))
            }
            

        }
        
            
    }
}

struct TextFieldModifier : ViewModifier {
    
    var icon: String
    
    func body(content: Content) -> some View {
        content
            .padding()
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .clipShape(.rect(cornerRadius: 12))
            .overlay (alignment: .leading){
                Image(systemName: icon)
                    .padding(.horizontal, 13)
            }
    }
}
