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
    case "잠자기":
        return "🛌"
    case "게임":
        return "🕹"
    case "영화":
        return "📽"
    case "데이트":
        return "👩‍❤️‍👨"
    case "운동":
        return "🏋️‍♀️"
    case "음식":
        return "🍱"
    case "쇼핑":
        return "💳"
    case "놀기":
        return "🤹‍♀️"
    case "기록없음":
        return "➿"
    default:
        return "ℹ️"
    }
}



func setSortedStressArray(arr: [Stress], date: String) -> [(key: String, value: String)] {
    var Dictionary: [String : Double] = [:]
    var categories: [String] = []
    //
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY년 MM월"
    
    let filteredStress = arr.filter { stress in
        date == dateFormatter.string(from: stress.date)
    }
    //
    for stress in filteredStress {
        for name in stress.category {
            categories.append(name)
            let count = Dictionary[name]
            Dictionary[name] = Double(count ?? 0)+1
        }
    }
    var tmpArray: Array<(key: String, value: Double)> = []
    tmpArray = Dictionary.sorted { a, b in
        a.value > b.value
    }
    
    var array: [(key: String, value: String)] = []
    var sum: Double = 0
    if categories.isEmpty {
        for _ in 1 ... categories.count {
            sum += 1
        }
    } else {
        sum = 1
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
}

func getMonthOfDate() -> [String] {
    let date = Date(timeIntervalSinceNow: 0)
    var ccalendar = Calendar(identifier: .gregorian)
    ccalendar.locale = Locale(identifier: "ko")
    
    let components = ccalendar.dateComponents([.year, .month, .day], from: date)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy년 MM월 dd일"
    let startOfMonth = dateFormatter.string(from: Date().startOfMonth())
    let endOfMonth = dateFormatter.string(from: Date().endOfMonth())
    
    let startOfIndex1: String.Index = startOfMonth.index(startOfMonth.startIndex, offsetBy: startOfMonth.count - 3)
    let endOfIndex1: String.Index = startOfMonth.index(startOfMonth.startIndex, offsetBy: startOfMonth.count - 2)
    let startDate = String(startOfMonth[startOfIndex1 ... endOfIndex1])
    
    let startOfIndex2: String.Index = endOfMonth.index(endOfMonth.startIndex, offsetBy: endOfMonth.count - 3)
    let endOfIndex2: String.Index = endOfMonth.index(endOfMonth.startIndex, offsetBy: endOfMonth.count - 2)
    let endDate = String(endOfMonth[startOfIndex2 ... endOfIndex2])
    
    let day = String(components.day!)
    let month = String(components.month!)
    
    
    return [month, startDate, endDate, day]
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

// 차트 데이터 가져오기
func getStressPoints(mainStress: [Stress], date: String) -> Array<(key: String, value: Double)> {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY년 MM월"
    
    
    var filteredStress = mainStress.filter { stress in
        date == dateFormatter.string(from: stress.date)
    }
    
    dateFormatter.dateFormat = "YYYY년 MM월 dd일"
    
    filteredStress = filteredStress.sorted { a, b in
        dateFormatter.string(from: a.date) < dateFormatter.string(from: b.date)
    }
    
    var Dictionary: [String:Double] = [:]
    dateFormatter.dateFormat = "M.d"
    var counts: [Double] = []
    for stress in filteredStress {
        let date = dateFormatter.string(from: stress.date)
        let count = Dictionary[date]
        Dictionary[date] = (Double(count ?? 0) + 1)
    }
                            
  
    for stress in filteredStress {
        let date = dateFormatter.string(from: stress.date)
        let count = Dictionary[date]
        counts.append(Double(count ?? 0))
        Dictionary[date] = (Double(count ?? 0) + Double(stress.index))
    }
    
    for idx in filteredStress.indices {
        let stress = filteredStress[idx]
        let date = dateFormatter.string(from: stress.date)
        let count = Dictionary[date]
        Dictionary[date] = (Double(count ?? 0) / counts[idx]) / 100
    }
    
    var tmpArray: Array<(key: String, value: Double)> = []
    tmpArray =  Dictionary.sorted { a, b in
        a.key < b.key
    }
    
    return tmpArray
}

func getDataPoints(arr: Array<(key: String, value: Double)>) -> [CGFloat] {
    let xAxis = getMonthOfDate()
    let currentDay = xAxis[3]
    
    var realData: [CGFloat] = []

    for stress in arr {
        for i in 1 ... Int(currentDay)! {
            if stress.key == "4.\(i)" {
                realData.append(stress.value)
            } else {
                realData.append(0.005)
            }
        }
    }
    
    return realData
}

func selectMonth(date: String) -> String {
    let ampmIndex = date.index(date.endIndex, offsetBy: -3)
    let ampmStr = String(date[ampmIndex])
    
    if ampmStr == "0" {
        let index = date.index(date.endIndex, offsetBy: -3)
        return String(date[index...])
    } else {
        return ampmStr
    }
}

struct StressReportView: View {
    @State var chartXaxis = getMonthOfDate()
    @State var trim: CGFloat = 0
//    @State var stressPercents = getPercent(list: setSortedStressArray(arr: mainStress))
    var date: String
    var body: some View {
        let width: CGFloat = UIScreen.main.bounds.width
        let nowDay = CGFloat((chartXaxis[3] as NSString).floatValue)
        let endDay = CGFloat((chartXaxis[2] as NSString).floatValue)
        let month = CGFloat((selectMonth(date: date) as NSString).floatValue)
        
        let dataPoints = getDataPoints(arr:  getStressPoints(mainStress: mainStress, date: date))
        
        let sortedStressArray = setSortedStressArray(arr: mainStress, date: date)
        
        
        ScrollView {
            ZStack(alignment: .leading) {
                VStack {
                    Chart(data: [0, 0, 0, 0, 0, 0, 0])
                        .chartStyle(
                            AreaChartStyle(.quadCurve, fill:
                                            LinearGradient(gradient: .init(colors: [Color.blue.opacity(0.8), Color.blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                                          )
                        )
                        .padding()
                        .onAppear {
                            trim = 0
                            withAnimation(.easeInOut(duration: 3)) {
                                trim = 1
                            }
                        }
                    
                    AxisLabels(.horizontal, data: ["\(Int(month)).1", "", "", "" ,"" ,"\(Int(month)).\(Int(endDay))"], id: \.self) {
                        Text("\($0)".replacingOccurrences(of: ",", with: ""))
                            .fontWeight(.bold)
                            .font(Font.system(size: 12))
                            .foregroundColor(.secondary)
                    }
                    .frame(width: width , height: 20)
                    .padding(.horizontal, 1)
                }
                
                VStack {
                    Chart(data: dataPoints)
                        .chartStyle(
                            AreaChartStyle(.quadCurve, fill:
                                            LinearGradient(gradient: .init(colors: [Color.blue.opacity(1), Color.blue.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                                          )
                        )
                        .padding()
                        .onAppear {
                            trim = 0
                            withAnimation(.easeInOut(duration: 3)) {
                                trim = 1
                            }
                        }
                    
                    AxisLabels(.horizontal, data: ["", "", "", "" ,"" ,"\(Int(month)).\(Int(nowDay))"], id: \.self) {
                        Text("\($0)".replacingOccurrences(of: ",", with: ""))
                            .fontWeight(.bold)
                            .font(Font.system(size: 12))
                            .foregroundColor(.secondary)
                    }
                    .frame(height: 20)
                    .padding(.horizontal, 1)
                }
                .frame(width: width * nowDay / endDay)
                .padding(.leading, 19)
                
            }
            .padding()
            .frame(width: width, height: 280)
            
            Rectangle()
                .frame(height: 16)
                .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.946))
            
            VStack {
                ProgressBar(width: UIScreen.main.bounds.width - 52, height: 22,  dataList: sortedStressArray, isStress: true)
                
                VStack(spacing: 16) {
                    ForEach(sortedStressArray.indices, id: \.self){ index in let stress = sortedStressArray[index]
                        ListRow(title: stress.key, category: stress.key,
                                percent: stress.value, isStress: true)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct StressReportView_Previews: PreviewProvider {
    static var previews: some View {
        StressReportView(date: "2022년 04월")
    }
}

extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
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
        .frame(height: 50)
    }
}
