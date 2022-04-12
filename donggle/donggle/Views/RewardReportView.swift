//
//  RewardReportView.swift
//  donggle
//
//  Created by 정재윤 on 2022/04/06.
//
import SwiftUI

let rewardSet = UserDefaults.rewardArray ?? []
func setSortedRewardArray(arr: [Reward]) -> [(key: String, value: String)] {
    var tmpArray: Array<(key: String, value: Double)> = []
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
    
    return array.sorted { a, b in
        if a.value > b.value {
            if a.key > b.key {
                return false
            } else {
                return true
            }
        }
        return false
    }

    // 6개 이상부터는 그 외 n개로 묶어서 보여주기
}


func getTop6Reward(filteredRewards: [Reward]) -> [(key: String, value: Double)] {
    var tmpArray: Array<(key: String, value: Double)> = []
    for reward in filteredRewards {
        for name in reward.category {
                    categories.append(name)
                    let count = Dictionary[name]
                    Dictionary[name] = Double(count ?? 0)+1
        }
    }
    tmpArray = Dictionary.sorted { a, b in
        a.value > b.value
    }
    
    if(tmpArray.count > 6){
        tmpArray.removeSubrange(6...tmpArray.count-1)
    }
    
    return tmpArray
}

let filteredRewards = rewardSet.filter { reward in
    reward.isEffective == true
}

struct RewardReportView: View {
    @State var sortedArray = setSortedRewardArray(arr: rewardSet)
    @State var rewardPercents = getPercent(list: setSortedRewardArray(arr: rewardSet))
    @State var effectiveRewards = getTop6Reward(filteredRewards: filteredRewards)
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Top 6 스트레스 해소 보상")
                    .font(.system(size: 22, weight: .semibold))
                    .frame(maxWidth: UIScreen.main.bounds.width - 32 ,alignment: .leading)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(effectiveRewards.indices, id: \.self) { index in
                            let reward = effectiveRewards[index]
                            RewardCard2(title: reward.key, category: reward.key, index: index + 1)
                                        .padding(.horizontal, 4)
                                        .shadow(color:  Color.black.opacity(0.08), radius: 5, y: 6)
                                }
                            }
                            .frame(height: 200)
                        }
            }
            .padding(20)
            
            Rectangle()
                .frame(height: 16)
                .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.946))
            
            
            ProgressBar(width: UIScreen.main.bounds.width - 52, height: 22, dataList: sortedArray, isStress: false)

            
            VStack(spacing: 16) {
                ForEach(sortedArray.indices, id: \.self) { index in
                    let reward = sortedArray[index]
                    ListRow(title: reward.key, category: reward.key,
                            percent: reward.value, isStress: false)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

struct RewardReportView_Previews: PreviewProvider {
    static var previews: some View {
        RewardReportView()
    }
}
