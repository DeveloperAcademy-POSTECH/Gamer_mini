//
//  GiftCheckView.swift
//  donggle
//
//  Created by Kim Hwiwon on 2022/04/06.
//

import SwiftUI
import Foundation

struct GiftCheckView: View {
    @Environment(\.dismiss) private var dismiss
    @State var sliderValue : Double = 50
    @State var rewardComplateOn : Bool = true
    @State var modifyStressOn : Bool = false
    @State var isRewardEffective : Bool = false
    var body: some View {
        NavigationView{
            VStack(spacing:90){
                if rewardComplateOn{
                    Text("보상을 완료했나요?")
                        .font(.title)
                        .fontWeight(.bold)
                        .transition(AnyTransition.opacity.animation(.easeInOut(duration:0.3)))
                }
                else if !rewardComplateOn && !modifyStressOn{
                    Text("보상이 효과있었나요?")
                        .font(.title)
                        .fontWeight(.bold)
                        .transition(AnyTransition.opacity.animation(.easeInOut(duration:0.3)))
                }else{
                    Text("지금 기분이 어떤가요?")
                        .font(.title)
                        .fontWeight(.bold)
                        .transition(AnyTransition.opacity.animation(.easeInOut(duration:0.3)))
                }
                
                VStack(spacing:20){
                    if !modifyStressOn{
                        Text("🍔")
                            .font(.system(size: 120))
                        Text("야식 당장 뜯어")
                            .font(.title3)
                    }else{
      
                            Text("\(Int(sliderValue))%")
                            Circle()
                                .fill(Color.init(red: (sliderValue+1)*2/255, green: (101-sliderValue)*2/255, blue: (101-sliderValue)*2/255))
                                .frame(width: 130.0, height: 120.0)
                            HStack{
                                Image(systemName: "circle")
                                Slider(value: $sliderValue, in: 0...100,step: 1.0)
                                Image(systemName: "circle.fill")
                            }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        
                    }
                    
                }
                HStack{
                    Button(action: {
                        if rewardComplateOn{
                            dismiss()
                        }
                        else if !rewardComplateOn && !modifyStressOn{
                            isRewardEffective = false
                            modifyStressOn = true
                        }
                        else{
                            modifyStressOn = false
                        }
                    }){
                        if !modifyStressOn{
                            Text("아니오")
                                .modifier(confirmTextGrayModifier())
                        }
                        else{
                            Text("뒤로")
                                .modifier(confirmTextGrayModifier())
                        }
                    }
                    
                    Button(action: {
                        if rewardComplateOn{
                            rewardComplateOn = false
                        }
                        else if !rewardComplateOn && !modifyStressOn{
                            modifyStressOn = true
                        }
                        else{
                            //saveRecord
                            //
                            //rewardInfo.
//                            ForEach(mainReward){ rewards in
//                                if rewards.id == rewardInfo.id{
//                                    rewards.isEffective = isRewardEffective
////                                    break 없나?
//                                }
//                            }
                            UserDefaults.rewardArray = mainReward
                        }
                        
                    }){
                        if !modifyStressOn{
                            Text("예")
                                .modifier(confirmTextYellowModifier())
                        }
                        else{
                            Text("완료")
                                .modifier(confirmTextYellowModifier())
                        }
                    }
                }
                
                
                
            }
            .navigationTitle(Text("보상 완료"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("X"){
                        dismiss()
                    }
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
