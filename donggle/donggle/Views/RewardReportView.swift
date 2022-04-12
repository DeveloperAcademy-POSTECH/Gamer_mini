//
//  RewardReportView.swift
//  donggle
//
//  Created by 정재윤 on 2022/04/06.
//
import SwiftUI

let rewardSet = UserDefaults.rewardArray ?? []
func setSortedRewardArray(arr: [Reward]) -> [(key: String, value: String)] {
    for reward in rewardSet {
        for name in reward.category {
                    categories.append(name)
                    let count = Dictionary[name]
                    Dictionary[name] = Double(count ?? 0)+1
        }
    }
    tmpArray = Dictionary.sorted { a, b in
        a.value > b.value
    }
    
    var array: [(key: String, value: String)] = []
    var sum: Double = 0
    for _ in 1 ... categories.count {
        sum += 1
    }
    for item in tmpArray {
        array.append((key: item.key, value: "\(Int(floor(item.value / sum * 100)))%"))
    }

    return array
}

struct RewardReportView: View {
    @State var sortedArray = setSortedRewardArray(arr: rewardSet)
    @State var rewardPercents = getPercent(list: setSortedRewardArray(arr: rewardSet))
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Top 6 스트레스 해소 보상")
                    .font(.system(size: 22, weight: .semibold))
                    .frame(maxWidth: UIScreen.main.bounds.width - 32 ,alignment: .leading)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(rewardSet.indices, id: \.self) { index in
                            RewardCard2(title: rewardSet[index].title, category: rewardSet[index].category, index: index + 1)
                                        .padding(.horizontal, 4)
                                        .shadow(color:  Color.black.opacity(0.08), radius: 5, y: 6)
                                }
                            }
                    
                        }
            }
            .padding(24)
            .frame(height: 240)
            
            Rectangle()
                .frame(height: 16)
                .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.946))
            
            
            ProgressBar(width: UIScreen.main.bounds.width - 32, height: 22, dataList: sortedArray, isStress: false)

            
            VStack {
                ForEach(sortedArray.indices, id: \.self) { index in
                    let reward = sortedArray[index]
                    ListRow(title: reward.key, category: reward.key,
                            percent: reward.value, isStress: false)
                }
            }
        }
    }
}

struct RewardReportView_Previews: PreviewProvider {
    static var previews: some View {
        RewardReportView()
    }
}
