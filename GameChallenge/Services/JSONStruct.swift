//
//  JSONStruct.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 17/03/21.
//

import Foundation

struct JSONCards: Decodable {
    
    var Cards: [CardStruct]
    
//    enum CodingKeys: String, CodingKey{
//        case Cards = "Cards"
//    }
}

struct CardStruct: Decodable {
    var ID: Int
    var CardName: String
    var CostValue: Int
    var DefenseValue: Int
    var PowerValue: Int
    
//    enum CodingKeys: String, CodingKey{
//        case ID = "ID"
//        case CardName = "CardName"
//        case CostValue = "CostValue"
//        case DefenseValue = "DefenseValue"
//        case PowerValue = "PowerValue"
//    }

}
