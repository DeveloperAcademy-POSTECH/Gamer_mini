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
    var reward : Reward
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
                        Text("\(stringToImoticon(category:reward.category[0]))")
                            .font(.system(size: 120))
                        Text("\(reward.title)")
                            .font(.title3)
                    }else{
      
                            Text("\(Int(sliderValue))%")
                            Circle()
                            .fill(Color.init(red: 255/255, green: (233-sliderValue*2)/255, blue: 89/255))
                                .frame(width: 130.0, height: 120.0)
                            HStack{
                                Image(systemName: "circle.fill")
                                    .foregroundColor(.yellow)
                                Slider(value: $sliderValue, in: 0...100,step: 1.0)
                                    .tint(.black)
                                Image(systemName: "circle.fill")
                                    .foregroundColor(.red)
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
                            isRewardEffective = true
                        }
                        else{
                            for (index,rewards) in mainReward.enumerated(){
                                if rewards.id == reward.id{
                                    mainReward[index].isEffective = isRewardEffective
                                    break
                                }
                            }
                            UserDefaults.rewardArray = mainReward
                            print(mainReward)
                            dismiss()
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

//struct GiftCheckView_Previews: PreviewProvider {
//    static var previews: some View {
//        GiftCheckView(reward)
//    }
//}
