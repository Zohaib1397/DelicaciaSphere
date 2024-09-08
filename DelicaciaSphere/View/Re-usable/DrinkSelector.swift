import SwiftUI
import AudioToolbox

struct DrinkSelector: View {
    
    @Binding var selectedIndex: Int?
    var soundId: SystemSoundID = 1105
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                HStack {
                    Spacer().frame(width: 170)
                    ForEach(0..<drinks.count, id: \.self) { index in
                        let drink = drinks[index]
                        Image(drink)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(selectedIndex == index ? 1 : 0.8)
                            .animation(.bouncy, value: selectedIndex)
                            .id(index)
                            .frame(height: 173.5)
                    }
                    Spacer().frame(width: 170)
                }
                .scrollTargetLayout()
                .onAppear {
                    if let index = selectedIndex {
                        proxy.scrollTo(index, anchor: .center)
                    }
                }
            }
        }
        .scrollPosition(id: $selectedIndex, anchor: .center)
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
        .onChange(of: selectedIndex, initial: false) {
                    AudioServicesPlaySystemSound(soundId)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray), lineWidth: 10)
                .frame(width: 65, height: 190)
        }
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
