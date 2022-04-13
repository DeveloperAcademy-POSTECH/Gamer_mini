//
//  ContentView.swift
//  donggle
//
//  Created by 정재윤 on 2022/04/12.
//

import Charts
import SwiftUI

struct ContentView: View {
    var body: some View {
        Chart(data: [0.1, 0.3, 0.2, 0.5, 0.4, 0.9, 0.1])
            .chartStyle(
                LineChartStyle(.quadCurve, lineColor: .blue, lineWidth: 5)
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
