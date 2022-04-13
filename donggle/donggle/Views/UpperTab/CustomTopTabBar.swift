//
//  CustomTopTabBar.swift
//  donggle
//
//  Created by 정재윤 on 2022/04/06.
//

import SwiftUI

struct CustomTopTabBar: View {
    @Binding var tabIndex: Int
    var body: some View {
        HStack(spacing: 20) {
            TabBarButton(text: " 스트레스 ", isSelected: .constant(tabIndex == 0))
                .onTapGesture {
                    onButtonTapped(index: 0)
                }
                .foregroundColor(tabIndex == 0 ? .black : .gray)
                
                
            
            Spacer()
            
            TabBarButton(text: "   보상   ", isSelected: .constant(tabIndex == 1))
                .onTapGesture {
                    onButtonTapped(index: 1)
                }
                .foregroundColor(tabIndex == 1 ? .black : .gray)
                
                
        }
        .border(width: 1, edges: [.bottom], color: .black)
        
    }
    
    private func onButtonTapped(index: Int) {
        withAnimation { tabIndex = index }
    }
}
