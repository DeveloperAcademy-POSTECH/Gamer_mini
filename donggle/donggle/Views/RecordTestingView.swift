//
 //  RecordTestingView.swift
 //  donggle
 //
 //  Created by Lee Myeonghwan on 2022/04/09.
 //

 import SwiftUI

  struct RecordTestingView: View {
     @State private var showModal = false
     @State var sliderValue : Double = UserDefaults.standard.double(forKey:"sliderValue")
     @State var stressIndex : Int = UserDefaults.standard.integer(forKey:"stressIndex")
     func resetDefaults() {
         let defaults = UserDefaults.standard
         let dictionary = defaults.dictionaryRepresentation()
         dictionary.keys.forEach { key in
             defaults.removeObject(forKey: key)
         }
     }
     var body: some View {
         VStack {
             Button(action: {
             self.showModal = true
             }){
                 Image(systemName: "square.and.pencil")
                     .imageScale(.large)
             }
             .sheet(isPresented: self.$showModal) {
                 RecordView(stressIndex: $stressIndex ,sliderValue: $sliderValue)
             }
             Text("스트레스 지수: \(stressIndex)%")
             Button(action: {
                 resetDefaults()
             }){
                 Text("UserDefaults 리셋")
             }
         }
     }
 }

  struct RecordTestingView_Previews: PreviewProvider {
     static var previews: some View {
         RecordTestingView()
     }
 }
