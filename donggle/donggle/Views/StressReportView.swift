//
//  StressReportView.swift
//  donggle
//
//  Created by 정재윤 on 2022/04/06.
//

import SwiftUI
import SwiftUICharts

struct ListRow: View {
    var name: String
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "star")
                Text(name)
            }
            
            Spacer()
            
            Text("30%")
        }
    }
}

struct StressReportView: View {
    var body: some View {
        List {
            LineView(data: [0, 1, 12, 3, 7, 2, 12], style: ChartStyle(backgroundColor: .white, accentColor: .blue, gradientColor: GradientColor(start: .blue, end: .purple), textColor: .red, legendTextColor: .green, dropShadowColor: .black))
                .padding(.bottom)
                .frame(height: 300)
            
            ProgressBar(width: 300, height: 20, percent: 69)
                .padding(.vertical, 20)
            
            ListRow(name: "인간관계")
            ListRow(name: "직장")
            ListRow(name: "수면")
            ListRow(name: "다이어트")
            ListRow(name: "그외 3개")
        }
    }
}

struct StressReportView_Previews: PreviewProvider {
    static var previews: some View {
        StressReportView()
    }
}
