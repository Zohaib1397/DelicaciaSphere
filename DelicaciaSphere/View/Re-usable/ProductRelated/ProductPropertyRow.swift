//
//  ProductPropertyRow.swift
//  DelicaciaSphere
//
//  Created by Zohaib Ahmed on 9/8/24.
//

import SwiftUI

struct ProductPropertyRow: View {
    
    var preparationTime: String
    var deliveryCost: String
    var rating: String
    var totalRatings: String
    
    var body: some View {
        HStack{
            // Preparation Time
            CustomLabel(image: "clock", text: preparationTime, color: .cyan)
            Spacer()
            //Delivery Cost
            CustomLabel(image: "truck.box", text: deliveryCost, color: .green)
            Spacer()
            //Rating
            CustomLabel(image: "star.fill", text: rating, color: .yellow, subText: totalRatings)
        }
    }
}

