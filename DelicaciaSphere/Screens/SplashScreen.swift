//
//  SplashScreen.swift
//  DelicaciaSphere
//
//  Created by Zohaib Ahmed on 9/3/24.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack{
            Image("doodle")
                .resizable()
                .ignoresSafeArea()
            VStack{
                Spacer()
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 290)
                    .shadow(radius: 29, x: 0, y: 4)
                Text("Delicacia Sphere")
                    .font(.custom("FuturaClassicBold", size: 23))
                Spacer()
                Text("Powered By".uppercased())
                    .font(.custom("FuturaClassicNormal", size: 14))
                Image("backcaps_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 60)
            }
        }
    }
}

#Preview {
    SplashScreen()
}
