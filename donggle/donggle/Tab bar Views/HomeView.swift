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
        RewardCardInfo2 = (RewardDateArray2.count==0 ? [] : RewardDateArray2[0]).sorted(by: {$1.isEffective != nil})
    }
}

struct HomeView: View {
    
    @Binding var sliderValue : Double
    @Binding var stressIndex : Int
    @ObservedObject var reloadHomeView = ReloadHomeView()
    
    
    func shuffle() {
        self.reloadHomeView.shuffle()
    }
    
    @State private var showModal = false
    
    
    @State private var selectedDate : Int = 0
    
    @GestureState var isLongPressed = false
    
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
                    RecordView(sliderValue: $sliderValue, stressIndex: $stressIndex)
                        .onDisappear{
                            self.shuffle()
                        }
                }
            }
            .padding(.horizontal, 24.0)
            
            VStack{
                Circle()
                    .fill(Color.init(red: 255/255, green: (233-sliderValue*2)/255, blue: 89/255))
                    .padding(50)
                    .overlay {
    
                        Image(String(stressIndex == 100 ? 100 :((stressIndex+10)/10)*10))

                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                            .padding(.trailing, 30)
                            .padding(.bottom, 30)
                    }
            }
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
                HStack{
                    Text("최근 보상")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color.black)
                    Spacer()
                }.padding(.leading, 24)
                    .padding(.top,20)
                Text("아직 입력하신 보상이 없습니다 ~ !!")
                    .padding(20)
                    .frame(maxWidth:.infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 1)
                    ).padding(EdgeInsets(top: 15, leading: 24, bottom: 0, trailing: 24))

                
                Spacer()
            }else{
                // dateCircle
                HStack{
                    Text("최근 보상")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color.black)
                    Spacer()
                }.padding(.leading, 24)
                    .padding(.top,20)
                HStack{
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
                    Spacer()
                }.padding(.leading,24.0)
                
                //건빵 List
                ScrollView(.horizontal, showsIndicators: false){
                    
                    HStack{
                        ForEach(self.reloadHomeView.RewardCardInfo2.indices, id: \.self) { index in
                            let reward = self.reloadHomeView.RewardCardInfo2[index]
                            if(index == 0){

                                RewardCard(reward: reward, sliderValue: $sliderValue, stressIndex: $stressIndex)
                                    .padding(.leading,10.0)
                            }else if(index == self.reloadHomeView.RewardCardInfo2.count-1){
                                RewardCard(reward: reward, sliderValue: $sliderValue, stressIndex: $stressIndex)
                                    .padding(.trailing,20.0)
                            }else{
                                RewardCard(reward: reward, sliderValue: $sliderValue, stressIndex: $stressIndex)
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


//
//struct DefaultRewardCard2: View {
//
//    var title : String
//
//    var img : String
//
//    var body: some View {
//
//        VStack{
//            Text(img)
//                .font(.system(size: 44, design: .default))
//                .padding(.top, 32)
//            Text(title)
//                .font(.system(size: 14, weight: .semibold))
//                .foregroundColor(Color.black)
//                .multilineTextAlignment(.center)
//                .padding(.bottom, 16)
//        }
//        .frame(width: 106, height: 140)
//        .background(.white)
//        .cornerRadius(20)
//        .padding(.horizontal, 6)
//        .shadow(color:  Color.black.opacity(0.14), radius: 8, y: 6)
//    }
//}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(sliderValue: $sliderValue, stressIndex: $stressIndex)
//    }
//}


