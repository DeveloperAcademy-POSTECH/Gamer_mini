import SwiftUI

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
    @State var sliderValue: Double = 50
    @State var sliderRGB: Double = 50
    @State var stressSelectionOn: Bool = false
    @State var rewardSelectionOn: Bool = false
    @State var rewardIsOn: Bool = false
    @State var stressDescription: String = "스트레스 내용"
    @State var rewardDescription: String = "보상 내용"
    @State var selectedStress: [String] = []
    @State var selectedReward: [String] = []
    @State var stressCategory: [String] = ["직장", "날씨", "수면", "가족", "돈", "그냥"]
    @State var rewardCategory: [String] = ["잠자기", "알콜", "쇼핑", "운동", "음식", "놀기"]
    @State private var rewardDate = Date()
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    
    var body: some View {
        NavigationView{
            Form {
                Section{
                    VStack{
                        Circle()
                            .fill(Color.init(red: sliderValue*2/255, green: sliderRGB*2/255, blue: sliderRGB*2/255))
                            .padding()
                            .frame(width: 130.0, height: 120.0)
                        HStack{
                            Text("😄")
                            Slider(value: $sliderValue, in: 0...100)
                                .onChange(of: sliderValue){
                                    (newValue) in
                                    sliderRGB = 100 - newValue
                                }
                            Text("🤯")
                        }
                        Text("\(sliderValue)")
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
                        TextField("보상 제목", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
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
                        dismiss()
                    }){
                        Text("취소")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("추가"){
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
