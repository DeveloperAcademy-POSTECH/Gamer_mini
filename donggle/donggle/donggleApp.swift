//
//  donggleApp.swift
//  donggle
//
//  Created by Lee Myeonghwan on 2022/04/07.
//

import SwiftUI

@main
struct donggleApp: App {
    @StateObject var store = Store()
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environmentObject(store)
        }
    }
}
