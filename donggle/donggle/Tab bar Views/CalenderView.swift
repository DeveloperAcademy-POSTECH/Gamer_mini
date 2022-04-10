//
//  CalenderView.swift
//  rewardCalender
//
//  Created by 이가은 on 2022/04/07.
//

import SwiftUI
import UIKit
import FSCalendar

//struct Reward1 {
//    var id: Int
//    var title: String
//    var description: String
//    var date: String
//    var category: String
//    var isEffective: Bool?
//    var stressKey: Int?
//}

//var rewardInfo : [Reward1] = [
//    Reward1(id : 0, title : "맥마시기", description : "역할매에서 술마실테야", date : "2022.04.09", category : "🍺", isEffective : true, stressKey : nil ),
//    Reward1(id : 1, title : "맛난 식사", description : "메로나 먹고싶어", date : "2022.04.09", category : "🍔", isEffective : nil, stressKey : 1 ),
//    Reward1(id : 2, title : "여행가기", description : "메로나 먹고싶어", date : "2022.04.10", category : "🚚", isEffective : nil, stressKey : 1 ),
//    Reward1(id : 3, title : "운동하기", description : "메로나 먹고싶어", date : "2022.04.11", category : "⚽️", isEffective : false, stressKey : 1 ),
//    Reward1(id : 4, title : "잠자기", description : "메로나 먹고싶어", date : "2022.04.11", category : "💤", isEffective : nil, stressKey : 1 ),
//    Reward1(id : 5, title : "흐느적거리기", description : "메로나 먹고싶어", date : "2022.04.11", category : "🐙", isEffective : false, stressKey : 1 ),
//    Reward1(id : 6, title : "꿈틀거리기", description : "메로나 먹고싶어", date : "2022.04.12", category : "🪱", isEffective : nil, stressKey : 1 )
//]


var Mainreward : [Reward] = UserDefaults.rewardArray ?? []

struct CalendarView: View {
    
    
    
    static let dateFormatText: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월 d일"
        return formatter
    }()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State var selectedDate: Date = Date()
    @State private var isRecordView = false
    @State private var isDetailView = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                VStack{
                    CalendarRepresentable(selectedDate: $selectedDate)
                }
                    .datePickerStyle(.graphical)
                    .navigationBarTitle(Text("보상캘린더"))
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                            Button(action: {
                                isRecordView.toggle()
                            }) {
                                Image(systemName: "plus")
                            }
                            .fullScreenCover(isPresented: $isRecordView) {
                                RecordRewardView(isFullScreen: $isRecordView)
                            }
                        } // : ToolbarItem
                    } // : toolbar
                    .padding(10)
                
                Divider()
                
                Text("\(selectedDate, formatter: CalendarView.dateFormatText)")
                    .padding(10)
                    .font(.title2)
                Button("추가"){
                        print("--- 보상상 ---")
                        print(Mainreward)
                        print("-----------------")
                }

                
                ScrollView {
                    let currentInfo = Mainreward.filter { (reward : Reward ) -> Bool in
//                        let dataFormatter = DateFormatter()
//                        dataFormatter.dateFormat = "YYYY.MM.dd"
//                        let dateString = dataFormatter.string(from: selectedDate)
                        return selectedDate == reward.date }.sorted(by: {$1.isEffective != nil})
                    if(currentInfo.count == 0){
                        Text("입력하신 보상이 없습니다 :)")
                            .padding(20)
                            .frame(maxWidth:.infinity)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(lineWidth: 1)
                            ).padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    }else{
                        LazyVGrid(
                            columns: columns,
                            alignment: .center,
                            spacing: 6,
                            pinnedViews: [],
                            content: {
                                ForEach(currentInfo, id: \.self.id) { reward in
                                    let rewardCard = Button(action: {
                                        isDetailView.toggle()
                                    }){
                                        //gridView // lazyHgrid 찾아보기 !
                                        VStack{
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
                                        .fullScreenCover(isPresented: $isDetailView) {
                                            DetailView(isFullScreen: $isDetailView)
                                        }
                                    if(reward.isEffective == nil){
                                        rewardCard.foregroundColor(Color.blue)
                                    }else{
                                        rewardCard.foregroundColor(Color.black)
                                    }
                                } // : ForEach
                            }) // : LazyVGrid
                    }
                } // :ScrollView
            }
        } //: Vstack
    } // : NavigationView
}

struct CalendarRepresentable: UIViewRepresentable{
    
    typealias UIViewType = FSCalendar
    
    @Binding var selectedDate: Date
    
    var calendar = FSCalendar()
    
    func updateUIView(_ uiView: FSCalendar, context: Context) { }
    
