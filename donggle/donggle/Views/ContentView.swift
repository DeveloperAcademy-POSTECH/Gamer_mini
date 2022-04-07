import SwiftUI

struct ContentView: View {
    @State private var showModal = false
    var body: some View {
        NavigationView {
            CustomTapView()
                .toolbar {
                    ToolbarItem(placement:.navigationBarTrailing) {
                        NavigationLink(
                            destination: TimelineView(),
                            label: {
                                Text("Timeline")
                                    .padding(10)
                            })
                    }
                    ToolbarItem(placement:.navigationBarLeading) {
                            Button(action: {
                                self.showModal = true
                            }) {
                                Text("4월")
                                    .foregroundColor(.black)
                                    .font(.title2)
                                    .padding(10)
                            }
                            .sheet(isPresented: self.$showModal) {
                                ModalView()
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
