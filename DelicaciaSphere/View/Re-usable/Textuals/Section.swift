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

struct SectionTitleWithInfo: View {
    var sectionTitle: String
    var message: String
    
    init(_ sectionTitle: String, message: String){
        self.sectionTitle = sectionTitle
        self.message = message
    }
    
    @State var showTip = false
    var body: some View{
        VStack{
            HStack(alignment: .bottom, spacing: 2){
                SectionTitle(sectionTitle)
                Image(systemName: "info.circle.fill")
                    .foregroundStyle(.tertiary)
                    .font(.system(size: 13, design: .rounded))
                    .onTapGesture {
                        showTip.toggle()
                    }
            }
            .popover(isPresented: $showTip, attachmentAnchor: .point(.trailing)){
                Label(message, systemImage: "info.circle")
                    .padding()
                    .presentationCompactAdaptation(.popover)
            }
        }
    }
}
