import SwiftUI

var mainReward : [Reward] = UserDefaults.rewardArray ?? []



let columns = [
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible())
]


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
        print("-------------------")
        print(dateCriteria)
//        print(DateReward)
        print("-------------------")
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
                            Button(
                                action: {
                                    selectedDate = index
                                    initRewardCardInfo(index: index)
                                }, label:{
                                    Text("\(dateCircle[index])")
                                }).buttonStyle(DateButtonStyle())
                        }
                    } // : 날짜 Hstack
                    .padding()
                }// :ScrollView
                Spacer()
                ScrollView(.horizontal, showsIndicators: false){
//                    HStack{
                        LazyVGrid(
                            columns: columns,
                            alignment: .center,
                            spacing: 6,
                            pinnedViews: [],
                            content: {
                        ForEach(RewardCardInfo, id: \.self.id) { reward in
                            VStack{
                                Text("\(reward.date)")
                                Text("\(reward.category[0])")
                                    .font(Font.system(size: 50, design: .default))
                                Text("\(reward.title)").foregroundColor(Color.black)
                            }// : VStack
                            .padding(20)
                            .frame(height: 160)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(lineWidth: 1)
                            )
                        }.padding(10)
                            }) // : LazyVGrid
                    }
                }
            }
            
            
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
//            Spacer()
            
//            ScrollView(.horizontal, showsIndicators: false){
//                ForEach(RewardDateDictionary[0], id: \.self.id) { reward in
//                    let rewardCard = Button(action: {
//                        isDetailView.toggle()
//                    }){
//                        VStack{
//                            Text("\(reward.category[0])")
//                                    .font(Font.system(size: 50, design: .default))
//                            Text("\(reward.title)").foregroundColor(Color.black)
//                        }// : VStack
//                        .padding(20)
//                        .frame(height: 160)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 15)
//                                .stroke(lineWidth: 1)
//                        )
//                    }.padding(10)
//                        .fullScreenCover(isPresented: $isDetailView) {
//                            DetailView(isFullScreen: $isDetailView)
//                        }
//                    if(reward.isEffective == nil){
//                        rewardCard.foregroundColor(Color.blue)
//                    }else{
//                        rewardCard.foregroundColor(Color.black)
//                    }
//                }
//            }
//        }
//        .padding(.horizontal, 24.0)
        
//    }
}

struct RewardCard3: View {
    
    var body: some View {
        VStack(){
            Text("list.Dday")
                .font(.system(size: 10, weight: .light))
            Circle().frame(width: 60, height: 60)
            Text("list.title")
        }
        .frame(width: 106.0, height: 140.0)
        .background(Color.gray)
        .cornerRadius(20)
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
