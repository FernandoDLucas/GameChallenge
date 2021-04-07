//
//  CardBuilder.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 18/03/21.
//

import Foundation

class BuildCards {

    let service = JSONService()
    
    func buildAllSpells () -> [SpellCard] {
        var cards: [SpellCard] = []
        if let result = service.decode() {
            result.Cards.forEach { cards.append(buildSpells(card: $0)) } }
            return cards
    }

    func buildSpells(card: CardStruct) -> SpellCard {
        return SpellCard.init(cost: card.CostValue, passiveDescription: card.Passive)
    }
}
