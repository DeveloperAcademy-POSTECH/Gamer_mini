

import SwiftUI

struct Total {
    let id : UUID
    let type : Int
    let index : Int
    let date : Date
}

//struct

//@State private var prevDate : String




class Datas {
    var stressSet : [Stress]
    var rewardSet : [Reward]
    var totalSet : [Total]
    var groupedStress : [String : [Stress]]
    var groupedReward : [String : [Reward]]
    var groupedTotal : [String : [Total]]
//    let sortedKeysAndValues = sorted(dictionary) { $0.0 < $1.0 }
    //date 기준 내림차순 정렬
    init(){
        self.stressSet = mainStress.sorted(by: { $0.date > $1.date})
        self.rewardSet = mainReward.sorted(by: { $0.date > $1.date})
        self.totalSet = createTotalData(stressSet: self.stressSet, rewardSet: self.rewardSet).sorted(by: {$0.date > $1.date})
        self.groupedStress = Dictionary(grouping: self.stressSet) { (stress) -> String in
            let dateString = dateToString(dateInfo: stress.date)
            return dateString
        }
        
//        self.groupedStress = groupedStress.sorted(by: {$0.key > $1.key})
//
        self.groupedReward = Dictionary(grouping: self.rewardSet) { (reward) -> String in
            let dateString = dateToString(dateInfo: reward.date)
            return dateString
        }
        self.groupedTotal = Dictionary(grouping: self.totalSet) { (total) -> String in
            let dateString = dateToString(dateInfo: total.date)
            return dateString
        }
    }
    
    //데이터 리로드
    func refreshDatas(){
        stressSet = mainStress.sorted(by: { $0.date > $1.date})
        rewardSet = mainReward.sorted(by: { $0.date > $1.date})
        totalSet = createTotalData(stressSet: self.stressSet, rewardSet: self.rewardSet).sorted(by: { $0.date > $1.date})
        groupedStress = Dictionary(grouping: stressSet) { (stress) -> String in
            let dateString = dateToString(dateInfo: stress.date)
            return dateString
        }
        groupedReward = Dictionary(grouping: rewardSet) { (reward) -> String in
            let dateString = dateToString(dateInfo: reward.date)
            return dateString
        }
        groupedTotal = Dictionary(grouping: totalSet) { (total) -> String in
            let dateString = dateToString(dateInfo: total.date)
            return dateString
        }
    }
}




//@State private var sortedData : Datas


struct TimelineView: View {
    @State private var date = getMonth()
    @State private var showModal = false
    @State private var selectedView = 1
//    @State private var month = "4월"
    @State private var prevDate = ""
    @Environment(\.presentationMode) var presentation
    
    //스트레스, 보상 데이터 임시 정의
    
    var date1 = Date()
    var sortedData = Datas()
    
    
    let groupData = Dictionary(grouping: mainStress) { (stress) -> String in

        let dateString = dateToString(dateInfo: stress.date)

        return dateString
    }
    

    
    
