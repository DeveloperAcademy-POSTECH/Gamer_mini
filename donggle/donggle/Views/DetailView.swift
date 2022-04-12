//
//  DetailView.swift
//  donggle
//
//  Created by 이가은 on 2022/04/07.
//

import SwiftUI


struct DetailView: View {
    @Binding var isFullScreen: Bool
    
    var reward: Reward
    
    var body: some View {
        
        NavigationView {
            NavigationLink(destination: CalendarView()) {
                
                    DetailContextView(reward: reward)
            }.navigationBarTitle("상세뷰")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                        Button(action: {
                            isFullScreen.toggle()
                        }) {
                            Image(systemName: "chevron.backward")
                        }
                    } // : ToolbarItem
                } // : toolbar
            
        }// : NavigationView
        
        //DetailContextView(reward: reward)
        
    }
}



struct DetailContextView: View {
    
    var reward: Reward
    var body: some View {
        VStack{
            Text("\(reward.category[0])")
            Text("\(reward.title)")
            Text("\(reward.content)")
            Text("\(reward.date)")
        }
    }
}
