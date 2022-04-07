import SwiftUI

struct donggle_home1: View {
    var body: some View {
        VStack(alignment: .center) {
                Spacer()
                HStack{
                    Text("동글이")
                        .font(.system(size: 28, weight: .bold))
                        .multilineTextAlignment(.leading)
                        //.position(x:62, y:80)
                    Spacer()
                    Image(systemName: "square.and.pencil")
                        .imageScale(.large)
                }
                Spacer()
                Circle()
                    .fill(Color.gray)
                    .padding()
                    .frame(width: 200.0, height: 200.0)
                    //.position(x:195, y:0)
                Text("72%")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(Color.gray)
                Divider()
                Spacer()
                HStack{
                    Button("1") {
                    }
                        .padding()
                        .frame(width: 56.0, height: 56.0)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(28)
                    Button("2") {
                    }
                        .padding()
                        .frame(width: 56.0, height: 56.0)
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .cornerRadius(28)
                    Button("3") {
                    }
                        .padding()
                        .frame(width: 56.0, height: 56.0)
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .cornerRadius(28)
                    Button("4") {
                    }
                        .padding()
                        .frame(width: 56.0, height: 56.0)
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .cornerRadius(28)
                    Button("5") {
                    }
                        .padding()
                        .frame(width: 56.0, height: 56.0)
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .cornerRadius(28)
                }
                
                HStack{
                    Button("제주도") {
                    }
                        .padding()
                        .frame(width: 106.0, height: 140.0)
                        .foregroundColor(.black)
                        .background(Color.gray)
                        .cornerRadius(20)
                    Button("잠") {
                    }
                        .padding()
                        .frame(width: 106.0, height: 140.0)
                        .foregroundColor(.black)
                        .background(Color.gray)
                        .cornerRadius(20)
                    Button("맥주") {
                    }
                        .padding()
                        .frame(width: 106.0, height: 140.0)
                        .foregroundColor(.black)
                        .background(Color.gray)
                        .cornerRadius(20)
                }
                Spacer()
        }
        .padding(.horizontal, 24.0)
            
    }
}

struct donggle_home1_Previews: PreviewProvider {
    static var previews: some View {
        donggle_home1()

    }
}
