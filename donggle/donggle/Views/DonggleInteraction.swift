import SwiftUI

struct DonggleInteraction: View {
    var body: some View {
        donggle()
            .stroke(lineWidth: 4)
            .frame(width: 200, height: 200)
    }
}

struct donggle: Shape{

    //200말고 rect.size.width로 하고싶음
    var TopPointX = 200/2
    var TopPointY = 0
    var RightPointX = 200
    var RightPointY = 200/2
    var BottomPointX = 200/2
    var BottomPointY = 200
    var LeftPointX = 0
    var LeftPointY = 200/2
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: TopPointX, y: TopPointY))
            path.addQuadCurve(to: CGPoint(x: RightPointX, y: RightPointY), control: CGPoint(x: RightPointX, y: TopPointY))
            path.addQuadCurve(to: CGPoint(x: BottomPointX, y: BottomPointY), control: CGPoint(x: RightPointX, y: BottomPointY))
            path.addQuadCurve(to: CGPoint(x: LeftPointX, y: LeftPointY), control: CGPoint(x: LeftPointX, y: BottomPointY))
            path.addQuadCurve(to: CGPoint(x: TopPointX, y: TopPointY), control: CGPoint(x: LeftPointX, y: TopPointY))
        }
    }
}

struct DonggleInteraction_Previews: PreviewProvider {
    static var previews: some View {
        DonggleInteraction()
    }
}
