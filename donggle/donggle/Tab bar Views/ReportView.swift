//
//  ReportView.swift
//  donggle
//
//  Created by 정재윤 on 2022/04/07.
//

import SwiftUI


struct ReportView: View {
    @State private var showModal = false
    
    func countTarget() {
        var arr: [Stress] = UserDefaults.stressArray ?? []
        let stl = Stress(id: UUID(), index: 0, content: "", date: Date(), category: ["직장"], rewardKey: nil)
        arr.append(stl)
        UserDefaults.stressArray = arr
        print(arr)
    }
    var body: some View {
        NavigationView {
            CustomTapView()
                .toolbar {
                    ToolbarItem(placement:.navigationBarTrailing) {
                        NavigationLink(
                            destination: TimelineView(),
                            label: {
                                Text("Timeline")
                                    .padding(10)
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.green)
                            })
                    }
                    ToolbarItem(placement:.navigationBarLeading) {
                            Button(action: {
                                countTarget()
                                self.showModal = true
                            }) {
                                HStack {
                                    Text("4월")
                                        .foregroundColor(.black)
                                        .font(.system(size: 24, weight: .semibold))
                                    
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.black)
                                }
                            }
                            .sheet(isPresented: self.$showModal) {
                                ModalView()
                            }
                    }
                }
        }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
            .environmentObject(SSStore())
    }
}
