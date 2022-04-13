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
    //let stressColor = [String : Double]
    @Binding var degree : Double
    @State var sliderValue : Double = UserDefaults.standard.double(forKey: "sliderValue")
    @State var stressIndex : Int = UserDefaults.standard.integer(forKey: "stressIndex")
    
    var stress: Stress
    
    //let stressColor = [string : Double] = stressCatagoryToColor(category: <#T##String#>)
    
    var dateFormatText: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY.M.d"
        return formatter
    }()
    
    
    var body: some View {
        
        ZStack(){
            VStack{
                Text("\(stress.date, formatter: dateFormatText)")
                    .font(.system(size: 15, weight: .regular))
                    .multilineTextAlignment(.center)
                    .padding(.top, 30.0)
                Circle()
                    .fill(Color.init(red: 255/255, green: (233-Double(stress.index)*2)/255, blue: 89/255))
                    .padding(2)
                    .frame(width: 120.0, height: 120.0)
                    .overlay {
                        Image(String(Int(stress.index) == 100 ? 100 :((Int(stress.index)+10)/10)*10))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                            .padding(.trailing, 30)
                            .padding(.bottom, 30)
                    }
                Text("\(stress.index)%")
                    .font(.system(size: 15, weight: .regular))
                    .multilineTextAlignment(.center)
                    .padding(.top, 5.0)
                /*
                 let stressColor = [String : Double] = stressCatagoryToColor(스트레스카테고리.category)
                 
                 .foregroundColor(Color(red: stressColor.red, green: stressColor.green, blue: stressColor.blue, opacity: 1))
                 */
                
                HStack(spacing: 6){
                    ForEach(stress.category, id: \.self){ categ in
                        let stressColor : [String : Double] = stressCatagoryToColor(category: categ)
                        
                        Text(categ)
                            .font(.system(size : 12))
                            .padding(.horizontal, 10.0)
                            .padding(.vertical, 2)
                            .foregroundColor(.white)
                            .background(RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(Color.init(red: stressColor["red"]!/255, green: stressColor["green"]!/255, blue: stressColor["blue"]!/255))
                                        
                            )
                        
                        //                            .foregroundColor(Color.init(red: 255/255, green: (233-sliderValue*2)/255, blue: 89/255))
                        //                            .background(RoundedRectangle(cornerRadius: 12)
                        //                                .foregroundColor(Color(red: stressColor["red"]!, green: stressColor["green"]!, blue: stressColor["blue"]!)))
                        //.padding(.top, 2.0)
                    }
                    
                }
                Spacer()
                
            }
            VStack{
                Text(stress.content)
                    .font(.system(size: 17, weight: .regular))
                    .multilineTextAlignment(.center)
                    .padding(.top, 278.0)
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
