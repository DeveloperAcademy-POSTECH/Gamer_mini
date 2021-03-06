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
    case "μ§μ₯":
        return "π§³"
    case "λ μ¨":
        return "π€"
    case "μλ©΄":
        return "π€"
    case "κ°μ‘±":
        return "π¨βπ©βπ§βπ¦"
    case "κΈμ ":
        return "π΅"
    case "νμ":
        return "π"
    case "μΈκ°κ΄κ³":
        return "π«"
    case "κ·Έλ₯":
        return "π"
// -----μ€νΈλ μ€--------
    case "μΌν":
        return "π"
    case "μ΄λ":
        return "ποΈββοΈ"
    case "μμ":
        return "π"
    case "λκΈ°":
        return "πΊ"
    case "μ μκΈ°":
        return "π€"
    case "μμ½":
        return "π»"
    case "μΉ­μ°¬νκΈ°":
        return "π"
    case "κΏμ ":
        return "π"
// -----λ³΄μ--------
    case "κΈ°ν":
        return "π§ββοΈ"

    default:
        return "ποΈ"
    }
}

func stressCatagoryToColor(category:String) -> [String : Double] {
    switch category{
    case "μ§μ₯":
        return ["red": 177.0, "green":199.0 , "blue" :227.0]
    case "λ μ¨":
        return ["red": 253.0, "green":178.0 , "blue" :109.0]
    case "μλ©΄":
        return ["red": 172.0, "green":211.0 , "blue" :110.0]
    case "κ°μ‘±":
        return ["red": 242.0, "green":178.0 , "blue" :187.0]
    case "κΈμ ":
        return ["red": 247.0, "green":224.0 , "blue" :106.0]
    case "κΈ°ν":
        return ["red": 227.0, "green":202.0 , "blue" :162.0]
    case "μΈκ°κ΄κ³":
        return ["red": 233.0, "green":142.0 , "blue" :142.0]
    case "νμ":
        return ["red": 194.0, "green":180.0 , "blue" :222.0]
    case "μ΄μ  λͺ¨λ¦":
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
