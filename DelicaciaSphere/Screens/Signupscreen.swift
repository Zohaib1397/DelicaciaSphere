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
    @State private var phoneNumber = ""
    
    var body: some View {
        ZStack {
           
            VStack(spacing: 10){
                
                Text("Signup")
                    .font(.system(.largeTitle, design: .rounded, weight: .black))
                
                CustomTextField(title: "Email Address", icon: "envelope", fieldData: $userField.email)
                TextField("3XX XXXXXXX", text: $phoneNumber)
                    .modifier(PhoneFieldModifier())
                CustomTextField(title: "Password", icon: "lock", isSecureField: true, fieldData: $userField.password)
                
                AgreementCheck()
                
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
                .tint(.accentColor)
                
                HStack {
                    Text("Already have an account?")
                    Button{
                        withAnimation{
                            showSignupScreen.toggle()
                        }
                    } label: {
                        Text("Login")
                            .underline()
                    }
                }
                .font(.system(.callout))
                
            }
            .padding()
        }
    }
}

#Preview {
    Signupscreen(showSignupScreen: .constant(false))
}


struct AgreementCheck: View {
    
    @State var check: Bool = false
    
    var body: some View{
        HStack{
            Button{
                withAnimation{
                    check.toggle()
                }
            } label: {
                Image(systemName: check ? "checkmark.square.fill" : "square.dashed")
                    .foregroundStyle(check ? .accent : .secondary)
                    .contentTransition(.symbolEffect(.replace))
            }
            HStack(spacing: 0){
                Text("I agree the ")
                Button{
                    
                } label :{
                    Text("terms & conditions")
                        .underline()
                }
            }
            .foregroundStyle(.secondary)
            Spacer()
        }
        .padding(.horizontal, 10)
    }
}
