//
//  Reward.swift
//  donggle
//
//  Created by 정재윤 on 2022/04/08.
//

import Foundation
import SwiftUI

class Reward: Identifiable, ObservableObject  {
    var id: Int
    var title: String
    var description: String
    var insertDate: Date
    var category: String
    var isEffective: Bool?
    var stressKey: Int?
    
    init(id: Int, title: String, description: String, category: String, insertDate: Date = Date.now, isEffective: Bool?, stressKey: Int?) {
        self.id = id
        self.title = title
        self.insertDate = insertDate
        self.description = description
        self.category = category
        self.isEffective = isEffective ?? nil
        self.stressKey = stressKey ?? nil
    }
}
