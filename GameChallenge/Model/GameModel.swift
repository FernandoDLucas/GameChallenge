//
//  GameModel.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 12/04/21.
//

import Foundation

struct GameModel: Codable {
    var player: PlayerModel
    var turn: Int
    
    mutating func updateStatus(for player: PlayerModel) {
    }
}

struct PlayerModel: Codable {
    var numberOfCards: Int
    var life: Int
    var mana: Int
}
