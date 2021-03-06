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
                    .font(.system(size: 12))
            }.padding(.top,10)
            .background(self.isSelected == false ? nil : RoundedRectangle(cornerRadius: 10).fill(Color.init(red: 193/255, green: 233/255, blue: 252/255)))
        }
    }
}

struct RecordView: View {
    @ObservedObject private var keyboard = KeyboardResponder()
    @State private var textFieldInput: String = ""
    
    @Environment(\.dismiss) private var dismiss
    @Binding var sliderValue : Double
    @Binding var stressIndex : Int
    @State var stressSelectionOn: Bool = false
    @State var rewardSelectionOn: Bool = true
    @State var rewardIsOn: Bool = false
    @State var rewardGroupOn: Bool = true
    @State var stressDescription: String = "어떤 일이 있었나요?"
    @State var rewardDescription: String = "나에게 어떤 선물을 줄까요?"
    @State var rewardTitle: String = ""
    @State var selectedStress: [String] = []
    @State var selectedReward: [String] = []
    
    @State var stressCategory: [String] = ["직장", "날씨", "수면", "가족", "금전","학업","인간관계","그냥"]
    @State var rewardCategory: [String] = ["꿀잠", "알콜", "쇼핑", "운동", "음식", "놀기"]
    
    @State private var rewardDate = Date()
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    func saveRecord(stressDescription: String, selectedStress : [String], rewardIsOn : Bool, rewardTitle: String, rewardDescription : String, selectedReward : [String], rewardDate : Date){
        if (stressDescription.isEmpty && selectedStress.isEmpty && !rewardIsOn){
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
            
            mainStress = UserDefaults.stressArray ?? []
            
        } else if rewardIsOn && selectedStress.isEmpty {
            if selectedStress.isEmpty{
                self.selectedStress.append("기타")
            }
            if selectedReward.isEmpty{
                self.selectedReward.append("기타")
            }
            var rArray : [Reward] = UserDefaults.rewardArray ?? []
            let rewardInstance = Reward(id: UUID(), title: rewardTitle, content: self.rewardDescription, date: rewardDate, category: self.selectedReward, isEffective: nil, stressKey: nil)
            rArray.append(rewardInstance)
            UserDefaults.rewardArray = rArray
            print("---보상만 기록---")
            print("-----------------")
            mainReward = UserDefaults.rewardArray ?? []
        }
        
        else{
            
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
            let stressInstance = Stress(id: stressUUID, index: stressIndex, content: self.stressDescription, date: Date(), category: self.selectedStress, rewardKey: rewardUUID)
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
            mainStress = UserDefaults.stressArray ?? []
            mainReward = UserDefaults.rewardArray ?? []
        }
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section{
                    Text("스트레스 지수")
                        .multilineTextAlignment(.leading)
                    VStack{
                        Text("\(Int(sliderValue))%")
                            .padding(.top, 20)     
                        Circle()
                            .fill(Color.init(red: 255/255, green: (233-sliderValue*2)/255, blue: 89/255))
                            .padding(2)
                            .frame(width: 120.0, height: 120.0)
                            .overlay {
                                Image(String(Int(sliderValue) == 100 ? 100 :((Int(sliderValue)+10)/10)*10))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 35, height: 35)
                                    .padding(.trailing, 30)
                                    .padding(.bottom, 30)
                            }
                        HStack{
                            Image(systemName: "circle.fill")
                                .foregroundColor(.yellow)
                            Slider(value: $sliderValue, in: 0...100,step: 1.0)
                                .tint(.black)
                            Image(systemName: "circle.fill")
                                .foregroundColor(.red)
                        }
                        .padding(.top, 15)
                    }
                }
                
//                Rectangle()
//                    .frame(height: 16)
//                    .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.946))

                
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
                    }.accentColor(.black)
                }
//                Rectangle()
//                    .frame(height: 16)
//                    .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.946))

                
                Toggle(isOn: $rewardIsOn) {
                    Text("보상 추가")
                }.tint(Color.init(red: 255/255, green: (233-sliderValue*2)/255, blue: 89/255))
                if rewardIsOn{
                    Section{
                            VStack(alignment: .leading, spacing: 30){
                                DatePicker(selection: $rewardDate, in: Date()..., displayedComponents: .date , label: { Text("날짜") })
                                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                                Text("보상 이름")
                                TextField("", text: $rewardTitle)
                                    .frame(height: 50)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(red: 247/255, green: 247/255, blue: 247/255)))
                                Text("보상 내용")
                                
                                TextEditor(text: $rewardDescription)
                                    .foregroundColor(self.rewardDescription == "나에게 어떤 선물을 줄까요?" ? .gray : .primary)
                                    .onTapGesture {
                                        if self.rewardDescription == "나에게 어떤 선물을 줄까요?"{
                                            self.rewardDescription = ""
                                        }
                                    }
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(red: 247/255, green: 247/255, blue: 247/255)))
                                    .frame(height:100)
                                
                            }
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
                            .accentColor(.black)
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
                        Text("취소").foregroundColor(.black)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("추가"){
                        stressIndex = Int(sliderValue)
//                        print(stressIndex)
//                        print(sliderValue)
                        UserDefaults.standard.set(stressIndex, forKey: "stressIndex")
                        UserDefaults.standard.set(sliderValue, forKey: "sliderValue")
                        if stressDescription == "어떤 일이 있었나요?"{
                            stressDescription = ""
                        }
                        if rewardDescription == "나에게 어떤 선물을 줄까요?"{
                            rewardDescription = ""
                        }
                        saveRecord(stressDescription: stressDescription, selectedStress: selectedStress, rewardIsOn: rewardIsOn, rewardTitle: rewardTitle, rewardDescription: rewardDescription, selectedReward: selectedReward, rewardDate: rewardDate)
                        dismiss()
                    }.foregroundColor(.black)
                }
            }
            .background(Color.white)
            .onAppear {
                UITableView.appearance().backgroundColor = .clear
            }
            .onDisappear {
                UITableView.appearance().backgroundColor = .systemGroupedBackground
            }
            .onAppear (perform : UIApplication.shared.hideKeyboard)
        }
    }
}

//struct RecordView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordView()
//    }
//}
