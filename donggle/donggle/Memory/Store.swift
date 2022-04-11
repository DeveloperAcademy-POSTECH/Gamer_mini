//
//  Store.swift
//  donggle
//
//  Created by 정재윤 on 2022/04/08.
//

import Foundation

class SSStore: ObservableObject {
    @Published var stressList: [Stress2]
    @Published var rewardList: [Reward2]
    
    init() {
        stressList = [
            Stress2(id : 0, title : "인간관계", description : "친구랑 싸움", category : "👭", insertDate : Date.now, isEffective : nil, rewardKey: nil),
            Stress2(id : 1, title : "직장", description : "일이 조오오온나 많다", category : "💻", insertDate : Date.now, isEffective : nil, rewardKey : 1 ),
            Stress2(id : 2, title : "다이어트", description : "덜먹는데 왜 살이 찌지?", category : "🥬", insertDate : Date.now.addingTimeInterval(3600 * -24), isEffective : nil, rewardKey : 1 ),
            Stress2(id : 3, title : "수면", description : "불면증이너무싫다", category : "💤", insertDate : Date.now.addingTimeInterval(3600 * -24), isEffective : nil, rewardKey : 1 ),
            Stress2(id : 4, title : "직장", description : "김부장 쓋", category : "💻", insertDate : Date.now.addingTimeInterval(3600 * -24), isEffective : nil, rewardKey : 1 ),
            Stress2(id : 5, title : "인간관계", description : "사회생활이 힘들구만", category : "👭", insertDate : Date.now.addingTimeInterval(3600 * -48), isEffective : nil, rewardKey : 1 ),
            Stress2(id : 6, title : "인간관계", description : "친구랑싸움", category : "👭", insertDate : Date.now.addingTimeInterval(3600 * -72), isEffective : nil, rewardKey : 1 )]
        
        rewardList =  [
            Reward2(id : 0, title : "맥주 마시기", description : "역할매에서 술마실테야", category : "🍺", insertDate : Date.now, isEffective : nil, stressKey : nil ),
            Reward2(id : 1, title : "맛난 식사", description : "메로나 먹고싶어", category : "🍔", insertDate : Date.now, isEffective : nil, stressKey : 1 ),
            Reward2(id : 2, title : "여행가기", description : "메로나 먹고싶어", category : "🚚", insertDate : Date.now.addingTimeInterval(3600 * -24), isEffective : nil, stressKey : 1 ),
            Reward2(id : 3, title : "운동하기", description : "메로나 먹고싶어", category : "⚽️", insertDate : Date.now.addingTimeInterval(3600 * -24), isEffective : nil, stressKey : 1 ),
            Reward2(id : 4, title : "잠자기", description : "메로나 먹고싶어", category : "💤", insertDate : Date.now.addingTimeInterval(3600 * -24), isEffective : nil, stressKey : 1 ),
            Reward2(id : 5, title : "흐느적거리기", description : "메로나 먹고싶어", category : "🐙", insertDate : Date.now.addingTimeInterval(3600 * -48), isEffective : nil, stressKey : 1 ),
            Reward2(id : 6, title : "꿈틀거리기", description : "메로나 먹고싶어", category : "🪱", insertDate : Date.now.addingTimeInterval(3600 * -72), isEffective : nil, stressKey : 1 )]
    }
    
    func removeDuplicate (_ array: [Stress2]) -> [Stress2] {
        var removedArray: [Stress2] = []
        for a in array {
            for i in 0 ... array.count {
                if stressList[i].title != a.title {
                    removedArray.append(a)
                }
            }
        }
        return removedArray
    }
}

