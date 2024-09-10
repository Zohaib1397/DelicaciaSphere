//
//  ContentView.swift
//  DelicaciaSphere
//
//  Created by Zohaib Ahmed on 9/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader{
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
            Home(size: size, safeArea: safeArea)
                .ignoresSafeArea(.all, edges: .top)
            
        }
    }
}

#Preview {
    ContentView()
}
