//
//  StyleData.swift
//  donggle
//
//  Created by Lee Myeonghwan on 2022/04/12.
//

import Foundation
import SwiftUI

struct confirmTextYellowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 17, weight: .regular))
            .foregroundColor(Color.black)
            .multilineTextAlignment(.center)
            .frame(width: 160.0, height: 50)
            .background(Color.yellow)
            .cornerRadius(14)
    }
}

struct confirmTextGrayModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 17, weight: .regular))
            .foregroundColor(Color.black)
            .multilineTextAlignment(.center)
            .frame(width: 160.0, height: 50)
            .background(Color(UIColor.lightGray))
            .cornerRadius(14)
    }
}

//사용법: Text("someText").modifier(confirmTextYellowModifier())
