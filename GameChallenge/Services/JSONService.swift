//
//  JsonService.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 17/03/21.
//

import Foundation

class JSONService {
    let url = Bundle.main.url(forResource: "Cards", withExtension: "json")
    let decoder = JSONDecoder()
    var jsonCards: JSONCards?
    
    func decode() -> JSONCards? {
        do {
            let data = try Data(contentsOf: url!)
            let cards = try decoder.decode(JSONCards.self, from: data)
            self.jsonCards = cards
            return cards
        } catch {
            print(error)
            return nil
        }
    }
}