    var body: some View {
        let idx: String.Index = date.index(date.startIndex, offsetBy: date.count - 4)
        let month = String(date[idx...])
        
        Color(red: 249/255, green: 249/255, blue: 249/255).ignoresSafeArea()
            .overlay(
                VStack{
                    
                    HStack{
                        
                        Button(action: {
                            self.showModal = true
                        }) {
                            HStack {
                                Text(month)
                                    .foregroundColor(.black)
                                    .font(.system(size: 24, weight: .semibold))
                                
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.black)
                            }
                        }
                        .sheet(isPresented: self.$showModal) {
                            ModalView(date: $date)
                        }
                        
                        
                        Spacer()
                        
                        Picker(selection: $selectedView, label: Text("Picker")
                            .font(.system(size: 24, weight: .regular))) {
                            Text("전체보기").tag(1)
                            Text("스트레스").tag(2)
                            Text("보상").tag(3)
                            
                        }
                        
                    }
                    .padding(.horizontal, 24.0)
                    
                    
                    if (selectedView == 1){ //전체
                        
                        
                        ScrollView(showsIndicators: false) {
                            LazyVGrid(columns: [GridItem()], alignment: .center, spacing: 12){
                                
                                ForEach(Array(sortedData.groupedTotal.keys.enumerated()).sorted(by: {$0.element>$1.element}), id: \.element) { _, key in
                                    
                                    Text(key)
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .padding(.top, 12)
                                    
                                    ForEach(sortedData.groupedTotal[key]!, id: \.self.id) { data in
                                        if data.type == 2 {
                                            stressTimeCard(stressIndex: sortedData.stressSet[data.index].index, stressContent: sortedData.stressSet[data.index].content, stressCategory: sortedData.stressSet[data.index].category, stressDate: dateToString(dateInfo: sortedData.stressSet[data.index].date))
                                            
                                            //type 3 : 보상 데이터
                                        } else if data.type == 3 {
                                            RewardTimeCard(rewardName: sortedData.rewardSet[data.index].category[0], rewardTitle: sortedData.rewardSet[data.index].title, rewardContent: sortedData.rewardSet[data.index].content, rewardDate: dateToString(dateInfo: sortedData.rewardSet[data.index].date), rewardDone: sortedData.rewardSet[data.index].isEffective)
                                        } else {
                                            Text("no data")
                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                        }
                        .padding(.horizontal, 24.0)
                        
                    }else if (selectedView == 2){ //스트레스
                        ScrollView(showsIndicators: false) {
                            LazyVGrid(columns: [GridItem()], alignment: .center, spacing: 12){
                                
                                ForEach(Array(sortedData.groupedStress.keys.enumerated()).sorted(by: {$0.element>$1.element}), id: \.element) { _, key in
                                    Text(key)
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .padding(.top, 12)

                                    ForEach(sortedData.groupedStress[key]!, id: \.self.id) { stress in
                                        stressTimeCard( stressIndex:stress.index, stressContent: stress.content, stressCategory: stress.category, stressDate: dateToString(dateInfo: stress.date))
                                    }
                                }

                            }
                        }
                        .padding(.horizontal, 24.0)
                        
                    } else if (selectedView == 3){ //보상
//                        Array(dictionary.keys).sorted(<)
//                        sortedData.groupedReward.keys.enumerated()
//                        Text("보상")
//                            .onAppear{
//                                print(Array(sortedData.groupedReward.keys.enumerated()).sorted(by: {$0.element>$1.element}))
//                            }
                        ScrollView(showsIndicators: false) {
                            LazyVGrid(columns: [GridItem()], alignment: .center, spacing: 12){
                                ForEach(Array(sortedData.groupedReward.keys.enumerated()).sorted(by: {$0.element>$1.element}), id: \.element) { _, key in
                                    Text(key)
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .padding(.top, 12)

                                    ForEach(sortedData.groupedReward[key]!, id: \.self.id) { reward in
                                        RewardTimeCard(rewardName: reward.category[0], rewardTitle: reward.title, rewardContent: reward.content, rewardDate: dateToString(dateInfo: reward.date), rewardDone: reward.isEffective)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 24.0)
//                        .onAppear{Array(sortedData.groupedReward.keys.enumerated()).sorted(by: >)}
                    } else {
                        Text("no page")
                    }
                    
                }
                    .navigationBarTitle("타임라인", displayMode: .inline)
                    .onAppear {
                        sortedData.refreshDatas()
                       
                    }
                    .onDisappear {
                        presentation.wrappedValue.dismiss()
                    }
            )
    }
    
}



struct RewardTimeCard : View {
    var rewardName: String
    var rewardTitle: String
    var rewardContent: String
    var rewardDate: String
    var rewardDone: Bool?
    
    var body: some View {
        
        
        HStack(alignment: .top, spacing: 0){
            VStack{
//                Text(rewardDate)
                Text(stringToImoticon(category : rewardName))
                    .font(.system(size: 44))
                    .opacity((rewardDone == nil) ? (0.5) : (1))
                .onTapGesture {
                    print("tap")
                }
            }
            .padding(.trailing, 20.0)
            VStack(alignment: .leading, spacing: 0){
                Text(rewardTitle)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.bottom, 12.0)
                Text(rewardContent)
                    .font(.body)
                    .fontWeight(.regular)
                Spacer()
            }
            
            Spacer()
        }
        .padding(.vertical, 20.0)
        .padding(.horizontal, 24.0)
        .background(RoundedRectangle(cornerRadius: 15)
            .foregroundColor(.white)
        )
    }
    
}


struct stressTimeCard : View {
    var stressIndex: Int
    var stressContent: String
    var stressCategory: [String]
    var stressDate: String
    
    var body: some View {
        
        HStack(alignment: .top, spacing: 0){
            
            VStack(spacing:3){
//                Text(stressDate)
                Circle()
                    .fill(Color.init(red: 255/255, green: (233-Double(stressIndex)*2)/255, blue: 89/255))
                    .frame(width:50, height:50)
                Text(String(stressIndex))
                    .font(.system(size: 12))
            }.padding(.trailing, 20)
            
            VStack(alignment: .leading, spacing: 0){
                
                Text(stressContent)
                    .font(.body)
                    .fontWeight(.regular)
                    .padding(.bottom, 12)
                    .fixedSize(horizontal: false, vertical: true)
                
                //let stressColor : [String : Double] = stressCatagoryToColor(category: categ)
                
                VStack(alignment: .leading, spacing: 5){
                    ForEach(groupCate(stressCategory: stressCategory, parentWidth: UIScreen.main.bounds.size.width - 170), id: \.self){ group in
                        
                        HStack (spacing : 6){
                            ForEach(group, id: \.self){ cate in
                                let stressColor : [String : Double] = stressCatagoryToColor(category: cate)
                                
                                Text(cate)
                                    .font(.system(size : 12))
                                    .padding(.horizontal, 10.0)
                                    .padding(.vertical, 2)
                                    .foregroundColor(.white)
                                    .background(RoundedRectangle(cornerRadius: 15)
                                        .foregroundColor(Color(red: stressColor["red"]!/255, green: stressColor["green"]!/255, blue: stressColor["blue"]!/255))
    
                                    )
                            }
                        }
                        
                    }
                    
                }
                
                
                Spacer()
            }
            Spacer()
        }
        .padding(.top, 20.0)
        .padding(.bottom, 15.0)
        .padding(.horizontal, 24.0)
        .background(RoundedRectangle(cornerRadius: 15)
            .foregroundColor(.white)
        )
        
    }
    
}


func groupCate(stressCategory : [String], parentWidth : CGFloat) -> [[String]]{
    var tmpGroupedCate : [String] = []
    var groupedCate : [[String]] = [[String]]()
    var width: CGFloat = 0
    
    for cate in stressCategory {
        let label = UILabel()
        label.text = cate
        label.sizeToFit()
        
        let labelWidth = label.frame.size.width + 10 + 6
        
        if (width + labelWidth) < (parentWidth - 7) {
            tmpGroupedCate.append(cate)
            width += (labelWidth)
        } else {
            groupedCate.append(tmpGroupedCate)
            tmpGroupedCate.removeAll()
            tmpGroupedCate.append(cate)
            width = (labelWidth)
            
        }
    }
    
    groupedCate.append(tmpGroupedCate)
    
    return groupedCate
    
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
