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
        switch CardType(rawValue: card.CardType) {
        case .heal:
            return SpellCard.init(cost: card.CostValue, passiveDescription: card.Passive, passiveHeal: card.EffectValue)
        case .damage:
            return SpellCard.init(cost: card.CostValue, passiveDescription: card.Passive, passiveDamage: card.EffectValue)
        case .none:
            return SpellCard.init(cost: card.CostValue, passiveDescription: card.Passive, passiveHeal: card.EffectValue) 
        }
    }
}

enum CardType: String {
    case heal = "Heal"
    case damage = "Damage"
}
