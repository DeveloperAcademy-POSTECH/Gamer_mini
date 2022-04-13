//
//  ProgressBar.swift
//  donggle
//
//  Created by 정재윤 on 2022/04/06.
//

import SwiftUI

func setStressPostfix (str: String) -> String {
    switch (str) {
    case "직장":
        return "이"
    case "인간관계":
        return "가"
    case "돈":
        return "이"
    case "금전":
        return "이"
    case "날씨":
        return "가"
    case "가족":
        return "이"
    case "사랑":
        return "이"
    case "수면":
        return "이"
    default:
        return "가"
    }
}

func setStressColor (str: String) -> [Double] {
    switch (str) {
    case "직장":
        return [128/255, 128/255, 128/255]
    case "인간관계":
        return [153/255, 51/255, 1]
    case "돈":
        return [204/255, 204/255, 0]
    case "날씨":
        return [250/255, 244/255, 58/255]
    case "가족":
        return [255/255, 153/255, 51/255]
    case "사랑":
        return [255/255, 51/255, 51/255]
    case "수면":
        return [51/255, 153/255, 1]
    default:
        return [224/255, 224/255, 224/255]
    }
}

func setRewardColor (str: String) -> [Double] {
    switch (str) {
    case "알콜":
        return [255/255, 153/255, 51/255]
    case "꿀잠":
        return [51/255, 153/255, 1]
    case "게임":
        return [255/255, 51/255, 51/255]
    case "영화":
        return [0, 204/255, 102/255]
    case "쇼핑":
        return [200/255, 153/255, 51/255]
    case "운동":
        return [153/255, 51/255, 1]
    case "음식":
        return [100/255, 153/255, 204/255]
    default:
        return [224/255, 224/255, 224/255]
    }
}




struct ProgressBar: View {
    var width: CGFloat
    var height: CGFloat
    var dataList: [(key: String, value: String)]
    var isStress: Bool
    
    var body: some View {
        let multiplier = width / 100
        VStack {
            if isStress {
                if dataList.isEmpty {
                    Text("스트레스가 없어요!")
                        .font(.system(size: 22, weight: .bold))
                        .frame(maxWidth: width, alignment: .leading)
                } else {
                    Text("\(dataList[0].key)\(setStressPostfix(str: dataList[0].key)) 가장 스트레스에요")
                        .font(.system(size: 22, weight: .bold))
                        .frame(maxWidth: width, alignment: .leading)
                }
            } else {
                if dataList.isEmpty {
                    Text("보상이 없어요!")
                        .font(.system(size: 22, weight: .bold))
                        .frame(maxWidth: width, alignment: .leading)
                } else {
                    Text("\(dataList[0].key) 보상을 가장 많이 받아요")
                        .font(.system(size: 22, weight: .bold))
                        .frame(maxWidth: width, alignment: .leading)
                }
                
            }
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: width, height: height)
                    .foregroundColor(.black.opacity(0.1))
                
                HStack {
                    if isStress {
                        ForEach(dataList.indices, id: \.self) { index in
                            let reward = dataList[index]
                            let percent = getPercent(list: dataList)[index]
                            let rgb = setStressColor(str: reward.key)
                            Rectangle()
                                .frame(width: percent * multiplier, height: height)
                                .background(Color(red: rgb[0], green: rgb[1], blue: rgb[2], opacity: 1))
                            .foregroundColor(.clear)
                        }
                    } else {
                        ForEach(dataList.indices, id: \.self) { index in
                            let reward = dataList[index]
                            let percent = getPercent(list: dataList)[index]
                            let rgb = setRewardColor(str: reward.key)
                            Rectangle()
                                .frame(width: percent * multiplier, height: height)
                                .background(Color(red: rgb[0], green: rgb[1], blue: rgb[2], opacity: 1))
                            .foregroundColor(.clear)
                        }
                    }
                }
            }
            .cornerRadius(height)
        }
        .padding(.vertical, 32)
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(width: UIScreen.main.bounds.width, height: 20, dataList: [(key: "직장", value: "30%")], isStress: true)
    }
}
