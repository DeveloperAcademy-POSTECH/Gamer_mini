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
    @State var sliderValue : Double = UserDefaults.standard.double(forKey: "sliderValue")
    @State var stressIndex : Int = UserDefaults.standard.integer(forKey: "stressIndex")
    
    var body: some View{
        TabView(selection:$selection){
            HomeView(sliderValue: $sliderValue, stressIndex: $stressIndex)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }.tag(1)
                .onAppear{
                    RewardDate = initRewardDate()
                    RewardDateArray = initRewardDateArray(RewardDate : RewardDate)
                    dateCircle = initDateCircle(RewardDateArray: RewardDateArray)
                }

            ReportView()
                .tabItem {
                    Image(systemName: "doc.text.magnifyingglass")
                    Text("Report")
                }.tag(2)
            
            CalendarView(sliderValue: $sliderValue, stressIndex: $stressIndex)
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Calendar")
                }.tag(3)
            
            SettingView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Setting")
                }.tag(4)
            
        }.accentColor(.green)
        
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

