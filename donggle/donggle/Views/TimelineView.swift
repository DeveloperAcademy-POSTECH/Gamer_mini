

import SwiftUI


struct TimelineView: View {
    @State private var date = Date()
    @State private var showModal = false
    @State private var selectedView = 2
    

    //스트레스, 보상 데이터 임시 정의
    
    var date1 = Date()
    
    
    struct Reward2 {
        var id: Int
        var title: String
        var content: String
        var date: Date
        var category: String
        var isEffective: Bool?
        var stressKey: Int?
        var type: Int //스트레스(0) or 보상(1) 데이터 체크
        var icon: String //보상 카테고리 아이콘
    }
    
    struct Stress2 {
        var id : Int
        var index : Int
        var content : String
        var date : Date
        var category : String
        var rewardKey : UUID?
    }
    
    @State private var stressInfo : [Stress2] = [
        Stress2(id: 0, index: 13, content: "사과 스트레스", date: Date(), category: "🍎", rewardKey: nil),
        Stress2(id: 1, index: 23, content: "불꽃 스트레스", date: Date(), category: "🔥", rewardKey: nil),
        Stress2(id: 2, index: 37, content: "일이 너무 많고 어렵다. 맨날 야근을 해야하는데 잠이 너무 부족하고 짜증난다. 직장 사람들과는 친하지도 않아서 자리가 불편하다.", date: Date(), category: "직장", rewardKey: nil),
        Stress2(id: 3, index: 47, content: "이사를 가기 너무 귀찮다", date: Date(), category: "일상", rewardKey: nil),
        Stress2(id: 4, index: 17, content: "잠이 너무 부족하다.. 잠이 필요하다. 내일도 아침에 일찍 일어나야하는데, 벌써 새벽 두 시가 넘었다. 주말에 잠을 몰아서 자야할 것 같다. 요즘 잠을 자지 못해서 머리가 잘 안 돌아가는 것 같고, 건강도 안 좋아지는 것 같다.", date: Date(), category: "수면", rewardKey: nil)
    
    ]
    
    @State private var rewardInfo : [Reward2] = [
        Reward2(id : 0, title : "맥주 한 잔!", content : "오늘 요정들과 함께 뿌링클 치킨 사서 치맥하기!", date : Date(), category : "음주", isEffective : nil, stressKey : nil, type: 1, icon : "🍺" ),
        Reward2(id : 1, title : "맛난 식사", content : "메로나 먹고싶어", date : Date(), category : "음식", isEffective : nil, stressKey : 1, type: 1, icon : "🍔" ),
        Reward2(id : 2, title : "여행가기", content : "메로나 먹고싶어", date : Date(), category : "외출", isEffective : nil, stressKey : 1, type: 1, icon : "🚚" ),
        Reward2(id : 3, title : "운동하기", content : "메로나 먹고싶어", date : Date(), category : "운동", isEffective : nil, stressKey : 1, type: 1, icon : "⚽️" ),
        Reward2(id : 4, title : "잠자기", content : "메로나 먹고싶어", date : Date(), category : "수면", isEffective : nil, stressKey : 1, type: 1, icon : "💤" ),
        Reward2(id : 5, title : "흐느적거리기", content : "메로나 먹고싶어", date : Date(), category : "휴식", isEffective : nil, stressKey : 1, type: 1, icon : "🐙" ),
        Reward2(id : 6, title : "꿈틀거리기", content : "메로나 먹고싶어", date : Date(), category : "휴식", isEffective : nil, stressKey : 1, type: 1, icon : "🪱" )]


    
    
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
                                ForEach(stressInfo, id: \.self.id) { stress in
                                    StressCard(stressIndex:stress.index, stressName: stress.category, stressContent: stress.content)
                                }
                                ForEach(rewardInfo, id: \.self.id) { reward in
                                    GiftCard(giftIcon: reward.icon, giftName: reward.category, giftTitle: reward.title, giftContent: reward.content)
                                }
                            }
                        }
                        .padding(.horizontal, 10.0)
                        
                    }else if (selectedView == 2){ //스트레스
                        ScrollView(showsIndicators: false) {
                            LazyVGrid(columns: [GridItem()], alignment: .center, spacing: 5){
                                ForEach(stressInfo, id: \.self.id) { stress in
                                    StressCard(stressIndex:stress.index, stressName: stress.category, stressContent: stress.content)
                                }
                            }
                        }
                        .padding(.horizontal, 10.0)
                        
                    } else if (selectedView == 3){ //보상
                        ScrollView(showsIndicators: false) {
                            LazyVGrid(columns: [GridItem()], alignment: .center, spacing: 5){
                                ForEach(rewardInfo, id: \.self.id) { reward in
                                    GiftCard(giftIcon: reward.icon, giftName: reward.category, giftTitle: reward.title, giftContent: reward.content)
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
    var stressName: String
    var stressContent: String
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
                
//                Spacer()
                VStack(alignment: .leading, spacing: 3.0){
                    HStack{
                        Text("스트레스")
                            .padding(.horizontal, 5.0)
                            .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.gray)
                        )
                        Text(stressName)
                        Spacer()
                    }
//                                Divider()
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



struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
    }
}
