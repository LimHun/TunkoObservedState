import SwiftUI

struct ScrollContentView: View {
    
    @State var offset: CGFloat = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                Group {
                    CellStateText(color: Color.red)
                    CellStateText(color: Color.orange)
                    CellStateText(color: Color.yellow)
                    CellObservedText(color: Color.green)
                    CellObservedText(color: Color.blue)
                    CellObservedText(color: Color.purple)
                }
                Group {
                    CellStateText(color: Color.red)
                    CellStateText(color: Color.orange)
                    CellStateText(color: Color.yellow)
                    CellObservedText(color: Color.green)
                    CellObservedText(color: Color.blue)
                    CellObservedText(color: Color.purple)
                }
                Group {
                    CellStateText(color: Color.red)
                    CellStateText(color: Color.orange)
                    CellStateText(color: Color.yellow)
                    CellObservedText(color: Color.green)
                    CellObservedText(color: Color.blue)
                    CellObservedText(color: Color.purple)
                }
            }
            .frame(height: 1500)
            .modifier(OffsetModifier(offset: $offset))
            
        }
        .onChange(of: offset) { newValue in
            print("newValue: \(offset)")
        }
    }
}

final class ScrollViewModel: ObservableObject {
    @Published var value: Int = 0
    init() {
        value = Int.random(in: 1...100)
    }
}

struct CellObservedText: View {
    @ObservedObject var viewModel = ScrollViewModel()
    var color: Color
    var body: some View {
        Rectangle()
            .fill(color)
            .overlay {
                Text("\(viewModel.value)")
                    .font(.system(size: 80))
                    .fontWeight(.black)
            }
    }
}

struct CellStateText: View {
    @StateObject var viewModel = ScrollViewModel()
    var color: Color
    var body: some View {
        Rectangle()
            .fill(color)
            .overlay {
                Text("\(viewModel.value)")
                    .font(.system(size: 80))
                    .fontWeight(.black)
            }
    }
} 

struct ScrollContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollContentView()
    }
}

struct OffsetModifier: ViewModifier {
    @Binding var offset: CGFloat
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { proxy -> Color in
                    let minY = proxy.frame(in: .global).minY
                    DispatchQueue.main.async {
                        self.offset = minY
                    }
                    return Color.clear
                }, alignment: .top)
    }
}
