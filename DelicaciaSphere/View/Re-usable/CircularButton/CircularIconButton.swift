//
//  CircularButton.swift
//  DelicaciaSphere
//
//  Created by Zohaib Ahmed on 9/7/24.
//

import SwiftUI

struct CircularIconButton: View {
    
    var label: String
    var image: String
    var size: ControlSize?
    var action: () -> Void
    
    var body: some View {
        Button(label, systemImage: image, action: action)
        .labelStyle(.iconOnly)
        .buttonStyle(.bordered)
        .buttonBorderShape(.circle)
        .controlSize(size ?? .large)
        .tint(.accentColor)
        
    }
}

struct CircularProminentIconButton: View {
    
    var label: String
    var image: String
    var size: ControlSize?
    var action: () -> Void
    
    var body: some View {
        Button(label, systemImage: image, action: action)
        .labelStyle(.iconOnly)
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.circle)
        .controlSize(size ?? .large)
        .tint(.accentColor)
        
    }
}

#Preview {
    CircularIconButton(label: "back", image: "chevron.left", action: {
        print("pressed")
    })
}
