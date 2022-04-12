
import SwiftUI

struct DefaultRewardCard: View {
    
    var reward: Reward
    
    @State private var isDetailView = false
    
    var body: some View {
        Button(action: {
            isDetailView.toggle()
        }){
            VStack{
                
                Text("\(stringToImoticon(category: reward.category[0]))")
                            .font(Font.system(size: 40, design: .default))
                Text("\(reward.title)")
                    .font(.system(size: 14, weight: .semibold))
                    .padding(.bottom, 12.0)
            }
            .frame(width: 106.0, height: 140.0)
            .background(.white)
            .cornerRadius(20)
            .padding(.horizontal, 4)
            .padding(.bottom, 10)
            .shadow(color:  Color.black.opacity(0.14), radius: 8, y: 6)
            .fullScreenCover(isPresented: $isDetailView) {
                CardDetailView(reward : reward)
            }
        }
    }
}
