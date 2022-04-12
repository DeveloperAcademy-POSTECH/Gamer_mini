import SwiftUI
import Foundation


struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    var body: some View {
        Button(action: self.action) {
            VStack{
                Text("☺️")
                Text(self.title).foregroundColor(Color.black)
            }.background(self.isSelected == false ? nil : RoundedRectangle(cornerRadius: 10).fill(Color.init(red: 193/255, green: 233/255, blue: 252/255)))
        }
    }
}

struct RecordView: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var stressIndex: Int
    @Binding var sliderValue : Double
    
    @State var stressSelectionOn: Bool = false
    @State var rewardSelectionOn: Bool = false
    @State var rewardIsOn: Bool = false
    @State var stressDescription: String = "스트레스 내용"
    @State var rewardDescription: String = "보상 내용"
    @State var rewardTitle: String = ""
    @State var selectedStress: [String] = []
    @State var selectedReward: [String] = []
    @State var stressCategory: [String] = ["직장", "날씨", "수면", "가족", "돈", "그냥"]
    @State var rewardCategory: [String] = ["잠자기", "알콜", "쇼핑", "운동", "음식", "놀기"]
    @State private var rewardDate = Date()
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    
    func saveRecord(sliderValue: Double, stressDescription: String, selectedStress : [String], rewardIsOn : Bool, rewardTitle: String, rewardDescription : String, selectedReward : [String], rewardDate : Date){
        if stressDescription.isEmpty || stressDescription == "스트레스 내용" && selectedStress.isEmpty && !rewardIsOn{
    //    스트레스 수치만 조절
            print("---스트레스 수치만 조절---")
        }else if !rewardIsOn{
        //    스트레스 기록만
            var sArray : [Stress] = UserDefaults.stressArray ?? []
            let stressInstance = Stress(id: UUID(), index: stressIndex, content: stressDescription, date: Date(), category: selectedStress, rewardKey: nil)
            sArray.append(stressInstance)
            UserDefaults.stressArray = sArray
            print("---스트레스만 기록---")
            print(sArray)
            print("-----------------")
        }else{
        //    스트레스 + 보상 기록
            let stressUUID = UUID()
            let rewardUUID = UUID()
            var sArray : [Stress] = UserDefaults.stressArray ?? []
            let stressInstance = Stress(id: stressUUID, index: self.stressIndex, content: stressDescription, date: Date(), category: selectedStress, rewardKey: rewardUUID)
            sArray.append(stressInstance)
            UserDefaults.stressArray = sArray
            
            var rArray : [Reward] = UserDefaults.rewardArray ?? []
            let rewardInstance = Reward(id: rewardUUID, title: rewardTitle, content: rewardDescription, date: rewardDate, category: selectedReward, isEffective: nil, stressKey: stressUUID)
            rArray.append(rewardInstance)
            UserDefaults.rewardArray = rArray
            
            print("---스트레스와 보상 함께 기록---")
            print(sArray)
            print(rArray)
            print("-----------------")
        }
        mainReward = UserDefaults.rewardArray ?? []
        RewardDate = initRewardDate()
        RewardDateArray = initRewardDateArray(RewardDate : RewardDate)
        dateCircle = initDateCircle(RewardDateArray: RewardDateArray)
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section{
                    VStack{
                        Circle()
                            .fill(Color.init(red: (sliderValue+1)*2/255, green: (101-sliderValue)*2/255, blue: (101-sliderValue)*2/255))
                            .padding()
                            .frame(width: 130.0, height: 120.0)
                        Text("\(Int(sliderValue))%")
                        HStack{
                            Text("😄")
                            Slider(value: $sliderValue, in: 0...100,step: 1.0)
                            Text("🤯")
                        }
 
                    }
                }
                TextEditor(text: $stressDescription)
                    .foregroundColor(self.stressDescription == "스트레스 내용" ? .gray : .primary)
                    .onTapGesture {
                        if self.stressDescription == "스트레스 내용"{
                            self.stressDescription = ""
                        }
                    }
                    .frame(height: 100.0)
                DisclosureGroup("스트레스 요인", isExpanded: $stressSelectionOn){
                    ScrollView {
                        LazyVGrid(columns: columns,spacing: 20){
                            ForEach(self.stressCategory, id: \.self) { item in
                                MultipleSelectionRow(title: item, isSelected: self.selectedStress.contains(item)) {
                                    if self.selectedStress.contains(item) {
                                        self.selectedStress.removeAll(where: { $0 == item })
                                    }
                                    else {
                                        self.selectedStress.append(item)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                Section{
                    Toggle(isOn: $rewardIsOn) {
                        Text("보상 추가")
                    }
                    if rewardIsOn{
                        TextField("보상 제목", text: $rewardTitle)
                        TextEditor(text: $rewardDescription)
                            .foregroundColor(self.rewardDescription == "보상 내용" ? .gray : .primary)
                            .onTapGesture {
                                if self.rewardDescription == "보상 내용"{
                                    self.rewardDescription = ""
                                }
                            }
                            .frame(height: 100.0)
                        DatePicker(selection: $rewardDate, in: Date()..., displayedComponents: .date , label: { Text("날짜") })
                        DisclosureGroup("활동", isExpanded: $rewardSelectionOn){
                            ScrollView{
                                LazyVGrid(columns: columns,spacing: 20){
                                    ForEach(self.rewardCategory, id: \.self) { item in
                                        MultipleSelectionRow(title: item, isSelected: self.selectedReward.contains(item)) {
                                            if self.selectedReward.contains(item) {
                                                self.selectedReward.removeAll(where: { $0 == item })
                                            }
                                            else {
                                                self.selectedReward.append(item)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(Text("기록하기"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action:{
                        sliderValue = Double(stressIndex)
                        dismiss()
                    }){
                        Text("취소")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("추가"){
                        stressIndex = Int(sliderValue)
                        UserDefaults.standard.set(stressIndex, forKey: "stressIndex")
                        UserDefaults.standard.set(sliderValue, forKey: "sliderValue")
                        saveRecord(sliderValue: sliderValue, stressDescription: stressDescription, selectedStress: selectedStress, rewardIsOn: rewardIsOn, rewardTitle: rewardTitle, rewardDescription: rewardDescription, selectedReward: selectedReward, rewardDate: rewardDate)
                        dismiss()
                    }
                }
            }
        }
    }
}

//struct RecordView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordView()
//    }
//}
