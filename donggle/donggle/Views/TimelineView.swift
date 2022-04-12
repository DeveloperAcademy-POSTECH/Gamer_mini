

import SwiftUI

struct Total {
    let id : UUID
    let type : Int
    let index : Int
    let date : Date
}



class Datas {
    var stressSet : [Stress]
    var rewardSet : [Reward]
    var totalSet : [Total]
    
    //date 기준 내림차순 정렬
    init(){
        self.stressSet = mainStress.sorted(by: { $0.date > $1.date})
        self.rewardSet = mainReward.sorted(by: { $0.date > $1.date})
        self.totalSet = createTotalData(stressSet: self.stressSet, rewardSet: self.rewardSet).sorted(by: { $0.date > $1.date})
    }
    
    //데이터 리로드
    func refreshDatas(){
        stressSet = mainStress.sorted(by: { $0.date > $1.date})
        rewardSet = mainReward.sorted(by: { $0.date > $1.date})
        totalSet = createTotalData(stressSet: self.stressSet, rewardSet: self.rewardSet).sorted(by: { $0.date > $1.date})
    }
}



//@State private var sortedData : Datas


struct TimelineView: View {
    @State private var date = Date()
    @State private var showModal = false
    @State private var selectedView = 1
    
    
    //스트레스, 보상 데이터 임시 정의
    
    var date1 = Date()
    var sortedData = Datas()
    
    
//    UserDefaults.rewardArray
//    UserDefaults.stressArray
    
    
    
    var body: some View {
        
        VStack{
            
            HStack{
                
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
                
                
                Spacer()
                
                Picker(selection: $selectedView, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                    Text("전체").tag(1)
                    Text("스트레스").tag(2)
                    Text("보상").tag(3)
                    
                }
//                .onChange(of: selectedView, perform: { (value) in
//                    sortedData.refreshDatas()
//                })
                
            }
            .padding([.leading, .trailing])
            
            
            if (selectedView == 1){ //전체
                
                
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: [GridItem()], alignment: .center, spacing: 5){
                        
                        
                        ForEach(sortedData.totalSet, id: \.self.id){ data in
                            //type 2 : 스트레스 데이터
                            if data.type == 2 {
                                
                                stressTimeCard(stressIndex: sortedData.stressSet[data.index].index, stressContent: sortedData.stressSet[data.index].content, stressCateList: getStressCateList(stressCategory : sortedData.stressSet[data.index].category), stressDate: dateToString(dateInfo: sortedData.stressSet[data.index].date))
                                //type 3 : 보상 데이터
                            } else if data.type == 3 {
                                //                                        rewardData = sortedData.rewardSet[data.index]
                                RewardTimeCard(rewardIcon: "🍺", rewardName: sortedData.rewardSet[data.index].category[0], rewardTitle: sortedData.rewardSet[data.index].title, rewardContent: sortedData.rewardSet[data.index].content, rewardDate: dateToString(dateInfo: sortedData.rewardSet[data.index].date))
                            } else {
                                Text("no data")
                            }
                        }
                        
                    }
                }
                .padding(.horizontal, 10.0)
                
            }else if (selectedView == 2){ //스트레스
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: [GridItem()], alignment: .center, spacing: 5){
                        ForEach(sortedData.stressSet, id: \.self.id) { stress in
                            stressTimeCard(stressIndex:stress.index, stressContent: stress.content, stressCateList: getStressCateList(stressCategory : stress.category), stressDate: dateToString(dateInfo: stress.date))
                        }
                    }
                }
                .padding(.horizontal, 10.0)
                
            } else if (selectedView == 3){ //보상
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: [GridItem()], alignment: .center, spacing: 5){
                        ForEach(sortedData.rewardSet, id: \.self.id) { reward in
                            RewardTimeCard(rewardIcon: "🍺", rewardName: reward.category[0], rewardTitle: reward.title, rewardContent: reward.content, rewardDate: dateToString(dateInfo: reward.date))
                        }
                    }
                }
                .padding(.horizontal, 10.0)
            } else {
                Text("no page")
            }
            
        }
        .navigationBarTitle("타임라인", displayMode: .inline)
        .onAppear {
            sortedData.refreshDatas()
        }
    }
    
}


