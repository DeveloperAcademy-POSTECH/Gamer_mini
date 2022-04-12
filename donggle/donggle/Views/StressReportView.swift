//
//  StressReportView.swift
//  donggle
//
//  Created by 정재윤 on 2022/04/06.
//
import SwiftUI
import Charts


func setEmoji(str: String) -> String {
    switch (str) {
    case "직장":
        return "🖥"
    case "인간관계":
        return "👫"
    case "돈":
        return "💵"
    case "날씨":
        return "🌦"
    case "가족":
        return "👨‍👩‍👧‍👦"
    case "사랑":
        return "❤️"
    case "수면":
        return "💤"
        
    case "알콜":
        return "🍺"
    case "꿀잠":
        return "🛌"
    case "게임":
        return "🕹"
    case "영화":
        return "📽"
    case "데이트":
        return "👩‍❤️‍👨"
    case "운동":
        return "🏋️‍♀️"
    default:
        return "ℹ️"
    }
}


struct ListRow: View {
    var title: String
    var category: String
    var percent: String
    var isStress: Bool
    
    var body: some View {
        HStack {
            if isStress {
                let rgb = setStressColor(str: category)
                HStack {
                    ZStack {
                        Text(setEmoji(str: category))
                            .font(.system(size: 24))
                    }
                    .frame(width: 50, height: 50, alignment: .center)
                    .background(Color(red: rgb[0], green: rgb[1], blue: rgb[2], opacity: 1))
                    .cornerRadius(50)
                    .padding(.trailing)
                    
                    Text(title)
                        .font(.system(size: 18, weight: .semibold))
                }
            } else {
                let rgb = setRewardColor(str: category)
                HStack {
                    ZStack {
                        Text(setEmoji(str: category))
                            .font(.system(size: 24))
                    }
                    .frame(width: 50, height: 50, alignment: .center)
                    .background(Color(red: rgb[0], green: rgb[1], blue: rgb[2], opacity: 1))
                    .cornerRadius(50)
                    .padding(.trailing)
                    
                    Text(title)
                        .font(.system(size: 18, weight: .semibold))
                }
            }
            
            
            Spacer()
            
            Text(percent)
                .font(.system(size: 18, weight: .semibold))
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .frame(height: 50)
    }
}




let stressSet: [Stress] = UserDefaults.stressArray ?? []
var Dictionary: [String : Double] = [:]
var categories: [String] = []
var tmpArray: Array<(key: String, value: Double)> = []

func setSortedArray(arr: [Stress]) -> [(key: String, value: String)] {
    for stress in stressSet {
        for name in stress.category {
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

func getMonthOfDate() -> [String] {
    let date = Date(timeIntervalSinceNow: 0)
    var ccalendar = Calendar(identifier: .gregorian)
    ccalendar.locale = Locale(identifier: "ko")

    let components = ccalendar.dateComponents([.year, .month], from: date)
    let startOfMonth = ccalendar.date(from: components)!
    let comp1 = ccalendar.dateComponents([.day,.weekday,.weekOfMonth], from: startOfMonth)
    let nextMonth = ccalendar.date(byAdding: .month, value: +1, to: startOfMonth)
    let endOfMonth = ccalendar.date(byAdding: .day, value: -1, to:nextMonth!)
    let comp2 = ccalendar.dateComponents([.day,.weekday,.weekOfMonth], from: endOfMonth!)
    
    let month = String(components.month!)
    let startDate = String(comp1.day!)
    let endDate = String(comp2.day!)
    return [month, startDate, endDate]
}

func getPercent(list: [(key: String, value: String)]) -> [CGFloat] {
    var arr: [CGFloat] = []
    for item in list {
        let endIdx: String.Index = item.value.index(item.value.startIndex, offsetBy: item.value.count - 2)
        let percent = String(item.value[...endIdx])
        let floatValue = CGFloat((percent as NSString).floatValue)
        arr.append(floatValue)
    }
    return arr
}


struct StressReportView: View {
    @State var sortedArray = setSortedArray(arr: stressSet)
    @State var chartXaxis = getMonthOfDate()
    @State var stressPercents = getPercent(list: setSortedArray(arr: stressSet))
    
    var body: some View {
        ScrollView {
            Chart(data: [0.1, 0.3, 0.2, 0.5, 0.4, 0.9, 0.1])
                .chartStyle(
                    AreaChartStyle(.quadCurve, fill:
                                    LinearGradient(gradient: .init(colors: [Color.blue.opacity(0.8), Color.blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                    )
                )
                .frame(width: UIScreen.main.bounds.width - 32, height: 300)
                .padding(.vertical, 32)
            
            Rectangle()
                .frame(height: 16)
                .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.946))
            
            VStack {
                ProgressBar(width: UIScreen.main.bounds.width - 32, height: 22,  dataList: sortedArray, isStress: true)
                
                VStack {
                    ForEach(sortedArray.indices, id: \.self){ index in let stress = sortedArray[index]
                        ListRow(title: stress.key, category: stress.key,
                                percent: stress.value, isStress: true)
                    }
                }
            }
        }
    }
}

struct StressReportView_Previews: PreviewProvider {
    static var previews: some View {
        StressReportView()
    }
}
