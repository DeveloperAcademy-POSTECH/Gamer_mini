import SwiftUI


var dateCircle : [String] = []

//Date String 추출 -> 중복값 삭제 후 정렬
let RewardDate : [String] = Array(Set(mainReward.map { reward in
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY년 M월 d일"
    
    return formatter.string(from: reward.date)
})).sorted(by: <)

// Date에 해당하는 보상 넣기
var RewardDateArray : [[Reward]] = []

func InitRewardDateArray() {
    RewardDate.forEach { dateCriteria in
        let DateReward = mainReward.filter{(reward : Reward)-> Bool in
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY년 M월 d일"
            return dateCriteria == formatter.string(from: reward.date)
        }
//        print("-------------------")
//        print(dateCriteria)
//        //        print(DateReward)
//        print("-------------------")
        RewardDateArray.append(DateReward)
    }
}

func initDateCircle(){
    let array = RewardDateArray.map { array -> String in
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월 d일"
        let date = formatter.string(from: array[0].date)
        //        print(date)
        //        print("--")
        //        print(String(date.split(separator: " ")[2].split(separator: "일")[0]))
        //        print("--")
        return String(date.split(separator: " ")[2].split(separator: "일")[0])
    }
    dateCircle = array
}

var RewardCardInfo : [Reward] = []

func initRewardCardInfo(index : Int){
    RewardCardInfo = RewardDateArray[index]
}

struct HomeView: View {
    @State private var showModal = false
    @State var sliderValue : Double = UserDefaults.standard.double(forKey:"sliderValue")
    @State var stressIndex : Int = UserDefaults.standard.integer(forKey:"stressIndex")
    
    @State private var selectedDate : Int = 0
    
    @GestureState var isLongPressed = false
    @State private var isDetailView = false
    
    @State var offset: CGSize = .zero
    
    var body: some View {
        
        let longPressGesture = LongPressGesture()
            .updating($isLongPressed){ newValue, state, transaction in
                state = newValue
                
                InitRewardDateArray()
                initDateCircle()
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
                    .padding(.leading, 20)
                    .onAppear()
                
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
            .padding()
            
            Circle()
                .fill(Color.init(red: (sliderValue+1)*2/255, green: (101-sliderValue)*2/255, blue: (101-sliderValue)*2/255))
                .frame(width: 200.0, height: 200.0)
                .padding(50)
                .scaleEffect(isLongPressed ? 1.15 : 1)
                .gesture(longPressGesture)
                .animation(.spring())
                .offset(x: offset.width, y: offset.height)
                .gesture(dragGesture)
                .animation(.default)
            //.position(x:195, y:0)
            Text("\(stressIndex)%")
                .font(.system(size: 24, weight: .regular))
                .foregroundColor(Color.gray)
            Divider()
            Spacer().frame(height: 10)
            
            if(dateCircle.count == 0){
                
                //                HStack{
                //                    ForEach(dateCircle1, id: \.self){ index in
                //                        Button(
                //                            action: {
                //                                selectedDate = Int(index) ?? 0
                //                            }, label:{
                //                                Text("\(index)")
                //                            }).buttonStyle(DateButtonStyle())
                //                    }
                //                }
                //                .padding()
                
                Text("아직 입력하신 보상이 없습니다 ~ !!")
                    .padding(20)
                    .frame(maxWidth:.infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 1)
                    ).padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                Spacer()
            }else{
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(dateCircle.indices, id: \.self){ index in
                            if(index < 7){ // 터치하는 거 알아보기
                                Button(
                                    action: {
                                        selectedDate = index
                                        initRewardCardInfo(index: index)
                                    }, label:{
                                        Text("\(dateCircle[index])")
                                    }).buttonStyle(DateButtonStyle())
                            }
                        }
                    } // : 날짜 Hstack
                    .padding()
                }// :ScrollView
                Spacer()
                ScrollView(.horizontal, showsIndicators: false){
                    
                    HStack{
                        ForEach(RewardCardInfo, id: \.self.id) { reward in
                            VStack{
                                Text("\(reward.date)")
                                Text("\(reward.category[0])")
                                //                                    .font(Font.system(size: 50, design: .default))
                                Text("\(reward.title)").foregroundColor(Color.black)
                            }// : VStack
                            .padding(20)
                            .frame(width: 120, height: 160) // 가로값 고정 x...!
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(lineWidth: 1)
                            )
                        }.padding(10)
                    }
                }
            }
        }    }
}


struct 보상card: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    var body: some View {
        Button(action: self.action) {
            VStack{
                Text("☺️")
                Text(self.title).foregroundColor(Color.black)
            }.background(self.isSelected == false ? nil : RoundedRectangle(cornerRadius: 10).fill(Color.init(red: 193/255, green: 233/255, blue: 252/255)))
        }
    }
}

struct DateButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 22, height: 22)
            .padding(10)
            .foregroundColor(.white)
            .background(configuration.isPressed ? Color.yellow : Color.white)
            .cornerRadius(30)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
