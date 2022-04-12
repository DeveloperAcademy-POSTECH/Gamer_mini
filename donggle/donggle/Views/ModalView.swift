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
            
            VStack(alignment: .leading) {
                Text("2022년 4월")
                    .padding(.vertical)
                Text("2022년 3월")
                    .padding(.vertical)
                Text("2022년 2월")
                    .padding(.vertical)
                Text("2022년 1월")
                    .padding(.vertical)
                Text("2021년 12월")
                    .padding(.vertical)
                Text("2021년 11월")
                    .padding(.vertical)
                Text("2021년 10월")
                    .padding(.vertical)
                Text("2021년 9월")
                    .padding(.vertical)
                Text("2021년 8월")
                    .padding(.vertical)
            }
            .frame(width: .infinity)

            
            Spacer()
            
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
