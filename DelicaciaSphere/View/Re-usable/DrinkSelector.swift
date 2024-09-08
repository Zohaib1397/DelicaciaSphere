import SwiftUI

struct DrinkSelector: View {
    
    @Binding var selectedIndex: Int?
    
    var itemHeight: CGFloat = 120.0
    var menuHeightMultiplier: CGFloat = 5
    
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(0..<drinks.count, id: \.self){ index in
                    let drink = drinks[index]
//                    let indexDiff = Double(index-(selectedIndex ?? 0))
                    Image(drink)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(selectedIndex == index ? 1.2 : 1)
                        .animation(.bouncy, value: selectedIndex)
                        .id(index)
                        .frame(height: itemHeight)
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: $selectedIndex, anchor: .center)
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 10)
        )
    }
}
let drinks = [
    "pepsi",
    "cocacola",
    "fanta",
    "7up",
    "sprite",
    "sting",
    "nextcola",
    "dew",
    "mirinda",
    
    "pepsi",
    "cocacola",
    "fanta",
    "7up",
    "sprite",
    "sting",
    "nextcola",
    "dew",
    "mirinda",
    "pepsi",
    "cocacola",
    "fanta",
    "7up",
    "sprite",
    "sting",
    "nextcola",
    "dew",
    "mirinda",
    "pepsi",
    "cocacola",
    "fanta",
    "7up",
    "sprite",
    "sting",
    "nextcola",
    "dew",
    "mirinda"
    ]

struct WheelPickerDemo: View {
    
    @State var selectedIndex: Int? = 3

    var body: some View {
        VStack(spacing: 40) {
            Text("Drink Selected \(drinks[selectedIndex ?? 0])")
                .foregroundStyle(Color.white)
                .padding()
                .background(RoundedRectangle(cornerRadius: 16))
            DrinkSelector(selectedIndex: $selectedIndex)

        }
    }
}


#Preview {
    WheelPickerDemo()
}
