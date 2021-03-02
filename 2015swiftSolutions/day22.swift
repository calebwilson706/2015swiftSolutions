//
//  day22.swift
//  2015swiftSolutions
//
//  Created by Caleb Wilson on 01/03/2021.
//

import Foundation



enum Spell : CaseIterable {
    case MAGIC_MISSILE, DRAIN, SHIELD, POISON, RECHARGE
}


let spellCost : [ Spell : Int ] = [
    .MAGIC_MISSILE: 53,
    .DRAIN: 73,
    .SHIELD: 113,
    .POISON: 173,
    .RECHARGE: 229
]


struct GameState {
    var spellDurationsRemaining : [ Spell : Int ]
    var playerHP : Int
    var playerMana : Int
    var bossHP : Int
    var bossDamage : Int
    var playerArmour : Int
    
    var hardMode : Bool = false
}


func applyEffects(newGame : inout GameState)  {

    for (spell, duration) in newGame.spellDurationsRemaining {
        switch ( spell ) {
        case .POISON:
            newGame.bossHP -= 3
        case .SHIELD:
            newGame.playerArmour = 7
        case .RECHARGE:
            newGame.playerMana += 101
        default :
            break
        }
        if duration == 1 {
            newGame.spellDurationsRemaining.removeValue(forKey: spell)
        } else {
            newGame.spellDurationsRemaining[spell]! -= 1
        }
    }
}

func oneRound(casting : Spell, game : GameState) -> GameState {
    print(game.playerMana)
    var currentGame = game
    currentGame.playerArmour = 0
    
    if game.hardMode {
        currentGame.playerHP -= 1
        
        if currentGame.playerHP <= 0 {
            return currentGame
        }
    }
    //Player Turn
    
    applyEffects(newGame: &currentGame)
    
    if currentGame.playerHP <= 0 {
        return currentGame
        
    }
    
    if currentGame.bossHP <= 0 {
        // Boss Dead
        return currentGame
    }
    
    currentGame.playerMana -= spellCost[casting]!
    
    switch casting {
    case .MAGIC_MISSILE:
        currentGame.bossHP -= 4
    case .DRAIN:
        currentGame.bossHP -= 2
        currentGame.playerHP += 2
    case .SHIELD:
        currentGame.spellDurationsRemaining[.SHIELD] = 6
    case .POISON:
        currentGame.spellDurationsRemaining[.POISON] = 6
    case .RECHARGE:
        currentGame.spellDurationsRemaining[.RECHARGE] = 5
    }
    
    
    if currentGame.bossHP <= 0 {
        // Boss Dead
        return currentGame
    }
    
    currentGame.playerArmour = 0
    applyEffects(newGame: &currentGame)
    
    //Boss Turn
    
    if currentGame.bossHP <= 0 {
        // Boss Dead
        return currentGame
    }
    
    currentGame.playerHP -= (currentGame.bossDamage - currentGame.playerArmour)
    
    if game.playerHP <= 0 {
        //player dead
        return currentGame
    }
    
    
    return currentGame
}



class Day22 {
    
    func part1facilitator(startGame : GameState, maxMana :  Int) -> Int {
        
        var manaUsage : [Spell : Int] = [:]
        var newMax = maxMana
        
        for spell in Spell.allCases.filter({ !((startGame.spellDurationsRemaining[$0] ?? 0) > 1)}) {
            if spellCost[spell]! > startGame.playerMana && spellCost[spell]! >= newMax {
                continue
            }
            let newGameState = oneRound(casting: spell, game: startGame)
            
            if newGameState.bossHP <= 0 {
                manaUsage[spell] = spellCost[spell]
            } else if newGameState.playerHP > 0 {
                let lowestMana = part1facilitator(startGame: newGameState, maxMana: newMax - spellCost[spell]!)
                
                if lowestMana <= newMax {
                    newMax = lowestMana
                }
                
                manaUsage[spell] = spellCost[spell]! + lowestMana
            }
        }
        
        if manaUsage.count == 0 {
            return 999999
        }
        
        let bestSpellToUse = manaUsage.min(by: {$0.value < $1.value})
        
        print(manaUsage)
        return bestSpellToUse!.value
    }
    
    func part1() {
        print(part1facilitator(startGame: GameState(
                            spellDurationsRemaining:[:],
                            playerHP: 50, playerMana: 500,
                            bossHP: 71, bossDamage: 10,
                            playerArmour: 0), maxMana: Int.max))
    }
    
    func part2() {
        print(part1facilitator(startGame: GameState(
                            spellDurationsRemaining:[:],
                            playerHP: 50, playerMana: 500,
                            bossHP: 71, bossDamage: 10,
                            playerArmour: 0, hardMode: true), maxMana: Int.max))
    }
}


