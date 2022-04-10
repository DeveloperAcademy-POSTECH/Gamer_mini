//
//  ProgressBar.swift
//  donggle
//
//  Created by 정재윤 on 2022/04/06.
//

import SwiftUI

struct ProgressBar: View {
    var width: CGFloat
    var height: CGFloat
    var percent: CGFloat
    
    
    var body: some View {
        let multiplier = width / 100
        VStack {
            Text("인간관계가 가장 스트레스에요")
                .font(.system(size: 22, weight: .bold))
                .frame(maxWidth: width, alignment: .leading)
                
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: width, height: height)
                    .foregroundColor(.black.opacity(0.1))
                
                Rectangle()
                    .frame(width: percent * multiplier, height: height)
                    .background(.green)
                    .foregroundColor(.clear)
            }
            .cornerRadius(height)
        }
        
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(width: 300, height: 20, percent: 59)
    }
}
