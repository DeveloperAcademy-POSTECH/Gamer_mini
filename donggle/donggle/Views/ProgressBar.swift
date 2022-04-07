//
//  ProgressBar.swift
//  donggle
//
//  Created by 정재윤 on 2022/04/06.
//

import SwiftUI

struct ProgressBar: View {
    var width: CGFloat = 300
    var height: CGFloat = 20
    var percent: CGFloat = 59
    
    
    var body: some View {
        let multiplier = width / 100
        VStack {
            Text("인간관계가 가장 스트레스에요")
                .font(.system(size: 22, weight: .semibold))
                .frame(maxWidth: width, alignment: .leading)
                
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: height
                                 , style: .continuous)
                    .frame(width: width, height: height)
                    .clipShape(RoundedRectangle(cornerRadius: height
                                                , style: .continuous))
                    .foregroundColor(.black.opacity(0.1))
                
                RoundedRectangle(cornerRadius: height, style: .continuous)
                    .frame(width: percent * multiplier, height: height)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: height, style: .continuous))
                    .foregroundColor(.clear)
            }
        }
        
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar()
    }
}
