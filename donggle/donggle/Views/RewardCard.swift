
import SwiftUI

struct RewardCard: View {
    
    var reward: Reward
    
    @State private var isDetailView = false
    @Binding var sliderValue : Double
    @Binding var stressIndex : Int
    
    var body: some View {
        Button(action: {
            isDetailView.toggle()
        }){
            VStack(spacing : 0){
                if(reward.isEffective == nil){
                    Text("\(stringToImoticon(category: reward.category[0]))")
                        .font(.system(size: 44, design: .default))
                        .padding(.top, 30)
                        .padding(.bottom, 12)
                    .opacity(0.3)
                }else{
                    Text("\(stringToImoticon(category: reward.category[0]))")
                        .font(.system(size: 44, design: .default))
                        .padding(.top, 30)
                        .padding(.bottom, 12)
                }
                Text("\(reward.title)")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 18)
            }// : VStack
            .frame(width: 106, height: 140)
            .background(.white)
            .cornerRadius(20)
            .padding(.horizontal, 6)
            .shadow(color:  Color.black.opacity(0.14), radius: 8, y: 6)
            .fullScreenCover(isPresented: $isDetailView) {
                CardDetailView(reward: reward, sliderValue: $sliderValue, stressIndex: $stressIndex)
            }
        }
    }
}
