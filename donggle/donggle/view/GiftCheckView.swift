//
//  GiftCheckView.swift
//  donggle
//
//  Created by Kim Hwiwon on 2022/04/06.
//

import SwiftUI

struct GiftCheckView: View {
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button("취소") {
                    }
                    .padding(.leading)
                    Spacer()
                }

                Spacer()
                
            }
            
            VStack {
                Text("보상의 효과가 있었나요?")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                HStack {
                    Button("예") {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                    }
                    Spacer()
                    Button("아니요") {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                    }
                }
                .padding()
                .frame(width: /*@START_MENU_TOKEN@*/200.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)
                
                Spacer()
                
            }
            .padding(.vertical, 150.0)
            
            
            VStack {
                
                Spacer()
                
                Text("스트레스가 얼마나 해소되었나요?")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(/*@START_MENU_TOKEN@*/.vertical, 18.0/*@END_MENU_TOKEN@*/)
                    
                Circle()
                    .fill(Color.gray)
                    .frame(width: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)
                
                HStack {
                    Text("😁")
                    Slider(value: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant(10)/*@END_MENU_TOKEN@*/)
                        .frame(width: /*@START_MENU_TOKEN@*/300.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    Text("🤯")
                }
                
            }
            .padding(.vertical, 150.0)
            
            VStack {
                Spacer()
                Button("완료") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
            }
       
        }
    }
}

struct GiftCheckView_Previews: PreviewProvider {
    static var previews: some View {
        GiftCheckView()
    }
}
