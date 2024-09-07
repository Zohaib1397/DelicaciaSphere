//
//  NavigationBar.swift
//  DelicaciaSphere
//
//  Created by Zohaib Ahmed on 9/5/24.
//

import SwiftUI

struct NavigationBar: View {
    
    @State var page: NavigationPage = NavigationPage.Home
    
    
    var navigationList = [
            (title: "Home", icon: "home"),
            (title: "Chat", icon: "chat"),
            (title: "Basket", icon: "basket"),
            (title: "Profile", icon: "profile")
        ]
    
    var body: some View {
        ZStack{
//            Rectangle()
//                .frame(height: 88)
//                .foregroundStyle(LinearGradient(colors: [.white.opacity(0), .white], startPoint: .top, endPoint: .bottom))
                
            HStack{
                ForEach(0..<navigationList.count, id: \.self){ index in
                    let item = navigationList[index]
                    NavigationPill(
                        title:item.title,
                        icon: item.icon,
                        selected: page.rawValue == (index + 1))
                    .onTapGesture {
                        withAnimation(.spring.speed(3)){
                            page = NavigationPage(rawValue: index + 1) ?? .Home
                        }
                        
                    }
                }
                
            }
            .padding(15)
            .background(Color(.systemBackground))
            .clipShape(.rect(cornerRadius: .infinity))
            .shadow(color: .black.opacity(0.25), radius: 30, y: 4)
        }
        }
}

#Preview {
    NavigationBar()
}

enum NavigationPage: Int{
    case Home = 1
    case Chat = 2
    case Bucket = 3
    case Profile = 4
}

struct NavigationPill: View{
    
    var title: String
    var icon: String
    var selected: Bool
    
    var body: some View{
        HStack(spacing: 6){
            Image(selected ? "\(icon).fill" : icon)
            if selected {
                Text(title)
                    .font(.system(size: 12))
            }
        }
        .padding(10)
        .padding(.horizontal, 10)
        .background(selected ? Color(.accent) : nil)
        .foregroundStyle(selected ? Color(.white) : Color("icon.disabled"))
        .fontWeight(.medium)
        .clipShape(.rect(cornerRadius: .infinity))
    }
}
