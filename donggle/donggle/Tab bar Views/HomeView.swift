import SwiftUI

struct HomeView: View {
    @State private var showModal = false
    @State var sliderValue : Double = UserDefaults.standard.double(forKey:"sliderValue")
    @State var stressIndex : Int = UserDefaults.standard.integer(forKey:"stressIndex")
    
    @State private var showDetails = false
    
    @GestureState var isLongPressed = false
    
    @State var offset: CGSize = .zero
    
    var body: some View {
        let dateList = ["1", "2", "3", "4", "5"]
        
        var selectedDate = 0
        
        let longPressGesture = LongPressGesture()
            .updating($isLongPressed){ newValue, state, transaction in state = newValue
            }
        let dragGesture = DragGesture()
            .onChanged{ value in
                //let point = value.location
                self.offset = value.translation
            }
        
        VStack{
            HStack{
                Text("동글이")
                    .font(.system(size: 28, weight: .bold))
                    
                Spacer()
                Button(action: {
                self.showModal = true
                }){
                    Image(systemName: "square.and.pencil")
                        .imageScale(.large)
                }
                .sheet(isPresented: self.$showModal) {
                    RecordView(stressIndex: $stressIndex ,sliderValue: $sliderValue)
                }
            }
            .padding(.top, 40.0)
            

            donggle(TopPointX: 100, TopPointY: 0, RightPointX: 200, RightPointY: 100, BottomPointX: 100, BottomPointY: 200, LeftPointX: 0, LeftPointY: 100)
          
//             Circle()
//                 .fill(Color.init(red: (sliderValue+1)*2/255, green: (101-sliderValue)*2/255, blue: (101-sliderValue)*2/255))
//                 .frame(width: 200.0, height: 200.0)
//                 .padding(50)
//                 .scaleEffect(isLongPressed ? 1.15 : 1)
//                 .gesture(longPressGesture)
//                 .animation(.spring())
//                 .offset(x: offset.width, y: offset.height)
//                 .gesture(dragGesture)
//                 .animation(.default)

            Text("\(stressIndex)%")
                .font(.system(size: 24, weight: .regular))
                .foregroundColor(Color.gray)
            Divider()
            Spacer().frame(height: 10)
            HStack{
                ForEach(dateList, id: \.self){ index in
                    Button(
                        action: {
                            self.showDetails.toggle()
                            selectedDate = Int(index) ?? 0
                        }, label:{
                            Text(index)
                        }).buttonStyle(DateButtonStyle())
                }
            }
            .padding()
            
            if showDetails{
                if selectedDate == 1{
                    RewardCard2()
                }else{
                }
                HStack{
                    RewardCard2()
                    Spacer()
                    RewardCard2()
                    Spacer()
                    RewardCard2()
                }
            }
            Spacer()
        }
        .padding(.horizontal, 24.0)
        
    }
}

struct DateButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 30.0, height: 30.0)
            .padding()
            .foregroundColor(.white)
            .background(configuration.isPressed ? Color.red : Color.gray)
            .cornerRadius(30)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
