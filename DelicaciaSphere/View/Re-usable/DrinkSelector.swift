import SwiftUI
import AudioToolbox


struct DrinkSelector: View {
    
    @Binding var selectedIndex: Int?
    var soundId: SystemSoundID = 1105
    
    let maxScale: CGFloat = 1  // Maximum scale for the selected item
    let minScale: CGFloat = 0.4  // Minimum scale for distant items
    let scaleRange: Int = 4      // How many items on each side to scale
    
    var body: some View {
        
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                HStack(spacing: 15) {
                    ForEach(0..<drinks.count, id: \.self) { index in
                        
                        let drink = drinks[index]
                        let distance = abs((selectedIndex ?? 0) - index)
                        let scale = scaleEffectForDistance(distance: distance)
                        
                        BottleImage(drink: drink, scale: scale, selectedIndex: $selectedIndex, index: index)
                            
                    }
                    
                }
                .padding(.vertical, 20)
                .scrollTargetLayout()
                .padding(.horizontal, 35 * 5)
                .onAppear {
                    if let index = selectedIndex {
                        proxy.scrollTo(index, anchor: .center)
                    }
                }
            }
        }
        .background{
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    .shadow(.inner(color: .black, radius: 7.3, x: 0, y: 1))
                )
                .foregroundStyle(Color(.tertiarySystemFill))
                .frame(height: 180)
        }
        .scrollPosition(id: $selectedIndex, anchor: .center)
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
        .onChange(of: selectedIndex, initial: false) {
            AudioServicesPlaySystemSound(soundId)
        }
        .overlay{
            RoundedRectangle(cornerRadius: 10)
                .fill(.linearGradient(colors: [.white, .white.opacity(0.70), .white.opacity(0),.white.opacity(0), .white.opacity(0), .white.opacity(0.70), .white], startPoint: .leading, endPoint: .trailing))
                .blur(radius: 40)
                .allowsHitTesting(false)
        }
    }
    
    // Function to calculate scale effect based on distance
    func scaleEffectForDistance(distance: Int) -> CGFloat {
        if distance > scaleRange {
            return minScale
        }
        let scaleFactor = maxScale - CGFloat(distance) * (maxScale - minScale) / CGFloat(scaleRange)
        return max(minScale, scaleFactor)
    }
}
let drinks: [(name: String, type: RefreshingDrinkType)] = [
    (name: "pepsi", type: .bottle),
    (name: "cocacola", type: .bottle),
    (name: "fanta", type: .bottle),
    (name: "7up", type: .bottle),
    (name: "sprite", type: .bottle),
    (name: "sting", type: .bottle),
    (name: "nextcola", type: .bottle),
    (name: "dew", type: .bottle),
    (name: "mirinda", type: .bottle),
    (name: "7up_can", type: .can),
    (name: "redbull", type: .can),
    (name: "sting_can", type: .can),
    (name: "pepsi_can", type: .fatCan),
    (name: "cocacola_can", type: .fatCan),
    (name: "fanta_can", type: .fatCan),
    (name: "mirinda_can", type: .fatCan),
    (name: "sprite_can", type: .fatCan),
]

enum RefreshingDrinkType{
    case can
    case bottle
    case fatCan
}

struct WheelPickerDemo: View {
    
    @State var selectedIndex: Int? = 4

    var body: some View {
        VStack(spacing: 40) {
            Text("Drink Selected \(drinks[selectedIndex ?? 0].name)")
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

struct SelectionBoarder: View {
    var body: some View {
        Image("Subtract")
            .resizable()
            .scaledToFit()
            .padding(.horizontal, -10)
            .frame(width: 55, height: 250)
            .zIndex(3)
    }
}

struct BottleImage: View {
    var drink: (name: String, type: RefreshingDrinkType)
    var scale: CGFloat
    @Binding var selectedIndex: Int?
    var index: Int

    var body: some View {
        Image(drink.name)
            .resizable()
            .scaledToFit()
            .scaleEffect(scale)  // Apply the scale effect
            .animation(.bouncy.speed(3), value: selectedIndex)
            .id(index)
            .overlay {
                if selectedIndex == index {
                    SelectionBoarder()
                }
            }
            .frame(height: drink.type == .bottle ? 173.5 : drink.type == .can ? 120 : 105)
            .shadow(radius: 5, y: 4)
            .onTapGesture {
                withAnimation{
                    selectedIndex = index
                }
            }
    }
}

