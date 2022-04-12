import SwiftUI

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
        //        print(date)
        //        print("--")
        //        print(String(date.split(separator: " ")[2].split(separator: "일")[0]))
        //        print("--")
        return String(date.split(separator: " ")[2].split(separator: "일")[0])
    }

    dateCircle = array

    return dateCircle
}

////Date String 추출 -> 중복값 삭제 후 정렬
var RewardDate : [String] = initRewardDate()

// Date에 해당하는 보상 넣기
var RewardDateArray : [[Reward]] = initRewardDateArray(RewardDate : RewardDate)
var dateCircle : [String] = initDateCircle(RewardDateArray: RewardDateArray)
var RewardCardInfo : [Reward] = RewardDateArray.count==0 ? [] : RewardDateArray[0]

class ReloadView: ObservableObject {
    @Published var RewardDate2 : [String] = []
    @Published var RewardDateArray2 : [[Reward]] = []
    @Published var dateCircle2 : [String] = []
    @Published var RewardCardInfo2 : [Reward] = []
    
    func shuffle() {
        print("shuffleDance")
        RewardDate2 = initRewardDate()
        RewardDateArray2 = initRewardDateArray(RewardDate: RewardDate2)
        dateCircle2 = initDateCircle(RewardDateArray: RewardDateArray2)
        RewardCardInfo2 = RewardDateArray2.count==0 ? [] : RewardDateArray2[0]
    }
    
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
            //        print(date)
            //        print("--")
            //        print(String(date.split(separator: " ")[2].split(separator: "일")[0]))
            //        print("--")
            return String(date.split(separator: " ")[2].split(separator: "일")[0])
        }
        
        dateCircle = array
        
        return dateCircle
    }
}





struct HomeView: View {
    
    @ObservedObject var reloadView = ReloadView()
    
    func shuffle() {
        self.reloadView.shuffle()
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
        
        let dragGesture = DragGesture()
            .onChanged{ value in
                //let point = value.location
                self.offset = value.translation
            }
        
        VStack{
            HStack{
//                Text(self.reloadView.RewardDate2[self.reloadView.RewardDate2.count-1])
                
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
            //.position(x:195, y:0)
            Text("\(stressIndex)%")
                .font(.system(size: 24, weight: .regular))
                .foregroundColor(Color.gray)
            Divider()
            Spacer().frame(height: 10)
            
            if(self.reloadView.dateCircle2 .count == 0){
                Text("아직 입력하신 보상이 없습니다 ~ !!")
                    .padding(20)
                    .frame(maxWidth:.infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 1)
                    ).padding(EdgeInsets(top: 20, leading: 24, bottom: 0, trailing: 24))
                
//                ScrollView(.horizontal, showsIndicators: false){
//                    Spacer()
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
//                    Spacer()
//                }
                
                Spacer()
            }else{
                // dateCircle
                    HStack{
                        ForEach(self.reloadView.dateCircle2.indices, id: \.self){ index in
                            Button(
                                action: {
                                    selectedDate = index
                                    self.reloadView.RewardCardInfo2 = self.reloadView.RewardDateArray2[index]
                                }, label:{
                                    Text("\(self.reloadView.dateCircle2[index])")
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 14, design:.default))
                                })
                            .frame(width: 18, height: 18)
                            .padding(12)
                            .background(selectedDate == index  ? Color.yellow : Color.white)
                            .cornerRadius(30)
                        }
                    } // : 날짜 Hstack
                
                //건빵 List
                ScrollView(.horizontal, showsIndicators: false){
                    Spacer()
                    HStack{
                        ForEach(self.reloadView.RewardCardInfo2.indices, id: \.self) { index in
                            let reward = self.reloadView.RewardCardInfo2[index]
                            let rewardCard = Button(action: {
                                isDetailView.toggle()
                            }){
                                if(index == 0){
                                    DefaultRewardCard(reward: reward)
                                        .padding(.leading,12.0)
                                        .fullScreenCover(isPresented: $isDetailView) {
                                            DetailView(isFullScreen: $isDetailView, reward : self.reloadView.RewardCardInfo2[index])
                                        }
                                }else if(index == self.reloadView.RewardCardInfo2.count-1){
                                    DefaultRewardCard(reward: reward)
                                        .padding(.trailing,24.0)
                                        .fullScreenCover(isPresented: $isDetailView) {
                                            DetailView(isFullScreen: $isDetailView, reward : self.reloadView.RewardCardInfo2[index])
                                        }
                                }else{
                                    DefaultRewardCard(reward: reward)
                                        .fullScreenCover(isPresented: $isDetailView) {
                                            DetailView(isFullScreen: $isDetailView, reward : self.reloadView.RewardCardInfo2[index])
                                        }
                                }
                            }
                                
                            
                            if(reward.isEffective == nil){
                                rewardCard.foregroundColor(Color.green)
                            }else{
                                rewardCard.foregroundColor(Color.black)
                            }
                        }
                    } // :HStack
                    Spacer()
                }
            }
        }// : Top Vstack
    }
}


struct DefaultRewardCard2: View {
    
    var title : String
    
    var img : String
    
    var body: some View {
        
        VStack{
            Text(img)
                .font(.system(size: 44, design: .default))
                .padding(.top, 32)
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
        }
        .frame(width: 106, height: 140)
        .background(.white)
        .cornerRadius(20)
        .padding(.horizontal, 6)
        .shadow(color:  Color.black.opacity(0.14), radius: 8, y: 6)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
