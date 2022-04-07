//
//  CalenderView.swift
//  rewardCalender
//
//  Created by 이가은 on 2022/04/07.
//

import SwiftUI

struct CalendarView: View {
    
    @State private var selectedDate = Date()
    
    static let dateFormat: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY.MM.dd"
            return formatter
        }()
    
    static let dateFormatText: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY년 M월 d일"
            return formatter
        }()

    struct Reward {
        var id: Int
        var title: String
        var description: String
        var date: String
        var category: String
        var isEffective: Int?
        var stressKey: Int?
    }
    
    @State private var rewardInfo : [Reward] = [
        Reward(id : 0, title : "1 술마시자", description : "역할매에서 술마실테야", date : "2022.04.17", category : "🍺", isEffective : nil, stressKey : nil ),
        Reward(id : 1, title : "2 아이스크림", description : "메로나 먹고싶어", date : "2022.04.07", category : "🍔", isEffective : nil, stressKey : 1 ),
        Reward(id : 2, title : "3 아이스크림", description : "메로나 먹고싶어", date : "2022.04.10", category : "🚚", isEffective : nil, stressKey : 1 ),
        Reward(id : 3, title : "4 아이스크림", description : "메로나 먹고싶어", date : "2022.04.05", category : "⚽️", isEffective : nil, stressKey : 1 ),
        Reward(id : 4, title : "5 아이스크림", description : "메로나 먹고싶어", date : "2022.04.05", category : "❤️", isEffective : nil, stressKey : 1 ),
        Reward(id : 5, title : "6 아이스크림", description : "메로나 먹고싶어", date : "2022.04.11", category : "🐙", isEffective : nil, stressKey : 1 ),
        Reward(id : 6, title : "7 아이스크림", description : "메로나 먹고싶어", date : "2022.04.12", category : "🪱", isEffective : nil, stressKey : 1 )]
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        
                NavigationView {
            VStack {
                        DatePicker("Selected Date",
                                   selection: $selectedDate,
                                   in : Date()...,
                                displayedComponents: [.date]
                            )
                            .datePickerStyle(.graphical)
                            .navigationBarTitle(Text("보상캘린더"))
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                                    Button(action: {
                                                    
                                    }) {
                                            Image(systemName: "plus")
                                    }
                                }
                        }

                    Divider()
                
                    Text("\(selectedDate, formatter: CalendarView.dateFormatText)")
                    .padding(10)
                    .font(.title)
                
                ScrollView {
                    LazyVGrid(
                        columns: columns,
                        alignment: .center,
                        spacing: 6,
                        pinnedViews: [],
                        content: {
//                            private var currentInfo: [Info]  { info.filter { // 날짜가 일치하는 것만 필터링하도록 코드 추가 } }
                            
//                                let cast = ["Vivien", "Marlon", "Kim", "Karl"]
//                                let shortNames = cast.filter { $0.count < 5 }
                            
//                            var currentInfo = rewardInfo.filter { (reward : Reward ) -> Bool in
//                                dateFormatter.string(from: date)
//                                return String(format: selectedDate, CalendarView.dateFormat) == String(reward.date) }
                            
//                            ForEach(rewardInfo, id: \.self.id) { reward in
//
//                                if(String(selectedDate, formatter: CalendarView.dateFormat) == reward.date){
//
//                                    VStack{
//                                        Text("\(selectedDate, formatter: CalendarView.dateFormat)")
//
//                                        Text("\(reward.date)")
//
//                                        Text(reward.category)
//                                            .font(Font.system(size: 50, design: .default))
//                                        Text(reward.title)
//                                        }.padding(20)
//                                        .frame(height: 160)
//                                        .overlay(
//                                                    RoundedRectangle(cornerRadius: 15)
//                                                    .stroke(lineWidth: 1)
//                                        )
//                                }
//
//                            }.padding(10)
                        })
                }
            }
        }
    }
}

struct CalenderView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
