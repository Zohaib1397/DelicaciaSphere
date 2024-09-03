//
//  CustomTextField.swift
//  DelicaciaSphere
//
//  Created by Zohaib Ahmed on 9/3/24.
//

import SwiftUI


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
