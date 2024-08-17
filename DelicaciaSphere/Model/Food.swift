//
//  Food.swift
//  DelicaciaSphere
//
//  Created by Zohaib Ahmed on 8/17/24.
//

import Foundation

enum FoodCategory: String {
    case burger = "Burger"
    case pizza = "Pizza"
    case chicken = "Chicken"
    case drink = "Drink"
    case fries = "Fries"
}

class Food: Identifiable {
    let id = UUID()
    var name: String = ""
    var description: String = ""
    var image: String
    var kcal: CGFloat
    var proteins: CGFloat
    var fats: CGFloat
    var carbo: CGFloat
    var price: CGFloat
    var category: FoodCategory
    
    init(name: String, description: String, image: String, kcal: CGFloat, proteins: CGFloat, fats: CGFloat, carbo: CGFloat, price: CGFloat, category: FoodCategory) {
        self.name = name
        self.description = description
        self.image = image
        self.kcal = kcal
        self.proteins = proteins
        self.fats = fats
        self.carbo = carbo
        self.price = price
        self.category = category
    }
    
}

let foodList: [Food] = [
    Food(name: "Classic Cheeseburger",
         description: "A juicy beef patty topped with melted cheese, fresh lettuce, and tomatoes.",
         image: "burger",
         kcal: 450,
         proteins: 25,
         fats: 22,
         carbo: 35,
         price: 5.99,
         category: .burger),
    
    Food(name: "Pepperoni Pizza",
         description: "A classic pizza with tangy tomato sauce, gooey cheese, and pepperoni slices.",
         image: "pizza",
         kcal: 300,
         proteins: 12,
         fats: 14,
         carbo: 33,
         price: 7.99,
         category: .pizza),
    
    Food(name: "Grilled Chicken Sandwich",
         description: "Tender grilled chicken breast, served on a toasted bun with lettuce and mayo.",
         image: "chicken",
         kcal: 400,
         proteins: 35,
         fats: 15,
         carbo: 35,
         price: 6.99,
         category: .chicken),
    
    Food(name: "Coca-Cola",
         description: "A refreshing cold drink to complement your meal.",
         image: "drink",
         kcal: 150,
         proteins: 0,
         fats: 0,
         carbo: 40,
         price: 1.50,
         category: .drink),
    
    Food(name: "Crispy French Fries",
         description: "Golden, crispy fries seasoned to perfection.",
         image: "fries",
         kcal: 320,
         proteins: 4,
         fats: 15,
         carbo: 45,
         price: 2.99,
         category: .fries)
]
