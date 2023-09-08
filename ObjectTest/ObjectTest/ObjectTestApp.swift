import SwiftUI

@main
struct ObjectTestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView() 
        }
    }
}

extension View {
    func hAlign(_ aligment: Alignment) -> some View {
        self.frame(maxWidth: .infinity, alignment: aligment)
    }
    
    func vAlign(_ aligment: Alignment) -> some View {
        self.frame(maxHeight: .infinity, alignment: aligment)
    }
}
