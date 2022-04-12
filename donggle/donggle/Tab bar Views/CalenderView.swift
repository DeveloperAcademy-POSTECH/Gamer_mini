//
//  CalenderView.swift
//  rewardCalender
//
//  Created by 이가은 on 2022/04/07.
//

import SwiftUI
import UIKit
import FSCalendar


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
                            RecordRewardView()
                        }
                    } // : ToolbarItem
                } // : toolbar
                .padding(10)   
                Divider()
                
                Text("\(selectedDate, formatter: CalendarView.dateFormatText)")
                    .padding(10)
                    .font(.title2)
                Button("보상전체 출력"){

                    print("--- 보상상 ---")
                    print(mainReward)
                    print("-----------------")
                }
                
                ScrollView {
                    let currentInfo = mainReward.filter { (reward : Reward ) -> Bool in
                        
                        let formatter = DateFormatter()
                        formatter.dateFormat = "YYYY년 M월 d일"
                        
                        return formatter.string(from: selectedDate) == formatter.string(from: reward.date) }.sorted(by: {$1.isEffective != nil})
                    
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
                                            //                                                    .font(Font.system(size: 50, design: .default))
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
                                            DetailView(isFullScreen: $isDetailView, reward : reward)
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
        
        // dot 기본 색
        calendar.appearance.eventDefaultColor = .gray
        calendar.appearance.eventSelectionColor = .red
        
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
        calendar.appearance.headerTitleAlignment = .center
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0 // 다음달 이전달 안보이게
        
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 24)
        
        
        //        calendar.locale = Locale(identifier: "ko_KR") // 일 월 화 수 목 금
        calendar.appearance.weekdayTextColor = .gray
        
        return calendar
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource{
        var parent: CalendarRepresentable
        
        init(_ parent: CalendarRepresentable) {
            self.parent = parent
        }
        
        // 날짜 선택 시 콜백 메소드
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            parent.selectedDate = date
        }
        
        // dot size
        func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
            let eventScaleFactor: CGFloat = 1.5
            cell.eventIndicator.transform = CGAffineTransform(scaleX: eventScaleFactor, y: eventScaleFactor)
        }
        
        // 이벤트 표시 개수
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            let rewardEvents : [String] = mainReward.map({(reward) in
                let formatter = DateFormatter()
                formatter.dateFormat = "YYYY년 M월 d일"
                return formatter.string(from: reward.date)
            })
            
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY년 M월 d일"
            
            if(rewardEvents.contains(formatter.string(from: date))){
                return 1
            }else{
                return 0
            }
        }
    }
}


struct CalenderView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
