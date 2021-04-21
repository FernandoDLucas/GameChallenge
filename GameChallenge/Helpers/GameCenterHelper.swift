//
//  GameCenterHelper.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 12/04/21.
//

import GameKit

class GameCenterHelper: NSObject {
    
    static let helper = GameCenterHelper()
    
    weak var becameActiveDelegate: BecameActiveProtocol?
    
    var viewController: UIViewController?
    var currentMatchmakerVC: GKTurnBasedMatchmakerViewController?
    var currentMatch: GKTurnBasedMatch?
    typealias HandleCompletion = ((Error?) -> Void)

    var isAuthenticated: Bool {
        return GKLocalPlayer.local.isAuthenticated
    }
    
    override init() {
      super.init()
      
      GKLocalPlayer.local.authenticateHandler = { gcAuthVC, error in
        NotificationCenter.default.post(name: .authenticationChanged, object: GKLocalPlayer.local.isAuthenticated)

        if GKLocalPlayer.local.isAuthenticated {
          GKLocalPlayer.local.register(self)
        } else if let vc = gcAuthVC {
          self.viewController?.present(vc, animated: true)
        } else {
          print("Erro ao tentar autenticar no GameCenter, erro: \(error?.localizedDescription ?? "none")")
        }
      }
    }
    
    func presentMatchmaker() {
      guard GKLocalPlayer.local.isAuthenticated else {
        return
      }
      
      let request = GKMatchRequest()
      
      request.minPlayers = 2
      request.maxPlayers = 2
      request.inviteMessage = "Simbó jogar?"
      
      let vc = GKTurnBasedMatchmakerViewController(matchRequest: request)
      vc.turnBasedMatchmakerDelegate = self
      currentMatchmakerVC = vc
      viewController?.present(vc, animated: true)
    }

    func win(completion: @escaping HandleCompletion) {
      guard let match = currentMatch else {
        return
      }
      
      match.currentParticipant?.matchOutcome = .won
      match.others.forEach { other in
        other.matchOutcome = .lost
      }
      
      match.endMatchInTurn(
        withMatch: match.matchData ?? Data(),
        completionHandler: completion
      )
        NotificationCenter.default.post(name: .presentGame, object: match)
    }
    
    func lost(completion: @escaping HandleCompletion) {
      guard let match = currentMatch else {
        return
      }
      
      match.currentParticipant?.matchOutcome = .lost
      match.others.forEach { other in
        other.matchOutcome = .won
      }
      
      match.endMatchInTurn(
        withMatch: match.matchData ?? Data(),
        completionHandler: completion
      )
        NotificationCenter.default.post(name: .presentGame, object: match)
    }

    func endTurn(_ model: GameModel, completion: @escaping HandleCompletion) {
      guard let match = currentMatch else {
        completion(HelperError.matchNotFound)
        return
      }
      do {
        match.endTurn(
          withNextParticipants: match.others,
          turnTimeout: GKExchangeTimeoutDefault,
          match: try JSONEncoder().encode(model),
          completionHandler: completion
        )
      } catch {
        completion(error)
      }
        becameActiveDelegate?.deActivate()
    }
}

extension GameCenterHelper: GKTurnBasedMatchmakerViewControllerDelegate {
    func turnBasedMatchmakerViewControllerWasCancelled(_ viewController: GKTurnBasedMatchmakerViewController) {
        viewController.dismiss(animated: true)
    }
    
    func turnBasedMatchmakerViewController(_ viewController: GKTurnBasedMatchmakerViewController, didFailWithError error: Error) {
        print("\(error) ao achar partida")
    }
}

extension GameCenterHelper: GKLocalPlayerListener {
    
    func player(_ player: GKPlayer, wantsToQuitMatch match: GKTurnBasedMatch) {
      let activeOthers = match.others.filter { other in
        return other.status == .active
      }
      
      match.currentParticipant?.matchOutcome = .lost
      activeOthers.forEach { participant in
        participant.matchOutcome = .won
      }
      
      match.endMatchInTurn(
        withMatch: match.matchData ?? Data()
      )
    }
    
    func player(_ player: GKPlayer, receivedTurnEventFor match: GKTurnBasedMatch, didBecomeActive: Bool) {
     
        if let vc = currentMatchmakerVC {
        currentMatchmakerVC = nil
        vc.dismiss(animated: true)
      }
//      guard didBecomeActive else {
//        print("Teste")
//        return
//      }
        if match.isLocalPlayersTurn {
            becameActiveDelegate?.activate()
        } else {
            becameActiveDelegate?.deActivate()
        }

    NotificationCenter.default.post(name: .presentGame, object: match)
    }
}

extension GKTurnBasedMatch {
  var isLocalPlayersTurn: Bool {
    return currentParticipant?.player == GKLocalPlayer.local
  }
  
  var others: [GKTurnBasedParticipant] {
    return participants.filter {
      return $0.player != GKLocalPlayer.local
    }
  }
}

extension Notification.Name {
  static let presentGame = Notification.Name(rawValue: "presentGame")
  static let authenticationChanged = Notification.Name(rawValue: "authenticationChanged")
    static let endGame = Notification.Name(rawValue: "endGame")
}

enum HelperError: Error {
  case matchNotFound
}

protocol BecameActiveProtocol: AnyObject {
    func activate()
    func deActivate()
}
