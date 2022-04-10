//
//  ModalView.swift
//  donggle
//
//  Created by 정재윤 on 2022/04/06.
//

import SwiftUI

struct ModalView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
                Text("2022년 4월")
                Text("2022년 3월")
                Text("2022년 2월")
                Text("2022년 1월")
                Text("2021년 12월")
                Text("2021년 11월")
                Text("2021년 10월")
                Text("2021년 9월")
                Text("2021년 8월")

            }.listStyle(.plain)
            
            Spacer()
            
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