struct RewardTimeCard : View {
    var rewardIcon: String
    var rewardName: String
    var rewardTitle: String
    var rewardContent: String
    var rewardDate: String
    var body: some View {
        VStack(spacing: 5.0){
            Text(rewardDate)
                .font(.title3)
                .fontWeight(.bold)
                .padding(.leading, 5.0)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(alignment: .center){
                VStack(alignment: .center){
                    Text(rewardIcon)
                        .font(Font.system(size: 50, design: .default))
                    Text(rewardName)
                        .fontWeight(.bold)
                }.padding(10.0)
                    .frame(width: 80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 1)
                    )
                
                Spacer()
                VStack(alignment: .leading){
                    Text(rewardTitle)
                        .fontWeight(.bold)
                    Divider()
                    Text(rewardContent)
                    Spacer()
                }
            }
        }
        .padding(.all, 5.0)
        .background(RoundedRectangle(cornerRadius: 15)
            .foregroundColor(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 0.0, brightness: 0.926)/*@END_MENU_TOKEN@*/)
        )
    }
    
}


struct stressTimeCard : View {
    var stressIndex: Int
    var stressContent: String
    var stressCateList: String
    var stressDate: String
    
    var body: some View {
        VStack(spacing: 5.0){
            Text(stressDate)
                .font(.title3)
                .fontWeight(.bold)
                .padding(.leading, 5.0)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(alignment: .center){
                VStack(alignment: .center){
                    Circle()
                        .fill(Color.gray)
                    Text(String(stressIndex))
                    Spacer()
                }.padding(10.0)
                    .frame(width: 80, height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 0)
                    )
                
                VStack(alignment: .leading, spacing: 3.0){
                    HStack(alignment: .top){ //카테고리 두 줄 이상일 때 위쪽으로 정렬되도록
                        
                        Text("스트레스")
                            .padding(.horizontal, 5.0)
                            .foregroundColor(.white)
                            .background(RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.gray)
                            )
                        
                        Text(stressCateList)
                        Spacer()
                    }
                    
                    Text(stressContent)
                        .font(.body)
                    Spacer()
                }
            }
        }
        .padding(.all, 5.0)
        .background(RoundedRectangle(cornerRadius: 15)
            .foregroundColor(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 0.0, brightness: 0.926)/*@END_MENU_TOKEN@*/)
        )
        
        
    }
    
}




//전체 타임라인 구성 위해 stressSet와 rewardSet 데이터 일부(인덱스, date) 합치기
//type 2 : 스트레스 데이터, type 3 : 보상 데이터
func createTotalData(stressSet : [Stress], rewardSet : [Reward]) -> [Total]{
    
    var totalSet : [Total] = []
    
    for (index, stress) in stressSet.enumerated(){
        totalSet.append(Total(id: UUID(), type: 2, index: index, date: stress.date))
    }
    
    for (index, reward) in rewardSet.enumerated(){
        totalSet.append(Total(id: UUID(), type: 3, index: index, date: reward.date))
    }
    
    return totalSet
}


//데이터 로드 function
//func refreshData() -> Datas{
//    var sortedData : Datas
//
//    sortedData = Datas(stressSet: mainStress ?? [], rewardSet: mainReward ?? [])
//
//    return sortedData
//}


//여러개의 카테고리가 ","로 구분되어 나열된 string 만들기
func getStressCateList(stressCategory : [String]) -> String {
    
    var stressCateArr : [String] = []
    var stressCateList : String
    
    for category in stressCategory{
        stressCateArr.append(category)
    }
    
    stressCateList = stressCateArr.joined(separator: ", ")
    
    return stressCateList
}

func dateToString(dateInfo : Date) -> String {
    
    var dateString : String
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy.MM.dd"
    dateString = dateFormatter.string(from: dateInfo)
    
    return dateString
}


struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
    }
}
