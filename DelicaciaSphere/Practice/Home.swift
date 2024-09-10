//
//  Home.swift
//  DelicaciaSphere
//
//  Created by Zohaib Ahmed on 9/10/24.
//

import SwiftUI

struct Home: View {
    var size: CGSize
    var safeArea: EdgeInsets
    var foodItem: Food = foodList.first!
    
    @State private var offsetY: CGFloat = 0
    
    @Namespace var imageTransition
    
    @State var desiredSize: ProductSize = ProductSize.Mini
    @State var selectedIndex: Int? = 4
    
    @State var selectedItem = 0
    @State var selectedDrink: Int? = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 0){
                HeaderView()
                    .zIndex(1000)
                
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 10){
                        
                        
                        
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
                        DrinkSelector(selectedIndex: $selectedIndex)
                        Rectangle()
                            .fill(Color(.white.opacity(0)))
                            .frame(height: 100)
                            
                    }
                    
                }
                .scrollIndicators(.hidden)
                    
            }
            .background{
                ScrollDetector{ offset in
                    offsetY = -offset
                } onDragggingEnd: { offset, velocity in
                    print("Scroll Released")
                }
                
            }
        }
    }
    
    @ViewBuilder
    func HeaderView() -> some View{
        let headerHeight = (size.height * 0.45) + safeArea.top
        let minimumHeaderHeight = 65 + safeArea.top
        
        let progress = max(min(-offsetY / (headerHeight - minimumHeaderHeight), 1), 0)
        GeometryReader{ _ in
            ZStack{
                Rectangle()
                    .fill(.accent.gradient)
                
                VStack(spacing: 15){
                    GeometryReader{
                        let rect = $0.frame(in: .global)
                        let halfScaledHeight = (rect.height * 0.3) * 0.5
                        let midY = rect.midY
                        let bottomPadding: CGFloat = 15
                        let resizedOffsetY = (midY - (minimumHeaderHeight - halfScaledHeight - bottomPadding))
    //
                        VStack(alignment: .center){
                            // Top Row Back Button + Heart Button
                            HStack(alignment: .top){
                                CircularIconButton(label: "back", image: "chevron.left",size: .regular, action: {
    //                                withAnimation{showDetailScreen.toggle()}
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
                            HStack {
                                Spacer()
                                Image(foodItem.image)
                                    .resizable()
                                    .scaledToFit()
                                    .shadow(radius: 25, y: 7)
                                    .matchedGeometryEffect(id: foodItem.id, in: imageTransition)
                                    .scaleEffect(1 - (progress * 0.7), anchor: .leading)
                                    .offset(x: -(rect.minX - 15) * progress, y: -resizedOffsetY * progress)
                                Spacer()
                            }
                            .overlay{
                                Image(foodItem.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 265)
                                    .shadow(radius: 25, y: 7)
                                    .offset(x: -280 - (progress * 200), y: -40)
                                Image(foodItem.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 265)
                                    .shadow(radius: 25, y: 7)
                                    .offset(x: 280 + (progress * 200), y: -40)
                            }
                            .zIndex(0)
                        }
                    }
                    .frame(width: size.width, height: headerHeight * 0.7)
                    //Title
                    HStack(alignment: .bottom) {
//                        Text(foodItem.name)
                        Text("\(progress)")
                            .font(.system(size: 28, design: .rounded))
                            .scaleEffect(1 - (progress * 0.15))
                            .offset(y: -4.5 * progress)
                        Image(systemName: "chevron.down")
                            .font(.system(size: 17, design: .rounded))
                            .padding(.bottom, 5)
                        Spacer()
                        
                    }
                    .fontWeight(.heavy)
                }
                .padding(.top, safeArea.top)
                .padding(.bottom, 15)
            }
            .frame(height: (headerHeight + offsetY) < minimumHeaderHeight ? minimumHeaderHeight : (headerHeight + offsetY), alignment: .bottom)
            //Sticking to the top
            .offset(y: -offsetY)
        }
        .frame(height: headerHeight)
        
    }
}

#Preview {
    ContentView()
}
