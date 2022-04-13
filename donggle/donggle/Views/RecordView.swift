import SwiftUI
import Foundation


struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    var body: some View {
        Button(action: self.action) {
            VStack{
                Text(stringToImoticon(category:self.title))
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
    @State var rewardSelectionOn: Bool = true
    @State var rewardIsOn: Bool = false
    @State var rewardGroupOn: Bool = true
    @State var stressDescription: String = "어떤 일이 있었나요?"
    @State var rewardDescription: String = "나에게 어떤 선물을 줄까요?"
    @State var rewardTitle: String = ""
    @State var selectedStress: [String] = []
    @State var selectedReward: [String] = []

    @State var stressCategory: [String] = ["직장", "날씨", "수면", "가족", "돈", "그냥"]
    @State var rewardCategory: [String] = ["꿀잠", "알콜", "쇼핑", "운동", "음식", "놀기"]

    @State private var rewardDate = Date()
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    func saveRecord(sliderValue: Double, stressDescription: String, selectedStress : [String], rewardIsOn : Bool, rewardTitle: String, rewardDescription : String, selectedReward : [String], rewardDate : Date){
        if (stressDescription.isEmpty && selectedStress.isEmpty && !rewardIsOn) || rewardIsOn && selectedStress.isEmpty{
            //    스트레스 수치만 조절
            print("---스트레스 수치만 조절---")
        }else if !rewardIsOn{
            //    스트레스 기록만
            if selectedStress.isEmpty{
                self.selectedStress.append("기타")
            }
            var sArray : [Stress] = UserDefaults.stressArray ?? []
            let stressInstance = Stress(id: UUID(), index: stressIndex, content: self.stressDescription, date: Date(), category: self.selectedStress, rewardKey: nil)
            sArray.append(stressInstance)
            UserDefaults.stressArray = sArray
            print("---스트레스만 기록---")
            print(sArray)
            print("-----------------")
        }else{
            //    스트레스 + 보상 기록
            if selectedStress.isEmpty{
                self.selectedStress.append("기타")
            }
            if selectedReward.isEmpty{
                self.selectedReward.append("기타")
            }
            let stressUUID = UUID()
            let rewardUUID = UUID()
            var sArray : [Stress] = UserDefaults.stressArray ?? []
            let stressInstance = Stress(id: stressUUID, index: self.stressIndex, content: self.stressDescription, date: Date(), category: self.selectedStress, rewardKey: rewardUUID)
            sArray.append(stressInstance)
            UserDefaults.stressArray = sArray
            
            var rArray : [Reward] = UserDefaults.rewardArray ?? []
            let rewardInstance = Reward(id: rewardUUID, title: rewardTitle, content: self.rewardDescription, date: rewardDate, category: self.selectedReward, isEffective: nil, stressKey: stressUUID)
            rArray.append(rewardInstance)
            UserDefaults.rewardArray = rArray
            
            print("---스트레스와 보상 함께 기록---")
            print(sArray)
            print(rArray)
            print("-----------------")
        }
        mainStress = UserDefaults.stressArray ?? []
        mainReward = UserDefaults.rewardArray ?? []
        
        //HomeView 데이터 재정리
//        RewardDate = initRewardDate()
//        RewardDateArray = initRewardDateArray(RewardDate : RewardDate)
//        dateCircle = initDateCircle(RewardDateArray: RewardDateArray)
    }

    var body: some View {
        NavigationView{
            Form {
                Section{
                    Text("스트레스 지수")
                        .multilineTextAlignment(.leading)
                    VStack{
                        Text("\(Int(sliderValue))%")
                        Circle()
                            .fill(Color.init(red: 255/255, green: (233-sliderValue*2)/255, blue: 89/255))
                            .padding()
                            .frame(width: 130.0, height: 120.0)
                        HStack{
                            Image(systemName: "circle.fill")
                                .foregroundColor(.yellow)
                            Slider(value: $sliderValue, in: 0...100,step: 1.0)
                                .accentColor(.black)
                            Image(systemName: "circle.fill")
                                .foregroundColor(.red)
                        }
                    }
                }
                VStack(alignment: .leading, spacing: 30){
                    Text("스트레스 요인")
                        .multilineTextAlignment(.leading)
                    TextEditor(text: $stressDescription)
                        .foregroundColor(self.stressDescription == "어떤 일이 있었나요?" ? .gray : .primary)
                        .onTapGesture {
                            if self.stressDescription == "어떤 일이 있었나요?"{
                                self.stressDescription = ""
                            }
                        }.background(RoundedRectangle(cornerRadius: 20).fill(Color(red: 247/255, green: 247/255, blue: 247/255)))
                        .frame(height:100)
   
                }
                Section{
                    DisclosureGroup("스트레스 카테고리", isExpanded: $stressSelectionOn){
                        ScrollView {
                            LazyVGrid(columns: columns,spacing: 20){
                                ForEach(self.stressCategory, id: \.self) { item in
                                    MultipleSelectionRow(title: item,isSelected: self.selectedStress.contains(item)) {
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
                }
                Toggle(isOn: $rewardIsOn) {
                    Text("보상 추가")
                }
                if rewardIsOn{
                    Section{
                    DisclosureGroup("보상", isExpanded: $rewardGroupOn){
                        VStack(alignment: .leading, spacing: 30){
                            DatePicker(selection: $rewardDate, in: Date()..., displayedComponents: .date , label: { Text("날짜") })
                                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                            Text("보상 이름")
                            TextField("", text: $rewardTitle)
                                .background(RoundedRectangle(cornerRadius: 20).fill(Color(red: 247/255, green: 247/255, blue: 247/255)))
                            Text("보상 내용")
                            
                            TextEditor(text: $rewardDescription)
                                .foregroundColor(self.rewardDescription == "나에게 어떤 선물을 줄까요?" ? .gray : .primary)
                                .onTapGesture {
                                    if self.rewardDescription == "나에게 어떤 선물을 줄까요?"{
                                        self.rewardDescription = ""
                                    }
                                }
                                .background(RoundedRectangle(cornerRadius: 20).fill(Color(red: 247/255, green: 247/255, blue: 247/255)))
                                .frame(height:100)

                        }
                            Section{
                            DisclosureGroup("보상 카테고리", isExpanded: $rewardSelectionOn ){
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
                            }.padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                        }
                    }
                }
                }
            }
            .navigationTitle(Text("스트레스 기록"))
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
                        if stressDescription == "어떤 일이 있었나요?"{
                            stressDescription = ""
                        }
                        if rewardDescription == "나에게 어떤 선물을 줄까요?"{
                            rewardDescription = ""
                        }
                        saveRecord(sliderValue: sliderValue, stressDescription: stressDescription, selectedStress: selectedStress, rewardIsOn: rewardIsOn, rewardTitle: rewardTitle, rewardDescription: rewardDescription, selectedReward: selectedReward, rewardDate: rewardDate)
                        dismiss()
                    }
                }
            }
            .background(Color.white)
            .onAppear {
              UITableView.appearance().backgroundColor = .clear
            }
            .onDisappear {
              UITableView.appearance().backgroundColor = .systemGroupedBackground
            }
        }
    }
}

//struct RecordView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordView()
//    }
//}
