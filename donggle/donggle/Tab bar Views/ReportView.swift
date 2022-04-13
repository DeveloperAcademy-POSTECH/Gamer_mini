//
//  ReportView.swift
//  donggle
//
//  Created by 정재윤 on 2022/04/07.
//

import SwiftUI

let dateFormatter = DateFormatter()

func getMonth() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY년 MM월"
    let month = dateFormatter.string(from: Date())
    return month
}

struct ReportView: View {
    @State private var showModal = false
    @State private var date = getMonth()
    
    var body: some View {
        let idx: String.Index = date.index(date.startIndex, offsetBy: date.count - 4)
        let month = String(date[idx...])

        NavigationView {
            CustomTapView(date: date)
                .toolbar {
                    ToolbarItem(placement:.navigationBarTrailing) {
                        NavigationLink(
                            destination: TimelineView(),
                            label: {
                                Text("Timeline")
                                    .padding(10)
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.black)
                            })
                    }
                    ToolbarItem(placement:.navigationBarLeading) {
                            Button(action: {
                                self.showModal = true
                            }) {
                                HStack {
                                    Text(month)
                                        .foregroundColor(.black)
                                        .font(.system(size: 24, weight: .semibold))
                                    
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.black)
                                }
                            }
                            .sheet(isPresented: self.$showModal) {
                                ModalView(date: $date)
                            }
                    }
                }
        }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}
