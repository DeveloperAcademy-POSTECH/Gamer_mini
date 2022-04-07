//
//  RewardReportView.swift
//  donggle
//
//  Created by 정재윤 on 2022/04/06.
//

import SwiftUI

struct RewardReportView: View {
    var body: some View {
        NavigationView {
            List {
                ScrollView(.horizontal) {
                            HStack {
                                Rectangle()
                                    .frame(width: 100, height: 100)
                                Rectangle()
                                    .frame(width: 100, height: 100)
                                Rectangle()
                                    .frame(width: 100, height: 100)
                                Rectangle()
                                    .frame(width: 100, height: 100)
                                Rectangle()
                                    .frame(width: 100, height: 100)
                                Rectangle()
                                    .frame(width: 100, height: 100)
                            }
                            .frame(maxHeight: .infinity)
                        }
                
                ProgressBar(width: 300, height: 20, percent: 69)
                    .padding(.vertical, 20)
                
                ListRow(name: "인간관계")
                ListRow(name: "직장")
                ListRow(name: "수면")
                ListRow(name: "다이어트")
                ListRow(name: "그외 3개")
                
            }
        }
    }
}

struct RewardReportView_Previews: PreviewProvider {
    static var previews: some View {
        RewardReportView()
    }
}
