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
        NavigationStack(path: $path) {
            ZStack {
                Group{
                    Color(.secondarySystemBackground)
                        .ignoresSafeArea()
                    Image("doodle")
                        .resizable()
                        .ignoresSafeArea()
                } //Background Color + Doodle
                VStack(spacing: 10){
                    
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 29, x: 0, y: 4)
                        .frame(maxWidth: 244)
                    
                    Text("Login")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.black)
                    
                    CustomTextField(title: "Email or Phone Number", icon: "envelope", fieldData: $username)
                    CustomTextField(title: "Password", icon: "lock", isSecureField: true, fieldData: $password)
                    
                    HStack{
                        Spacer()
                        Button{
                            
                        } label : {
                            Text("Forget Password?")
                        }
                        .tint(.secondary)
                    }
                    
                    Button{
                        viewModel.loginUser(email: username, password: password)
                    } label: {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                    }
                    
                    .controlSize(.large)
                    .buttonStyle(.borderedProminent)
                    .tint(.accentColor)
                    Button{
                        viewModel.loginUser(email: username, password: password)
                    } label: {
                        Text("Continue as Guest")
                            .frame(maxWidth: .infinity)
                    }
                    .controlSize(.large)
                    .buttonStyle(.bordered)
                    .tint(.accentColor)
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
                .navigationTitle("Login")
                .navigationBarHidden(true)
                .navigationDestination(for: NavigationDestinations.self){ destination in
                    destination.view
                }
                
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
                    withAnimation{
                        showPassword.toggle()
                    }
                } label: {
                    Image(systemName: showPassword ? "eye" :"eye.slash")
                        .contentTransition(.symbolEffect(.replace))
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
            .padding(.horizontal, 30)
            .background(Color(.systemBackground))
            .clipShape(.rect(cornerRadius: 12))
            .overlay (alignment: .leading){
                Image(systemName: icon)
                    .frame(width: 20)
                    .padding(.horizontal, 13)
            }
    }
}
