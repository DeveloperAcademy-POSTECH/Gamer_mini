//
//  NavigationBarWithButton.swift
//  donggle
//
//  Created by 정재윤 on 2022/04/06.
//

import SwiftUI

struct NavigationBarWithButton: ViewModifier {
    var title: String = ""
    @State private var showModal = false
    
    func body(content: Content) -> some View {
        return content
            .navigationBarItems(leading: Button(action: {
                self.showModal = true
            }, label: {
                Text("4월")
            })
                .font(.system(size: 24, weight: .bold))
                .accentColor(.black),
                                trailing: NavigationLink(destination: TimelineView()) {
                        Text("Timeline")
                    })
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithTransparentBackground()
                appearance.backgroundColor = UIColor(white: 1, alpha: 0.5)
                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().compactAppearance = appearance
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
            }
            .sheet(isPresented: self.$showModal) {
                ModalView()
            }
    }
}

extension View {
    func navigationBarWithButtonStyle(_ title: String) -> some View {
        return self.modifier(NavigationBarWithButton(title: title))
    }
}

struct NavigationBarWithButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Color.white.edgesIgnoringSafeArea(.all)
                .navigationBarWithButtonStyle("4월")
        }
    }
}
