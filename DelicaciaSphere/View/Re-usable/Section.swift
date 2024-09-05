//
//  Section.swift
//  DelicaciaSphere
//
//  Created by Zohaib Ahmed on 9/5/24.
//

import SwiftUI
import Foundation

struct SectionTitle: View {
    var title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .font(.system(size: 17, design: .rounded))
            .fontWeight(.semibold)
    }
}
