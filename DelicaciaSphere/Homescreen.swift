//
//  Homescreen.swift
//  DelicaciaSphere
//
//  Created by Zohaib Ahmed on 8/13/24.
//

import SwiftUI

struct Homescreen: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    @State var selectedFoodItem: Food?
    @State var showDetailScreen = false
    @Namespace var imageTransition
    @State var searchText: String = ""
    
    var body: some View {
            ZStack {
                ScrollView {
                    ZStack {
                        VStack {
                            TopBar()
                            OfferCard()
                            LazyVGrid(columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                            ]){
                                CategoryCard(image: "burger", text: "Burger")
                                CategoryCard(image: "chicken", text: "Chicken")
                                CategoryCard(image: "fries", text: "Fries")
                                CategoryCard(image: "drink", text: "Drink")
                            }
                            HStack{
                                Text("Recommended for you")
                                    .font(.system(.title2, design: .rounded))
                                    .fontWeight(.bold)
                                Spacer()
                                Text("See More")
                                    .underline()
                                    .font(.system(.callout))
                            }
                            LazyVGrid(columns: columns){
                                ForEach(foodList){ foodItem in
                                    ProductCard(foodItem: foodItem, imageTransition: imageTransition)
                                        .onTapGesture {
                                            withAnimation{
                                                showDetailScreen = true
                                                selectedFoodItem = foodItem
                                            }
                                        }
                                }
                                
                            }
                            
                        }
                        .padding()
                    }
                    
                }
                .background(Color(.systemGray6))
                .blur(radius: showDetailScreen ? 40 : 0)
                if showDetailScreen {
                    FoodDetailScreen(foodItem: selectedFoodItem ?? foodList.first!, showDetailScreen: $showDetailScreen, imageTransition: imageTransition)
                }
            }
    }
}

#Preview {
    Homescreen()
}

#Preview("Product Card") {
    @Previewable @Namespace var testing
    ProductCard(foodItem: foodList.first!, imageTransition:  testing)
}

#Preview("Animated Heart", traits: .sizeThatFitsLayout){
    AnimatedHeart(size: 24)
}

struct AnimatedHeart: View{
    
    var size: CGFloat
    @State var clicked: Bool = false
    
    var body: some View{
        Image(systemName: "heart.fill")
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .foregroundStyle(clicked ? .red : Color(.systemGray4))
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

struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

struct MeasureHeightModifier: ViewModifier {
    @Binding var height: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear.preference(key: HeightPreferenceKey.self, value: proxy.size.height)
                }
            )
            .onPreferenceChange(HeightPreferenceKey.self) { value in
                height = value
            }
    }
}
struct ProductCard: View {
    var foodItem: Food
    @State private var titleHeight: CGFloat = 0
    let imageTransition: Namespace.ID
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Image(foodItem.image)
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: foodItem.id, in: imageTransition)
                
                Text(foodItem.name)
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .modifier(MeasureHeightModifier(height: $titleHeight))
                
                Text(foodItem.description)
                    .font(.system(.callout))
                    .lineLimit(titleHeight > 30 ? 1 : 2)
                
                Spacer()
                
                HStack {
                    Text("$\(foodItem.price, specifier: "%.2f")")
                        .font(.system(.title, design: .rounded))
                    
                    Spacer()
                    
                    Button {
                        // Action for the button
                    } label: {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(.borderedProminent)
                    .clipShape(Circle())
                    .tint(.green)
                }
            }
            .padding()
        }
        .overlay(
            AnimatedHeart(size: 24)
                .padding(),
            alignment: .topTrailing
        )
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}
struct CategoryCard: View{
    var image: String
    var text: String
    
    var body: some View{
        VStack{
            Image(image)
                .resizable()
                .scaledToFit()
                
            Text(text)
                .font(.system(.callout))
                .fontWeight(.medium)
                .foregroundStyle(.gray)
                .minimumScaleFactor(0.3)
        }
        .frame(maxWidth: 80, maxHeight: 80)
        .padding()
        .background(.white)
        .clipShape(.rect(cornerRadius: 20))
    }
}

struct TopBar: View {
    var body: some View {
        HStack{
            Circle()
                .frame(width: 55, height: 55)
                .foregroundStyle(.white)
                .shadow(color: Color(.systemGray4), radius: 30)
                .overlay{
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 24))
                }
            Spacer()
            VStack{
                Text("Location")
                    .font(.system(.callout, design: .rounded))
                    .foregroundStyle(.gray)
                
                HStack{
                    Image(systemName: "location.circle")
                    Text("Islamabad, Pakistan")
                        .font(.system(.headline, design: .rounded))
                    Image(systemName: "chevron.down")
                }
                
            }
            Spacer()
            Circle()
                .frame(width: 55, height: 55)
                .foregroundStyle(.white)
                .shadow(color: Color(.systemGray4), radius: 30)
                .overlay{
                    Image(systemName: "bell")
                        .font(.system(size: 24))
                }
        }
    }
}

struct OfferCard: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text("Free Delivery For Spaghetti")
                    .font(.system(.title))
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: 300, alignment: .leading)
                    .lineLimit(2)
                Text("Up to 3 times per day")
                    .foregroundStyle(.white)
                Button{
                    
                } label : {
                    Text("Order Now")
                }
                
                .buttonStyle(.borderedProminent)
                .tint(Color(.green))
                .clipShape(.rect(cornerRadius: 25))
            }
            .padding(20)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.linearGradient(Gradient(colors: [.black.opacity(0.7), .black]), startPoint: .top, endPoint: .bottom))
        .overlay(alignment: .trailing){
            Image("spaghetti")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .offset(x: 100)
        }
        .clipped()
        .clipShape(.rect(cornerRadius: 20))
    }
}
