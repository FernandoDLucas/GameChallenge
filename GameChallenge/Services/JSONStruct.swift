//
//  JSONStruct.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 17/03/21.
//

import Foundation

struct JSONCards: Decodable {
    
    var Cards: [CardStruct]
}

struct CardStruct: Decodable {
    var ID: Int
    var CardName: String
    var CostValue: Int
    var EffectValue: Int
    var Passive: String
    var CardType: String
}