    func makeUIView(context: Context) -> FSCalendar {
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        
        // CUSTMIZE
        calendar.scope = .month // 달로 보기
        
        // 색 시정
        // 캘린더 배경 색
//        calendar.backgroundColor = UIColor(red: 241/255, green: 249/255, blue: 255/255, alpha: 1)
        // 선택한 날짜 색
        calendar.appearance.selectionColor = UIColor(red: 38/255, green: 153/255, blue: 251/255, alpha: 1)
        calendar.appearance.borderSelectionColor = UIColor(red: 38/255, green: 153/255, blue: 251/255, alpha: 1)
        // 오늘 날짜
        calendar.appearance.todayColor = UIColor(red: 188/255, green: 224/255, blue: 253/255, alpha: 1)
        
        // 평일 & 주말 색상 설정
        calendar.appearance.titleDefaultColor = .black  // 평일
        calendar.appearance.titleWeekendColor = .red    // 주말
        
        //        calendar.rowHeight = 100
        
        //폰트
        // Weekday
        calendar.appearance.weekdayFont = UIFont(name: "NotoSansKR-Regular", size: 10)
        // 각각의 일(날짜)
        calendar.appearance.titleFont = UIFont(name: "NotoSansKR-Regular", size: 14)
        
        // 달력 스크롤
        calendar.scrollEnabled = true  // 스크롤 가능
        calendar.scrollDirection = .vertical // 세로 스크롤
        
        // header 커스텀
        calendar.headerHeight = 45
        calendar.appearance.headerTitleAlignment = .left
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0 // 다음달 이전달 안보이게
        
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 24)
        
        // 일 월 화 수 목 금
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.appearance.weekdayTextColor = .black
        
        return calendar
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource{
        var parent: CalendarRepresentable
        
        var events: [Date] = []
        
        init(_ parent: CalendarRepresentable) {
            self.parent = parent
        }
        
        // 날짜 선택 시 콜백 메소드
                func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
                    parent.selectedDate = date
        
//                    let dfMatter = DateFormatter()
//                    dfMatter.locale = Locale(identifier: "ko_KR")
//                    dfMatter.dateFormat = "yyyy.MM.dd"
//
//                    print(dfMatter.string(from: date) + " 날짜가 선택되었습니다.")
                }
        
        
        // 하단에 글자 남기기
        //        func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        //
        //                let dateFormatter = DateFormatter()
        //                dateFormatter.dateFormat = "yyyy-MM-dd"
        //
        //                switch dateFormatter.string(from: date) {
        //                case dateFormatter.string(from: Date()):
        //                    return "오늘"
        //                case "2022-04-22":
        //                    return "출근"
        //                case "2022-04-23":
        //                    return "지각"
        //                case "2022-04-24":
        //                    return "결근"
        //                default:
        //                    return nil
        //                }
        //            }
        
        // dot size
        func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
            let eventScaleFactor: CGFloat = 1.5
            cell.eventIndicator.transform = CGAffineTransform(scaleX: eventScaleFactor, y: eventScaleFactor)
        }
        
        let eventdate : [Date] = Mainreward.map({(reward) in
            return reward.date
        })
        
        // 이벤트 표시 개수
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            
//            let formatter = DateFormatter()
//            formatter.dateStyle = .long
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy년 MM월 dd일 a hh시 mm분"

            let eventdate : [Date] = Mainreward.map({(reward) in
//                print(reward.date)
//                print(dfMatter.string(from: reward.date))
                return reward.date
            })
            

            let result = eventdate.map( {(eventdate: Date) -> Bool in
                
                print("======")
                print(eventdate)
                print(formatter.string(from: eventdate))
                print(date)
                print(formatter.string(from: date))

                print(formatter.string(from: eventdate) == formatter.string(from: date))
                print("======")
                
                return formatter.string(from: eventdate) == formatter.string(from: date)
            })
            
            
            if(result.contains(true)){
                return 1
            }else{
                return 0
            }
            
        }
    }
}




//struct RewardCard_river: View {
//    @Binding var isDetailView: Bool
//    @Binding var reward : Reward
//
//
//    struct Reward {
//        var id: Int
//        var title: String
//        var description: String
//        var date: String
//        var category: String
//        var isEffective: Bool?
//        var stressKey: Int?
//    }
//
//    var body: some View {
//        Button(action: {
//            isDetailView.toggle()
//        }) {
//            VStack{
//                Text(reward.category)
//                    .font(Font.system(size: 50, design: .default))
//                Text(reward.title)
//            }.padding(20)
//                .frame(height: 160)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 15)
//                        .stroke(lineWidth: 1)
//                )
//        }.padding(10)
//            .fullScreenCover(isPresented: $isDetailView) {
//                DetailView(isFullScreen: $isDetailView)
//            }.foregroundColor(Color.black)
//    }
//}


struct CalenderView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
