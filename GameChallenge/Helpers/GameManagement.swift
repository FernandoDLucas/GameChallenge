//
//  GameManagement.swift
//  GameChallenge
//
//  Created by Lidiane Gomes Barbosa on 07/04/21.
//

import SpriteKit
class GameManagement {
    let playerOne: Player
    let playerTwo: Player
    var numberOfTurn: Int = 1
    var displayCard: DisplayCardHelper
    var itemsPlayer: ItemsPlayer
    var itemsEnemy: ItemsEnemy
 
    init(playerOne: Player, playerTwo: Player, displayCard: DisplayCardHelper, itemsPlayer: ItemsPlayer, itemsEnemy: ItemsEnemy) {
        self.playerOne = playerOne
        self.playerTwo = playerTwo
        self.displayCard = displayCard
        self.itemsPlayer = itemsPlayer
        self.itemsEnemy = itemsEnemy
    }

    func setInitialPlayer() {
        playerOne.isActive = Bool.random()
        if !playerOne.isActive {
            playerTwo.isActive = true
        }
    }
    
    func initGame() {
        setInitialPlayer()
        updateScene()
    }
    
    func updateScene() {
        if playerOne.isActive {
            updateDisplayCard(playerOne)
            updateItemsPlayer(playerOne)
            updateItemsEnemy(playerTwo)
        } else {
            updateDisplayCard(playerTwo)
            updateItemsPlayer(playerTwo)
            updateItemsEnemy(playerOne)
        }
    }
    
    private func updateDisplayCard(_ player: Player) {
        displayCard.updateCards(cards: player.cardsOnHand)
    }
    
    private func updateItemsEnemy( _ player: Player) {
        itemsEnemy.updateValues(mana: player.mana, life: player.life, numberOfCardsOnHand: player.cardsOnHand.count)
        
    }
    
    private func updateItemsPlayer(_ player: Player) {
        itemsPlayer.updateValues(mana: player.mana, life: player.life, cardsOnDeck: player.cardsOnDeck)
    }
    
    func play() {

    }
    
    func endGame(winner: Player) {
        // exibe o ganhador e finaliza o jogo
    }
    
    func isGameEnded() -> Player? {
        if playerOne.life == 0 || playerOne.surrender {
            return playerTwo
        } else if playerTwo.life == 0 || playerTwo.surrender {
            return playerOne
        }
        
        return nil
    }
    
    func isNewTurn() -> Bool {
        if numberOfTurn % 2 != 0 {
            return true
        }
        return false
    }
}
