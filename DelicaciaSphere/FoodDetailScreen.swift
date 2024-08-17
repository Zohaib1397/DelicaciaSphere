//
//  FoodDetailScreen.swift
//  DelicaciaSphere
//
//  Created by Zohaib Ahmed on 8/17/24.
//

import SwiftUI

struct FoodDetailScreen: View {
    var foodItem: Food
    var body: some View {
        VStack{
            HStack{
                Circle()
                    .frame(width: 55, height: 55)
                    .foregroundStyle(.white)
                    .shadow(color: Color(.systemGray4), radius: 30)
                    .overlay{
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24))
                    }
                Spacer()
                Text("Details")
                    .font(.system(.headline, design: .rounded))
                    .foregroundStyle(.white)
                Spacer()
                Circle()
                    .frame(width: 55, height: 55)
                    .foregroundStyle(.white)
                    .shadow(color: Color(.systemGray4), radius: 30)
                    .overlay{
                        AnimatedHeart(size: 24)
                    }
            }
            ScrollView {
                VStack(alignment: .leading){
                    Image(foodItem.image)
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 10, y: 30)
                    Text(foodItem.name)
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.bold)
                    Label("Islamabad, Pakistan", systemImage: "location.circle")
                        .foregroundStyle(Color(.systemGray))
                    ZStack{
                        HStack{
                            Spacer()
                            Properties_SubView(property: foodItem.kcal, type: "kcal")
                            Spacer()
                            Divider().frame(height: 30)
                            Spacer()
                            Properties_SubView(property: foodItem.proteins, type: "proteins")
                            Spacer()
                            Divider().frame(height: 30)
                            Spacer()
                            Properties_SubView(property: foodItem.fats, type: "fats")
                            Spacer()
                            Divider().frame(height: 30)
                            Spacer()
                            Properties_SubView(property: foodItem.carbo, type: "carbo")
                            Spacer()
                        }
                    }
                    .background(.white)
                    .clipShape(.rect(cornerRadius: 20))
                    Text("Description")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.semibold)
                    Text(foodItem.description)
                    Rectangle()
                        .frame(height: 50)
                        .foregroundStyle(.red.opacity(0))
                }
                
            }
            .scrollIndicators(.hidden)
            Spacer()
        }
        .padding()
        .background(
            Circle()
                .scale(3)
                .offset(x: -300, y: 300)
                .fill(Color(.systemGray6))
        )
        .overlay(alignment: .bottom) {
            HStack{
                Circle()
                    .frame(width: 55, height: 55)
                    .foregroundStyle(.white)
                    .overlay{
                        Image(systemName: "cart")
                            .font(.system(size: 24))
                    }
                Button{
                    
                } label :{
                    Text("Buy Now")
                        .frame(maxWidth: .infinity)
                }
                .tint(.green)
                .controlSize(.extraLarge)
                .buttonStyle(.borderedProminent)
            }
            .shadow(color: Color(.white), radius: 30)
            .padding(.horizontal)
        }
    }
}

#Preview {
    FoodDetailScreen(foodItem: foodList.first!)
}

struct Properties_SubView: View{
    var property: Double
    var type: String
    var body: some View{
        VStack(spacing: 0){
            Text("\(property, specifier: "%.1f")")
                .font(.system(.callout))
                .fontWeight(.semibold)
            Text(type)
                .font(.system(.callout))
                .foregroundStyle(Color(.systemGray))
        }
        .padding(.vertical, 10)
    }
}
