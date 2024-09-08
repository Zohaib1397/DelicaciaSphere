//
//  CustomLabel.swift
//  DelicaciaSphere
//
//  Created by Zohaib Ahmed on 9/8/24.
//

import SwiftUI

struct CustomLabel: View {
    
    var image: String
    var text: String
    var color: Color
    var subText: String?
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0){
            Image(systemName: image)
                .font(.system(size: 17))
                .foregroundStyle(color)
            Text(" \(text)")
                .font(.system(size: 13))
                .foregroundStyle(.secondary)
            if subText != nil {
                Text(" (\(subText ?? "Error"))")
                    .font(.system(size: 10))
                    .foregroundStyle(.secondary)
            }
        }
        .fontWeight(.semibold)
    }
}
