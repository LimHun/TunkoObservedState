import SwiftUI

class ViewModel: ObservableObject {
    @Published var value: Int = 0
    func increment() {
        value += 1
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: RootView()) {
                    Text("Go to First Destination")
                }
                NavigationLink(destination: ScrollContentView()) {
                    Text("Go to Second Destination")
                }
            }
            .navigationTitle("List")
        }
    }
}

struct RootView: View {
    
    @State var rootCount: Int = 0
    
    var body: some View {
        VStack {
            Button {
                rootCount += 1
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.orange)
                    .frame(width: 300, height: 500)
                    .overlay {
                        Text("\(rootCount)")
                            .font(.system(size: 60))
                            .foregroundColor(.black)
                            .vAlign(.top)
                            .hAlign(.center)
                            .padding(.top, 30)
                    }
            }
            
            
        }
        .overlay {
            SubView(rootCount: rootCount)
                .vAlign(.bottom)
                .padding(.bottom, 40)
        }
    }
}

struct SubView: View {
    @StateObject var stateViewModel = ViewModel()
    @ObservedObject var observedViewModel = ViewModel()
    var rootCount: Int
    
    var body: some View {
        VStack {
            Button {
                
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.black)
                    .frame(width: 200, height: 100)
                    .overlay {
                        VStack {
                            Text("@State")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                            Text("\(rootCount)")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                        }
                    }
            }
            
            VStack {
                Button {
                    stateViewModel.increment()
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.red)
                        .frame(width: 200, height: 100)
                        .overlay {
                            VStack {
                                Text("@StateObject")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                                Text("\(stateViewModel.value)")
                                    .font(.system(size: 40))
                                    .foregroundColor(.white)
                            }
                        }
                }
                
                Button {
                    observedViewModel.increment()
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 200, height: 100)
                        .overlay {
                            VStack {
                                Text("@ObservedObject")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                                Text("\(observedViewModel.value)")
                                    .font(.system(size: 40))
                                    .foregroundColor(.white)
                            }
                        }
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
