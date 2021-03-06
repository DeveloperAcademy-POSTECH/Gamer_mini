//
//  UpdateRewardView.swift
//  donggle
//
//  Created by Lee Myeonghwan on 2022/04/12.
//

import SwiftUI
import Foundation


struct UpdateRewardView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State var rewardDescription: String = "나에게 어떤 선물을 줄까요?"
    @State var rewardTitle: String = ""
    @State var rewardSelectionOn: Bool = true
    @State var selectedReward: [String] = []
    @State var rewardCategory: [String] = ["잠자기", "알콜", "쇼핑", "운동", "음식", "놀기"]
    @State private var rewardDate = Date()
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    
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
            .navigationBarTitle("보상수정")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                        Button(action: {
                            dismiss()
                        }) {
                            Text("취소").foregroundColor(.black)
                        }
                    }
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                        Button(action: {
                            //saveRecord
                            //
                            //rewardInfo.
//                            ForEach(mainReward){ rewards in
//                                if rewards.id == rewardInfo.id{
//                                    rewards.title = rewardTitle
//                                    rewards.content = rewardDescription
////                                    break 없나?
//                                }
//                            }
                            dismiss()
                        }) {
                            Text("완료").foregroundColor(.black)
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

struct UpdateRewardView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateRewardView()
    }
}

