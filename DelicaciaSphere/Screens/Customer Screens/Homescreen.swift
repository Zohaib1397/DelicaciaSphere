//
//  Homescreen.swift
//  DelicaciaSphere
//
//  Created by Zohaib Ahmed on 8/13/24.
//

import SwiftUI

struct Homescreen: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    var grid_2x2: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    @State var selectedFoodItem: Food?
    @State var showDetailScreen = false
    @Namespace var imageTransition
    
    
    var body: some View {
            ZStack {
                
                ZStack {
                    Color(.systemBackground)
                        .ignoresSafeArea(.all)
                    ScrollView {
                        VStack (spacing: 10){
                            
                            // Top bar contains deliver now and current location
                            // TODO the current location will be updated with user current location
                            TopBar()
                                .padding(.top, 0)
                            
                        
                            //Search bar + qr scan + filter
                            CustomSearchBar().padding(.bottom, 15)
                            
                            ScrollView(.horizontal){
                                VStack(spacing: 10){
                                    HStack(spacing:10) {
                                        Spacer().frame(width: 6)
                                        CategoryCard(image: "burger", text: "Burger")
                                        CategoryCard(image: "pizza", text: "Pizza")
                                        CategoryCard(image: "chicken", text: "Chicken")
                                        CategoryCard(image: "fries", text: "Fries")
                                        CategoryCard(image: "nuggets", text: "Nuggets")
                                        CategoryCard(image: "pasta", text: "Pasta")
                                        Spacer()
                                    }
                                    HStack(spacing:10) {
                                        Spacer().frame(width: 6)
                                        CategoryCard(image: "ice_cream", text: "Ice Cream")
                                        CategoryCard(image: "drinks", text: "Drinks")
                                        CategoryCard(image: "shawarma", text: "Shawarma")
                                        CategoryCard(image: "cake", text: "Desserts")
                                        CategoryCard(image: "paratha", text: "Paratha")
                                        CategoryCard(image: "biryani", text: "Biryani")
                                        Spacer()
                                    }
                                }
                            }
                            .padding(.horizontal, -16)
                            .scrollIndicators(.hidden)
                            
                            // TODO add horizontal scroll on multiple offers
//                            GeometryReader{ geometry in
                                ScrollView(.horizontal){
                                    HStack{
                                        Spacer().frame(width: 16)
                                        OfferCard()
                                        OfferCard()
                                        Spacer()
                                    }
                                    
                                    
                                }
                                .padding(.horizontal, -16)
//                            }
                            
                            
                            //Section Title Row
                            HStack{
                                SectionTitle("Recommended for you")
                                Spacer()
                            }
                            
                            
                            LazyVGrid(columns: grid_2x2){
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
                        .blur(radius: showDetailScreen ? 40 : 0)
                    }
                    
                }
                .scrollIndicators(.hidden)
                .overlay(alignment: .bottom){
                    ZStack {
                        
                        Rectangle()
                            .frame(height: 100)
                            .foregroundStyle(LinearGradient(colors: [.white.opacity(0), .white], startPoint: .top, endPoint: .bottom))
                        
                        NavigationBar()
                            .padding(.bottom, 20)
                            
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .ignoresSafeArea(edges: .bottom)
                }
                
                if showDetailScreen {
                    FoodDetailScreen(foodItem: selectedFoodItem ?? foodList.first!, showDetailScreen: $showDetailScreen, imageTransition: imageTransition)
                        .transition(.opacity)
                        
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
        
        VStack(alignment: .center) {
            // Invisible Gap above image
            Rectangle().frame(height: 50).opacity(0)
            
            
            VStack(spacing: 7){
                Rectangle().frame(height: 65).opacity(0)
                Text(foodItem.name)
                    .font(.system(size: 17, design: .rounded))
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .modifier(MeasureHeightModifier(height: $titleHeight))
                
                HStack(spacing: 10){
                    
                    // Rating Section
                    HStack(spacing: 0){
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        Text("4.7")
                    }
                    
                    // Preparation Time Section
                    HStack(spacing: 0){
                        Image(systemName: "clock")
                        Text("10-15 min")
                    }
                    .foregroundStyle(.secondary)
                }
                .font(.system(size: 13, design: .rounded))
                .fontWeight(.semibold)
                
                Spacer()
                Text("Rs.\(foodItem.price)")
                    .font(.system(size: 17, design: .rounded))
                    .fontWeight(.semibold)
                Spacer()
                
            }
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.33)
                .frame(width: 165, height: 165))
            .frame(width: 165, height: 165)
            .overlay(alignment: .top){
                Image(foodItem.image)
                    .resizable()
                    .scaledToFit()
                    .matchedGeometryEffect(id: foodItem.id, in: imageTransition)
                    .frame(width: 130, height: 130)
                    .offset(y: -65)
                
            }
        }
    }
}
struct CategoryCard: View{
    var image: String
    var text: String
    
    var body: some View{
        VStack(spacing: 6){
            Image(image)
                .resizable()
                .scaledToFit()
                .padding(5)
                .frame(width: 64, height: 64)
                .clipShape(.rect(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.black, lineWidth: 0.33))
            
            Text(text)
                .font(.system(size: 11, design: .rounded))
                .fontWeight(.semibold)
        }
        
    }
}

struct TopBar: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 0){
                Text("Deliver now")
                    .font(.system(.footnote))
                    .foregroundStyle(.gray)
                
                HStack{
                    Text("Islamabad, Pakistan")
                        .font(.system(.headline))
                    Image(systemName: "chevron.down")
                }
                
            }
            Spacer()
            HStack(spacing: 5){
                Button("profile", systemImage: "person.fill", action: {})
                .labelStyle(.iconOnly)
                .buttonBorderShape(.circle)
                .buttonStyle(.bordered)
                .tint(.accentColor)
                
                Button("notification", systemImage: "bell", action: {})
                    .labelStyle(.iconOnly)
                    .buttonBorderShape(.circle)
                    .buttonStyle(.borderedProminent)
                    .tint(.accentColor)
            }
        }
    }
}
struct OfferCard: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("Hot & Crispy Offer")
                    .font(.custom("ButterChicken", size: 28))
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(2)

                Text("Get up to 20% off.")
                    .font(.system(size: 13, design: .rounded))

                Text("on your first order")
                    .font(.system(size: 11, design: .rounded))
                    .foregroundStyle(.primary)

                Button {
                    // Action
                } label: {
                    Text("Order Now")
                }
                .buttonStyle(.borderedProminent)
                .tint(.accentColor)
                .controlSize(.small)
            }
            .padding(20)
        }
        
        .background(Color.white)
        .overlay {
            Image("doodle")
                .resizable()
                .scaledToFill()
                .allowsHitTesting(false)
        }
        .overlay(alignment: .trailing) {
            Image("deal")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 165)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 0.4)
        }
        .clipped()
        .frame(width: UIScreen.main.bounds.width - 32)
    }
}



struct CustomSearchBar: View {
    
    @State var searchText: String = ""
    
    var body: some View {
        HStack (spacing: 2){
            TextField("Search", text: $searchText)
            
                .padding(.horizontal, 30)
                .padding(.vertical, 5)
                .background(Color(.systemGray6))
                .clipShape(.rect(cornerRadius: 10))
                .overlay(alignment: .leading){
                    Image(systemName: "magnifyingglass")
                        .padding(8)
                        .foregroundStyle(.secondary)
                }
            
            Button("qr_scan", systemImage: "qrcode.viewfinder", action: {})
                .buttonStyle(.bordered)
                .labelStyle(.iconOnly)
                .buttonBorderShape(.circle)
                .tint(.accentColor)
            
            
            Rectangle()
                .frame(width:0.33, height: 24)
            
            Button("filter", systemImage: "line.3.horizontal.decrease.circle", action: {})
                .buttonStyle(.bordered)
                .labelStyle(.iconOnly)
                .buttonBorderShape(.circle)
                .tint(.accentColor)
            
        }
    }
}
