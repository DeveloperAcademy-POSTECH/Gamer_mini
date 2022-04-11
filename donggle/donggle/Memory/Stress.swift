//
//  Stress.swift
//  donggle
//
//  Created by 정재윤 on 2022/04/08.
//

import Foundation
import SwiftUI

class Stress2: Identifiable, ObservableObject  { 
    var id: Int
    var title: String
    var description: String
    var insertDate: Date
    var category: String
    var isEffective: Bool?
    var rewardKey: Int?
    
    init(id: Int, title: String, description: String, category: String, insertDate: Date = Date.now, isEffective: Bool?, rewardKey: Int?) {
        self.id = id
        self.title = title
        self.insertDate = insertDate
        self.description = description
        self.category = category
        self.isEffective = isEffective ?? nil
        self.rewardKey = rewardKey ?? nil
    }
}
