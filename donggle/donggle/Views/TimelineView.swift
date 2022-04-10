

import SwiftUI


struct TimelineView: View {
    @State private var date = Date()
    @State private var showModal = false
    @State private var selectedView = 2
    

    //스트레스, 보상 데이터 임시 정의
    
    var date1 = Date()
    
    
    
    let stressSet = UserDefaults.stressArray ?? []
    let rewardSet = UserDefaults.rewardArray ?? []

    
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
                        
                    }
                    .padding([.leading, .trailing])

                    
                    if (selectedView == 1){ //전체
                        ScrollView(showsIndicators: false) {
                            LazyVGrid(columns: [GridItem()], alignment: .center, spacing: 5){
                                ForEach(stressSet, id: \.self.id) { stress in
                                    StressCard(stressIndex:stress.index, stressContent: stress.content, stressCateList: getStressCateList(stressCategory : stress.category))
                                }
                                ForEach(rewardSet, id: \.self.id) { reward in
                                    GiftCard(giftIcon: "🍺", giftName: reward.category[0], giftTitle: reward.title, giftContent: reward.content)
                                }
                            }
                        }
                        .padding(.horizontal, 10.0)
                        
                    }else if (selectedView == 2){ //스트레스
                        ScrollView(showsIndicators: false) {
                            LazyVGrid(columns: [GridItem()], alignment: .center, spacing: 5){
                                ForEach(stressSet, id: \.self.id) { stress in
                                    StressCard(stressIndex:stress.index, stressContent: stress.content, stressCateList: getStressCateList(stressCategory : stress.category))
                                }
                            }
                        }
                        .padding(.horizontal, 10.0)
                        
                    } else if (selectedView == 3){ //보상
                        ScrollView(showsIndicators: false) {
                            LazyVGrid(columns: [GridItem()], alignment: .center, spacing: 5){
                                ForEach(rewardSet, id: \.self.id) { reward in
                                    GiftCard(giftIcon: "🍺", giftName: reward.category[0], giftTitle: reward.title, giftContent: reward.content)
                                }
                            }
                        }
                        .padding(.horizontal, 10.0)
                    } else {
                        Text("no page")
                    }
                    
                }
                .navigationBarTitle("타임라인", displayMode: .inline)
                    
        }
    
}


struct GiftCard : View {
    var giftIcon: String
    var giftName: String
    var giftTitle: String
    var giftContent: String
    var body: some View {
        VStack(spacing: 5.0){
            Text("7 목")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.leading, 5.0)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(alignment: .center){
                VStack(alignment: .center){
                    Text(giftIcon)
                        .font(Font.system(size: 50, design: .default))
                    Text(giftName)
                        .fontWeight(.bold)
                }.padding(10.0)
                    .frame(width: 80)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 1)
                )
                
                Spacer()
                VStack(alignment: .leading){
                    Text(giftTitle)
                        .fontWeight(.bold)
                    Divider()
                    Text(giftContent)
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


struct StressCard : View {
    var stressIndex: Int
    var stressContent: String
    var stressCateList: String
        
    var body: some View {
        VStack(spacing: 5.0){
            Text("7 목")
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
                            
//                        ForEach(stressCategory, id:\.self){ category in
//                            Text(category)
//                            stressCateList.append(category)
                            
//                        }
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


struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
    }
}
