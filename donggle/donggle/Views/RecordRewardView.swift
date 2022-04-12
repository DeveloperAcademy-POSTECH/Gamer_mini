import SwiftUI
import Foundation


struct RecordRewardView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State var rewardDescription: String = "나에게 어떤 선물을 줄까요?"
    @State var rewardTitle: String = ""
    @State var rewardSelectionOn: Bool = true
    @State var selectedReward: [String] = []
    @State var rewardCategory: [String] = ["잠자기", "알콜", "쇼핑", "운동", "음식", "놀기"]
    @State private var rewardDate = Date()
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    
    func saveRecord(rewardTitle: String, rewardDescription : String, selectedReward : [String], rewardDate : Date){
            if selectedReward.isEmpty{
                self.selectedReward.append("기타")
            }
            let rewardUUID = UUID()
            var rArray : [Reward] = UserDefaults.rewardArray ?? []
            let rewardInstance = Reward(id: rewardUUID, title: rewardTitle, content: rewardDescription, date: rewardDate, category: self.selectedReward, isEffective: nil, stressKey: nil)
            rArray.append(rewardInstance)
            UserDefaults.rewardArray = rArray
            
            print("---보상 기록---")
            print(rArray)
            print("-----------------")
        }
    
    var body: some View {
        NavigationView {
            Form{
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
            .navigationBarTitle("보상기록")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                        Button(action: {
                            dismiss()
                        }) {
                            Text("취소")
                        }
                    }
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                        Button(action: {
                            saveRecord(rewardTitle: rewardTitle, rewardDescription: rewardDescription, selectedReward: selectedReward, rewardDate: rewardDate)
                            dismiss()
                        }) {
                            Text("완료")
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

struct RecordRewardView_Previews: PreviewProvider {
    static var previews: some View {
        RecordRewardView()
    }
}

