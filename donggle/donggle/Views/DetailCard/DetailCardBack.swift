//
//  DetailCardBack.swift
//  donggle
//
//  Created by 윤가희 on 2022/04/10.
//

import SwiftUI

struct DetailCardBack: View {
    
    let width: CGFloat
    let height: CGFloat
    @Binding var degree : Double
    @State var sliderValue : Double = UserDefaults.standard.double(forKey: "sliderValue")
    @State var stressIndex : Int = UserDefaults.standard.integer(forKey: "stressIndex")
    var reward: Reward
    
    var body: some View {
         
        ZStack(){
            VStack{
                Text("2022.04.03")
                    .font(.system(size: 15, weight: .regular))
                    .multilineTextAlignment(.center)
                    .padding(.top, 30.0)
                
                Circle()
                    .fill(Color.init(red: (sliderValue+1)*2/255, green: (101-sliderValue)*2/255, blue: (101-sliderValue)*2/255))
                    .frame(width: 100.0, height: 100.0)
                    .padding(.top, 38)
                Text("\(stressIndex)%")
                    .font(.system(size: 15, weight: .regular))
                    .multilineTextAlignment(.center)
                    .padding(.top, 5.0)
                Capsule()
                    .fill(Color.gray)
                    .frame(width: 54.0, height: 24.0)
                
                Text("아니 왜 갑자기 야근 시켜??? 이거 수요일 마감이잖아요 약속도 취소하고 ㅠㅠ,, 너무 슬프다 저녁에 집가서 야식 먹어야지,, 그래도 오늘은 요정들 드라마볼 수 있어서 버틴다..")
                    .font(.system(size: 17, weight: .regular))
                    .multilineTextAlignment(.center)
                    .padding(.top, 14.0)
                    .padding([.leading, .trailing], 20.0)
                Spacer()
            }
        }
        .frame(width: 316.0, height: 418.0)
        .foregroundColor(Color.black)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 28, x: 0, y: 12)
        .rotation3DEffect(Angle(degrees: degree), axis: (x:0, y:1, z:0))
        
    }
}
/*
func GetStress(reward: reward){
    var RStress = UserDefaults.stressArray.filter { stress in reward.stressKey == stress.id}
     ForEach(RStress) { stress in
        let content = stress.content
     }
}
*/

/*
struct DetailCardBack_Previews: PreviewProvider {
    static var previews: some View {
        DetailCardBack()
    }
}
*/
