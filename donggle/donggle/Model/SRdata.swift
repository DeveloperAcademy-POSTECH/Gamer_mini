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
    case "그냥":
        return "🤡"
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
    case "칭찬하기":
        return "💝"
// -----보상--------
    case "기타":
        return "🧚‍♀️"

    default:
        return "🈚️"
    }
}

func stressCatagoryToColor(category:String) -> [String : Double] {
    switch category{
    case "직장":
        return ["red": 177.0, "green":199.0 , "blue" :227.0]
    case "날씨":
        return ["red": 253.0, "green":178.0 , "blue" :109.0]
    case "수면":
        return ["red": 172.0, "green":211.0 , "blue" :110.0]
    case "가족":
        return ["red": 242.0, "green":178.0 , "blue" :187.0]
    case "금전":
        return ["red": 247.0, "green":224.0 , "blue" :106.0]
    case "기타":
        return ["red": 227.0, "green":202.0 , "blue" :162.0]
    case "인간관계":
        return ["red": 233.0, "green":142.0 , "blue" :142.0]
    case "학업":
        return ["red": 194.0, "green":180.0 , "blue" :222.0]
    case "이유 모름":
        return ["red": 181.0, "green":159.0 , "blue" :142.0]
    default:
        return ["red": 184.0, "green":223.0 , "blue" :211.0]
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
