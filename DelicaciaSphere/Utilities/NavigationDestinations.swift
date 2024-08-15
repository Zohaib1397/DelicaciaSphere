//
//  NavigationDestinations.swift
//  DelicaciaSphere
//
//  Created by Zohaib Ahmed on 8/14/24.
//
import SwiftUI

enum NavigationDestinations: Hashable{
    case home
    
    @ViewBuilder
    var view: some View{
        switch self {
        case .home: Homescreen()
        }
    }
}
