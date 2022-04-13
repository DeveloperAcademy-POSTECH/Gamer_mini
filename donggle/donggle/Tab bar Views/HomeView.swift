import SwiftUI

class ReloadHomeView: ObservableObject {
    @Published var RewardDate2 : [String] = []
    @Published var RewardDateArray2 : [[Reward]] = []
    @Published var dateCircle2 : [String] = []
    @Published var RewardCardInfo2 : [Reward] = []
    
    func initRewardDate()-> [String] {

        var RewardDate : [String] = Array(Set(mainReward.map { reward in
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY년 M월 d일"

            return formatter.string(from: reward.date)
        })).sorted(by: <)

        if(RewardDate.count > 7){
            RewardDate.removeSubrange(7...RewardDate.count-1)
        }

        return RewardDate
    }

    func initRewardDateArray(RewardDate : [String])-> [[Reward]] {

        var RewardDateArray : [[Reward]] = []

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

        return RewardDateArray
    }


    func initDateCircle(RewardDateArray: [[Reward]])-> [String]{

        var dateCircle: [String] = []

        let array = RewardDateArray.map { array -> String in
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY년 M월 d일"
            let date = formatter.string(from: array[0].date)
            return String(date.split(separator: " ")[2].split(separator: "일")[0])
        }

        dateCircle = array

        return dateCircle
    }

    
    func shuffle() {
        print("shuffleDance")
        RewardDate2 = initRewardDate()
        RewardDateArray2 = initRewardDateArray(RewardDate: RewardDate2)
        dateCircle2 = initDateCircle(RewardDateArray: RewardDateArray2)
        RewardCardInfo2 = RewardDateArray2.count==0 ? [] : RewardDateArray2[0]
    }
}

struct HomeView: View {
    
    @ObservedObject var reloadHomeView = ReloadHomeView()
    
    func shuffle() {
        self.reloadHomeView.shuffle()
    }
    
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
            }
//                //드래그 가로의 위치가 -100보다 작은 위치로 가면 실행
//                if $0.translation.width < -100 {
//                    self.offset = .init(width: -1000, height: 0)
//                //드래그 가로의 위치가 100보다 커지면 실행
//                } else if $0.translation.width > 100 {
//                    self.offset = .init(width: 1000, height: 0)
//                //아니면 원래 위치로 돌아감
//                } else {
//                    self.offset = .zero
//                }
        
        let dragGesture = DragGesture()
            .onChanged{ value in
                //let point = value.location
                self.offset = value.translation
            }
        
        VStack{
            HStack{
//                Text(self.reloadHomeView.RewardDate2[self.reloadHomeView.RewardDate2.count-1])
                
                Text("동글이")
                    .font(.system(size: 28, weight: .bold))
                Spacer()
                Button(action: {
                    self.showModal = true
                }){
                    Image(systemName: "square.and.pencil")
                        .imageScale(.large)
                        .foregroundColor(.black)
                }
                .sheet(isPresented: self.$showModal) {
                    RecordView(stressIndex: $stressIndex ,sliderValue: $sliderValue)
                        .onDisappear{
                            self.shuffle()
                        }
                }
            }
            .padding(.horizontal, 24.0)
            
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
            
            Text("\(stressIndex)%")
                .font(.system(size: 24, weight: .regular))
                .foregroundColor(Color.gray)
            Divider()
            Spacer().frame(height: 10)
            
            if(self.reloadHomeView.dateCircle2 .count == 0){
                Text("아직 입력하신 보상이 없습니다 ~ !!")
                    .padding(20)
                    .frame(maxWidth:.infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 1)
                    ).padding(EdgeInsets(top: 20, leading: 24, bottom: 0, trailing: 24))
                
//                HStack{
//                    ForEach([11,23,24,25,26,22,22], id: \.self){ index in
//                        Button(
//                            action: {
//                            }, label:{
//                                Text("31")
//                                  .padding(10)
//                                  .background(.yellow)
//                                  .clipShape(Circle())
//                                  .foregroundColor(Color.black)
//                            })
//                    }
//                } // : 날짜 Hstack
                
//                ScrollView(.horizontal, showsIndicators: false){
//                    HStack{
//
//                        DefaultRewardCard2(title: "jasdsnj", img: "😍")
//                            .padding(.leading, 12.0)
//                        DefaultRewardCard2(title: "jasdsnj", img: "😍")
//                        DefaultRewardCard2(title: "jasdsnj", img: "😍")
//                        DefaultRewardCard2(title: "jasdsnj", img: "😍")
//                        DefaultRewardCard2(title: "jasdsnj", img: "😍")
//                        DefaultRewardCard2(title: "jasdsnj", img: "😍")
//                            .padding(.trailing, 24.0)
//                    } // :HStack
//                    .padding(.top, 15)
//                    Spacer()
//                }
                
                Spacer()
            }else{
                // dateCircle
                    HStack{
                        ForEach(self.reloadHomeView.dateCircle2.indices, id: \.self){ index in
                            Button(
                                action: {
                                    selectedDate = index
                                    self.reloadHomeView.RewardCardInfo2 = self.reloadHomeView.RewardDateArray2[index]
                                }, label:{
                                    Text("\(self.reloadHomeView.dateCircle2[index])")
                                      .padding(10)
                                      .background(selectedDate == index  ? Color.yellow : Color.white)
                                      .clipShape(Circle())
                                      .foregroundColor(Color.black)
                                })
                        }
                    } // : 날짜 Hstack
                
                //건빵 List
                ScrollView(.horizontal, showsIndicators: false){
                    
                    HStack{
                        ForEach(self.reloadHomeView.RewardCardInfo2.indices, id: \.self) { index in
                            let reward = self.reloadHomeView.RewardCardInfo2[index]
                            let rewardCard = Button(action: {
                                isDetailView.toggle()
                            }){
                                if(index == 0){
                                   RewardCard(reward: reward)
                                        .padding(.leading,10.0)
                                }else if(index == self.reloadHomeView.RewardCardInfo2.count-1){
                                    RewardCard(reward: reward)
                                        .padding(.trailing,20.0)
                                }else{
                                    RewardCard(reward: reward)
                                }
                            }
                            if(reward.isEffective == nil){
                                rewardCard.foregroundColor(Color.green)
                            }else{
                                rewardCard.foregroundColor(Color.black)
                            }
                        }
                    } // :HStack
                    .padding(.top, 10)
                    Spacer()
                }
            }
        }// : Top Vstack
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
