//
//  FoodDetailScreen.swift
//  DelicaciaSphere
//
//  Created by Zohaib Ahmed on 8/17/24.
//

import SwiftUI

struct FoodDetailScreen: View {
    
    //Food item to be displayed
    var foodItem: Food
    
    /*----------------------------------------
     ---------States to be changed -----------
     -----------------------------------------*/
    @State var desiredSize: ProductSize = ProductSize.Mini
    
    
    //States of previous scree
    @Binding var showDetailScreen: Bool
    
    //For Transition Animation from previous screen
    var imageTransition: Namespace.ID
    
    var body: some View {
        VStack{
            // Top Row Back Button + Heart Button
            HStack(alignment: .top){
                CircularIconButton(label: "back", image: "chevron.left",size: .regular, action: {
                    withAnimation{showDetailScreen.toggle()}
                })
                
                Spacer()
                
                //Custom circular button animated Heart
                Circle()
                    .frame(width: 34, height: 34)
                    .foregroundStyle(Color(.accent).opacity(0.15))
                    .overlay{
                        AnimatedHeart(size: 15)
                    }
            }
            .zIndex(1)
            // Image Row with product images
            HStack {
                Spacer()
                Image(foodItem.image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 265)
                    .shadow(radius: 25, y: 7)
                    .matchedGeometryEffect(id: foodItem.id, in: imageTransition)
                Spacer()
            }
            .overlay{
                Image(foodItem.image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 265)
                    .shadow(radius: 25, y: 7)
                    .offset(x: -280, y: -40)
                Image(foodItem.image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 265)
                    .shadow(radius: 25, y: 7)
                    .offset(x: 280, y: -40)
            }
            .zIndex(0)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10){
                    
                    //Title
                    HStack(alignment: .bottom) {
                        Text(foodItem.name)
                            .font(.system(size: 28, design: .rounded))
                        Image(systemName: "chevron.down")
                            .font(.system(size: 17, design: .rounded))
                            .padding(.bottom, 5)
                        
                    }
                    .fontWeight(.heavy)
                    
                    //Description
                    Text(foodItem.description)
                        .font(.system(size: 17, design: .rounded))
                        .foregroundStyle(.secondary)
                    
                    //Properties Row
                    ProductPropertyRow(preparationTime: "10-20 min", deliveryCost: "Free Delivery", rating: "4.7", totalRatings: "10 Reviews")
                    

                    SectionTitleWithInfo("Select your desired size:", message: "Mini = 10 inch \nSmall = 12 inch\nMedium = 14 inch\nLarge = 16 inch\nX-Large = 18 inch")
                    
                    Picker("Testing", selection: $desiredSize){
                        ForEach(ProductSize.allCases, id: \.self){size in
                            Text("\(size)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    //Calories section not to be added according to design
//                    ZStack{
//                        HStack{
//                            Spacer()
//                            Properties_SubView(property: foodItem.kcal, type: "kcal")
//                            Spacer()
//                            Divider().frame(height: 30)
//                            Spacer()
//                            Properties_SubView(property: foodItem.proteins, type: "proteins")
//                            Spacer()
//                            Divider().frame(height: 30)
//                            Spacer()
//                            Properties_SubView(property: foodItem.fats, type: "fats")
//                            Spacer()
//                            Divider().frame(height: 30)
//                            Spacer()
//                            Properties_SubView(property: foodItem.carbo, type: "carbo")
//                            Spacer()
//                        }
//                    }
//                    .background(.white)
//                    .clipShape(.rect(cornerRadius: 20))
                    
                    SectionTitleWithInfo("Choose ingredients:", message: "Ingredients are building block of \nyour food item")
                    
                    
                    HStack(spacing: 10){
                        CategoryCard(image: "tomato", text: "Tomato")
                        CategoryCard(image: "pepper", text: "Pepper")
                        CategoryCard(image: "onion", text: "Onion")
                        CategoryCard(image: "olives", text: "Olive")
                        CategoryCard(image: "broccoli", text: "Broccoli")
                    }
                    
                    SectionTitleWithInfo("Choose toppings:", message: "Toppings are extras")
                    
                    
                    HStack(spacing: 10){
                        CategoryCard(image: "pepperoni", text: "Pepperoni")
                        CategoryCard(image: "cheese", text: "Cheese")
                        CategoryCard(image: "sausage", text: "Sausage")
                        CategoryCard(image: "mushrooms", text: "Mushrooms")
                        CategoryCard(image: "chicken_pieces", text: "Chicken")
                    }
                    
                    SectionTitle("Select your drink/s:")
                    
                    Rectangle().frame(height: 200)
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
                .fill(Color(.systemBackground))
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
                    Text("$\(foodItem.price, specifier: "%.2f") - Buy Now")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
                .tint(.green)
                .controlSize(.extraLarge)
                .buttonStyle(.borderedProminent)
            }
            .shadow(color: Color(.white), radius: 30)
            .padding(.horizontal)
            .background(Color.white.blur(radius: 30))
        }
    }
}

#Preview {
    @Previewable @Namespace var testing
    FoodDetailScreen(foodItem: foodList[1], showDetailScreen: .constant(false), imageTransition: testing)
}

//struct Properties_SubView: View{
//    var property: Double
//    var type: String
//    var body: some View{
//        VStack(spacing: 0){
//            Text("\(property, specifier: "%.1f")")
//                .font(.system(.callout))
//                .fontWeight(.semibold)
//            Text(type)
//                .font(.system(.callout))
//                .foregroundStyle(Color(.systemGray))
//        }
//        .padding(.vertical, 10)
//    }
//}

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



