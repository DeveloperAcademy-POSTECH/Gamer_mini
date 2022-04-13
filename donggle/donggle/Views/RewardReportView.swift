//
//  RewardReportView.swift
//  donggle
//
//  Created by 정재윤 on 2022/04/06.
//
import SwiftUI

let rewardSet = UserDefaults.rewardArray ?? []
func setSortedRewardArray(arr: [Reward], date: String) -> [(key: String, value: String)] {
    var Dictionary: [String : Double] = [:]
    var categories: [String] = []
    var tmpArray: Array<(key: String, value: Double)> = []
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY년 MM월"
    
    let filteredRewards = arr.filter { reward in
        date == dateFormatter.string(from: reward.date)
    }
    
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
    
    var array: [(key: String, value: String)] = []
    var sum: Double = 0
    for _ in 0 ... categories.count {
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


// top6는 매달 최고 보상으로 해야하는지 전체 중에서
func getTop6Reward(mainReward: [Reward], date: String) -> [(key: String, value: Double)] {
    var Dictionary: [String : Double] = [:]
    var categories: [String] = []
    var tmpArray: Array<(key: String, value: Double)> = []
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY년 MM월"
    
    let rewards = mainReward.filter { stress in
        date == dateFormatter.string(from: stress.date)
    }
    
    let filteredRewards = rewards.filter { reward in
        reward.isEffective == true
    }
    
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




struct RewardReportView: View {
    //    @State var rewardPercents = getPercent(list: setSortedRewardArray(arr: mainReward))
    
    var date: String
    var body: some View {
        let sortedRewardArray = setSortedRewardArray(arr: mainReward, date: date)
        let effectiveRewards = getTop6Reward(mainReward: mainReward, date: date)
        
        ScrollView(showsIndicators: false) {
            if !effectiveRewards.isEmpty {
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
                .frame(height: 280)
                
                Rectangle()
                    .frame(height: 16)
                    .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.946))
            }
            
            ProgressBar(width: UIScreen.main.bounds.width - 52, height: 22, dataList: sortedRewardArray, isStress: false)
            
            
            VStack(spacing: 16) {
                ForEach(sortedRewardArray.indices, id: \.self) { index in let reward = sortedRewardArray[index]
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
        RewardReportView(date: "2022년 04월")
    }
}
