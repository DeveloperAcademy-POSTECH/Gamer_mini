

import SwiftUI



struct TimelineView: View {
    @State private var date = Date()
    @State private var showModal = false
    @State private var selectedView = 2
    
    var body: some View {

                VStack{
                    HStack{
                        
                        Button(action: {
                            self.showModal = true
                        }) {
                            Text("4월")
                                .foregroundColor(.black)
                                .font(.title2)
                                .padding(10)
                        }
                        .sheet(isPresented: self.$showModal) {
                            ModalView()
                        }

                        
                        Spacer()
                        
                        Picker(selection: $selectedView, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                            Text("전체").tag(1)
                            Text("보상").tag(2)
                            Text("스트레스").tag(3)

                        }
                        
                    }
                    .padding([.leading, .trailing])
                    
//                    Spacer()
                    
                    
                    if (selectedView == 2){
                        GiftView()
                    } else if (selectedView == 3){
                        StressView()
                    } else {
                        TotalView()
                    }
                    
                }
                    
        }
    
}



struct TotalView : View {
    var body: some View {
        Text("전체 타임라인")
    }
}


struct GiftView : View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center){
                ForEach(0..<10) { _ in
                    VStack(spacing: 5.0){
                        HStack{
                            Text("7 목")
                                .font(.title3)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(/*@START_MENU_TOKEN@*/.leading, 10.0/*@END_MENU_TOKEN@*/)
                        HStack(alignment: .center){
                            VStack(alignment: .center){
                                Text("🍺")
                                    .font(Font.system(size: 50, design: .default))
                                Text("음주")
                                    .fontWeight(.bold)
                            }.padding(10.0)
                                .frame(width: 80)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                .stroke(lineWidth: 1)
                            )
                            
                            Spacer()
                            VStack(alignment: .leading){
                                Text("맥주 한 잔!")
                                    .fontWeight(.bold)
                                Divider()
                                Text("오늘 요정들과 함께 뿌링클 치킨 사서 치맥하기!")
                            }
                        }
                    }
                }
//                .frame(height: 140.0)
                .padding(.all, 5.0)
                .background(RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 0.0, brightness: 0.926)/*@END_MENU_TOKEN@*/)
                )
            }
        }
        .padding(.horizontal, 10.0)
    }
}


struct StressView : View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center){
                ForEach(0..<10) { _ in
                    VStack(spacing: 5.0){
                        HStack{
                            Text("7 목")
                                .font(.title3)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(/*@START_MENU_TOKEN@*/.leading, 10.0/*@END_MENU_TOKEN@*/)
                        HStack(alignment: .center){
                            VStack(alignment: .center){
                                Circle()
                                    .fill(Color.gray)
                                Text("37%")
                            }.padding(10.0)
                                .frame(width: 80)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                .stroke(lineWidth: 0)
                            )
                            
                            Spacer()
                            VStack(alignment: .leading, spacing: 3.0){
                                HStack{
                                    Text("스트레스")
                                        .padding(.horizontal, 5.0)
                                        .foregroundColor(.white)
                                    .background(RoundedRectangle(cornerRadius: 15)
                                        .foregroundColor(.gray)
                                    )
                                    Text("직장")
                                }
//                                Divider()
                                Text("일이 너무 많고 어렵다. 맨날 야근을 해야하는데 잠이 너무 부족하고 짜증난다. 직장 사람들과는 친하지도 않아서 자리가 불편하다.")
                                    .font(.body)
                            }
                        }
                    }
                }
//                .frame(height: 140.0)
                .padding(.all, 5.0)
                .background(RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 0.0, brightness: 0.926)/*@END_MENU_TOKEN@*/)
                )
            }
        }
        .padding(.horizontal, 10.0)
    }
}





        


struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
    }
}
