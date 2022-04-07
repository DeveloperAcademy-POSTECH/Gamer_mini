//
//  ContentView.swift
//  rewardCalender
//
//  Created by 이가은 on 2022/04/06.
//

import SwiftUI


struct ContentView: View{
    @State private var selection = 3
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    var body: some View{
        
        TabView(selection:$selection){
            
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }.tag(1)

            ReportView()
                .tabItem {
                    Image(systemName: "doc.text.magnifyingglass")
                    Text("Report")
                }.tag(2)
            
            CalendarView()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
