//
//  SRdata.swift
//  donggle
//
//  Created by Lee Myeonghwan on 2022/04/08.
//

import Foundation

struct Stress : Codable{
    var id : UUID
    var index : Int
    var content : String
    var date : Date
    var category : [String]
    var rewardKey : UUID?
}

struct Reward : Codable{
    var id : UUID
    var title : String
    var content : String
    var date : Date
    var category : [String]
    var isEffective : Bool?
    var stressKey : UUID?
}

func stringToImoticon(category:String) -> String {
    switch category{ 
    case "직장":
        return "🧳"
    case "날씨":
        return "🌤"
    case "수면":
        return "🤤"
    case "가족":
        return "👨‍👩‍👧‍👦"
    case "금전":
        return "💵"
// -----스트레스--------
    case "쇼핑":
        return "🛒"
    case "운동":
        return "🏋️‍♀️"
    case "음식":
        return "🍚"
    case "놀기":
        return "🕺"
    case "잠자기":
        return "💤"
    case "알콜":
        return "🍻"
// -----보상--------
    case "기타":
        return "🧚‍♀️"

    default:
        return "🈚️"
    }
}



extension UserDefaults {
    
    static var stressArray: [Stress]? {
        get {
            var stress: [Stress]?
            if let data = UserDefaults.standard.value(forKey:"stressArray") as? Data {
                stress = try? PropertyListDecoder().decode([Stress].self, from: data)
            }
            return stress ?? []
        }
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey:"stressArray")
        }
    }
    
    
    static var rewardArray: [Reward]? {
        get {
            var reward: [Reward]?
            if let data = UserDefaults.standard.value(forKey:"rewardArray") as? Data {
                reward = try? PropertyListDecoder().decode([Reward].self, from: data)
            }
            return reward ?? []
        }
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey:"rewardArray")
        }
    }
}

