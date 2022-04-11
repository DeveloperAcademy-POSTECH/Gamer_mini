//
//  StressReportView.swift
//  donggle
//
//  Created by 정재윤 on 2022/04/06.
//
import SwiftUI
import SwiftUICharts

struct ListRow: View {
    var title: String
    var category: String
    
    var body: some View {
        HStack {
            HStack {
                ZStack {
                    Text(category)
                        .font(.system(size: 24))
                }
                .frame(width: 50, height: 50, alignment: .center)
                .background(.quaternary)
                .cornerRadius(50)
                .padding(.trailing)
                
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
            }
            
            Spacer()
            
            Text("30%")
                .font(.system(size: 18, weight: .semibold))
        }
        .frame(height: 50)
    }
}


struct StressReportView: View {
    let stressSet: [Stress] = UserDefaults.stressArray ?? []
    
    var body: some View {
        ScrollView {
            LineView(data: [0, 1, 12, 3, 7, 2, 13], style: ChartStyle(backgroundColor: .white, accentColor: .blue, gradientColor: GradientColor(start: .green, end: .teal), textColor: .red, legendTextColor: .green, dropShadowColor: .black))
                .frame(height: 300)
                .padding(32)
                .padding(.bottom, 8)
            
            Rectangle()
                .frame(height: 16)
                .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.946))
            
            
            ProgressBar(width: .infinity, height: 22, percents: [59, 23, 10])
                .padding(32)
            
            VStack {
                ForEach(stressSet, id: \.self.id) { stress in
                    ListRow(title: stress.category[0], category: stress.category[0])
                        .padding(.vertical, 8)
                }
            }
            .padding(.horizontal, 32)
        }
    }
}

struct StressReportView_Previews: PreviewProvider {
    static var previews: some View {
        StressReportView()
    }
}
