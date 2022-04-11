
import SwiftUI

struct RecordRewardView: View {
    @Binding var isFullScreen: Bool

    var body: some View {
        NavigationView {
                    NavigationLink(destination: CalendarView()) {
                    }.navigationBarTitle("보상기록")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                            Button(action: {
                                isFullScreen.toggle()
                            }) {
                                    Text("취소")
                            }
                        }
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                        Button(action: {
                            // 완료 기능
                        }) {
                                Text("완료")
                        }
                }
            }
        }
    }
}
