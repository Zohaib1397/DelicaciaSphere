//
//  AnimatedHeart.swift
//  DelicaciaSphere
//
//  Created by Zohaib Ahmed on 9/7/24.
//

import SwiftUI


struct AnimatedHeart: View{
    
    var size: CGFloat
    @State var clicked: Bool = false
    
    var body: some View{
        Image(systemName: clicked ? "heart.fill" : "heart")
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .foregroundStyle(clicked ? .red : Color(.accent))
            .phaseAnimator([true, false], trigger: clicked, content: { content, phase in
                content
                    .scaleEffect(phase ? 1.0 : 0.5)
            }, animation: { phase in
                switch phase {
                case true: .spring.speed(3)
                case false: .spring.speed(2)
                }
            }
            )
            .onTapGesture {
                withAnimation(.spring(duration: 0.1, bounce: 0.5)){
                    clicked.toggle()
                }
                
            }
    }
}


#Preview("Animated Heart", traits: .sizeThatFitsLayout){
    AnimatedHeart(size: 24)
}
