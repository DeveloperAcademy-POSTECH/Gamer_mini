//
//  ContentView.swift
//  rewardCalender
//
//  Created by 이가은 on 2022/04/06.
//

import SwiftUI


import Foundation

var mainReward : [Reward] = UserDefaults.rewardArray ?? []
var mainStress : [Stress] = UserDefaults.stressArray ?? []


struct TabBarView: View{
    @State private var selection = 1
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    var body: some View{
        
        let calendarView = CalendarView()
        let homeView = HomeView()
        
        TabView(selection:$selection){
            homeView
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }.tag(1)
                .onAppear{
                    homeView.reloadHomeView.shuffle()
                }
            
            ReportView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Report")
                }.tag(2)
            
            calendarView
                .tabItem {
                    Image(systemName: "giftcard")
                    Text("Calendar")
                }.tag(3)
                .onAppear{
                    calendarView.reloadCalendarView.shuffle()
                }
            
            SettingView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Setting")
                }.tag(4)
        }.accentColor(.black)
        
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

