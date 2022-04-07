//
//  TabBarButton.swift
//  donggle
//
//  Created by 정재윤 on 2022/04/06.
//

import SwiftUI

struct TabBarButton: View {
    let text: String
    @Binding var isSelected: Bool
    
    var body: some View {
        Text(text)
            .fontWeight(isSelected ? .heavy : .regular)
            .font(.custom("Avenir", size: 24))
            .padding(.horizontal, 26)
            .padding(.bottom, 10)
            .border(width: isSelected ? 2 : 1, edges: [.bottom], color: .black)
    }
}

