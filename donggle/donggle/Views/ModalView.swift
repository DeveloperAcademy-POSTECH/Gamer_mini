//
//  ModalView.swift
//  donggle
//
//  Created by 정재윤 on 2022/04/06.
//

import SwiftUI

func getDateList() -> [String] {
    var dateList: [String] = []
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY년 MM월"
    for i in 0...20 {
        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.month = -i
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        let date = dateFormatter.string(from: futureDate!)
        dateList.append(date)
    }
    
    return dateList
}

struct ModalView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @Binding var date: String
    @State var dateList = getDateList()
    var body: some View {
        VStack {
            HStack {
                Text("월 선택하기")
                    .fontWeight(.semibold)
                Spacer()
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                })
                .foregroundColor(.black)
            }
            .padding(26)
            .font(.title3)
            
            List {
                ForEach(dateList, id: \.self) { selectDate in
                    Button {
                        date = selectDate
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text(selectDate)
                    }
                    .padding(.horizontal)
                    .font(.system(size: 18, weight: .semibold))
                }
            }
            .listStyle(.plain)

            
            Spacer()
            
        }
    }
}

