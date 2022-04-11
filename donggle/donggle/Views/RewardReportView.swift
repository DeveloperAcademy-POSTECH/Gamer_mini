//
//  RewardReportView.swift
//  donggle
//
//  Created by 정재윤 on 2022/04/06.
//
import SwiftUI

struct RewardReportView: View {
    let rewardSet = UserDefaults.rewardArray ?? []
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Top 6 스트레스 해소 보상")
                    .font(.system(size: 22, weight: .semibold))
                    .frame(maxWidth: .infinity ,alignment: .leading)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(rewardSet.indices, id: \.self) { index in
                            RewardCard2(title: rewardSet[index].title, category: rewardSet[index].category, index: index)
                                        .padding(.horizontal, 4)
                                        .shadow(color:  Color.black.opacity(0.2), radius: 5, y: 10)
                                }
                            }
                            .frame(maxHeight: .infinity)
                        }
            }
            .frame(height: 240)
            .padding(24)
            
            Rectangle()
                .frame(height: 16)
                .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.946))
            
            
            ProgressBar(width: .infinity, height: 22, percents: [59, 23, 10])
                .padding(24)
            
            VStack {
                ForEach(rewardSet, id: \.self.id) { reward in
                    ListRow(title: reward.title, category: reward.category[0])
                        .padding(.vertical, 8)
                }
            }
            .padding(.horizontal, 24)
        }
    }
}

struct RewardReportView_Previews: PreviewProvider {
    static var previews: some View {
        RewardReportView()
    }
}
