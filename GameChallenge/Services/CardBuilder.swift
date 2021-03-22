//
//  CardBuilder.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 18/03/21.
//

import Foundation

class BuildCards {

    let service = JSONService()
    
    func buildAllCards() -> [Card] {
        var cards: [Card] = []
        if let result = service.decode() {
            result.Cards.forEach {
                switch $0.CardType {
                case "Entity":
                    cards.append(buildEntities(card: $0))
                case "Associated":
                    cards.append(buildAssociateds(card: $0))
                case "Spell":
                    cards.append(buildSpells(card: $0))
                default:
                    break
                }
            }
        }
        return cards
    }
    
    func buildEntities(card: CardStruct) -> EntityCard {
        return EntityCard.init(cost: card.CostValue, power: card.PowerValue, defense: card.DefenseValue, passiveDescription: card.Passive)
    }
    
    func buildAssociateds(card: CardStruct) -> AssocietedCard {
        return AssocietedCard.init(cost: card.CostValue, power: card.PowerValue, defense: card.DefenseValue, passiveDescription: card.Passive)
    }

    func buildSpells(card: CardStruct) -> SpellCard {
        return SpellCard.init(cost: card.CostValue, passiveDescription: card.Passive)
    }
}
