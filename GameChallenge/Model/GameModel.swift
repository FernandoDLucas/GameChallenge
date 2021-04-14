//
//  GameModel.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 12/04/21.
//

import Foundation

struct GameModel: Codable {
    var localPlayerLife: Int
    var localPlayerMana: Int
    var localPlayerNumberOfCards: Int
    
    var remotePlayerLife: Int
    var remotePlayerMana: Int
    var remotePlayerNumberOfCards: Int
    
    init() {
        self.localPlayerLife = 20
        self.localPlayerMana = 1
        self.localPlayerNumberOfCards = 5
        
        self.remotePlayerLife = 20
        self.remotePlayerMana = 1
        self.remotePlayerNumberOfCards = 5
    }
    
    mutating func updateStatus( allyPlayer: Player, enemyPlayer: Player) {
        self.localPlayerLife = allyPlayer.life
        self.localPlayerMana = allyPlayer.life
        self.localPlayerNumberOfCards = allyPlayer.cardsOnHand.count
        
        self.remotePlayerLife = enemyPlayer.life
        self.remotePlayerMana = enemyPlayer.mana
        self.remotePlayerNumberOfCards = enemyPlayer.cardsOnHand.count
    }
}
//
//struct PlayerModel: Codable {
//    var numberOfCards: Int
//    var life: Int
//    var mana: Int
//
//    init(player: Player) {
//        self.numberOfCards = player.cardsOnHand.count
//        self.life = player.life
//        self.mana = player.mana
//    }
//}
