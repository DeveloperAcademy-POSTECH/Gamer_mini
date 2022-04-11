//
//  RewardReportView.swift
//  donggle
//
//  Created by 정재윤 on 2022/04/06.
//
import SwiftUI

struct RewardReportView: View {
    @EnvironmentObject var store: Store
    var arr = ["치킨먹자", "버거먹자", "족발먹자", "피자먹자", "닭발먹자", "밥먹자"]
    var body: some View {
        ScrollView {
            VStack {
                Text("Top 6 스트레스 해소 보상")
                    .font(.system(size: 22, weight: .semibold))
                    .frame(maxWidth: .infinity ,alignment: .leading)
                
                ScrollView(.horizontal) {
                            HStack {
                                ForEach(arr, id: \.self) {name in
                                    RewardCard2()
                                }
                            }
                            .frame(maxHeight: .infinity)
                        }
            }
            .padding(32)
            
            Rectangle()
                .frame(height: 16)
                .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.946))
            
            
            ProgressBar(width: .infinity, height: 22, percent: 69)
                .padding(32)
            
            VStack {
                ForEach(store.stressList) { stress in
                    ListRow(title: stress.title, category: stress.category)
                        .padding(.vertical, 8)
                }
            }
            .padding(.horizontal, 32)
        }
    }
}

struct RewardReportView_Previews: PreviewProvider {
    static var previews: some View {
        RewardReportView()
            .environmentObject(Store())
    }
}
