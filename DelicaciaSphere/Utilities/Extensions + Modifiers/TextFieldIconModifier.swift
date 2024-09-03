//
//  TextFieldIconModifier.swift
//  DelicaciaSphere
//
//  Created by Zohaib Ahmed on 9/3/24.
//

import SwiftUI
import Foundation

struct TextFieldModifier : ViewModifier {
    var icon: String
    func body(content: Content) -> some View {
        content
            .padding()
            .padding(.horizontal, 40)
            .background(Color(.systemBackground))
            .clipShape(.rect(cornerRadius: 10))
            .overlay (alignment: .leading){
                Image(systemName: icon)
                    .frame(width: 20)
                    .padding(.horizontal, 23)
            }
    }
}


struct PhoneFieldModifier : ViewModifier {
    func body(content: Content) -> some View{
        content
            .padding()
            .padding(.horizontal, 40)
            .background(Color(.systemBackground))
            .clipShape(.rect(cornerRadius: 10))
            .overlay(alignment: .leading) {
                HStack(spacing: 6){
                    Text("+92")
                    Rectangle()
                        .frame(maxWidth: 0.33, maxHeight: 24)
                }
//                .frame(width:20)
                .padding(.horizontal, 13)
            }
    }
}
