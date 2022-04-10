//
//  DetailView.swift
//  donggle
//
//  Created by 이가은 on 2022/04/07.
//

import SwiftUI


struct DetailView: View {
    @Binding var isFullScreen: Bool
    
    var body: some View {
        NavigationView {
            NavigationLink(destination: CalendarView()) {
            }.navigationBarTitle("상세뷰")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                        Button(action: {
                            isFullScreen.toggle()
                        }) {
                            Image(systemName: "chevron.backward")
                        }
                    }
                }
        }
    }
}
