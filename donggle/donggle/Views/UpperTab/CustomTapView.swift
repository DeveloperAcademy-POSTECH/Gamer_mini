//
//  CustomTapView.swift
//  donggle
//
//  Created by 정재윤 on 2022/04/06.
//

import SwiftUI

struct CustomTapView: View {
    
    @State var tabIndex = 0
    
    var body: some View {
        VStack{
            CustomTopTabBar(tabIndex: $tabIndex)
            if tabIndex == 0 {
                StressReportView()
            }
            else {
                RewardReportView()
            }
            Spacer()
        }
    }
}


extension View {
    func border(width: CGFloat, edges: [Edge], color: SwiftUI.Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

struct CustomTapView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTapView()
    }
}
