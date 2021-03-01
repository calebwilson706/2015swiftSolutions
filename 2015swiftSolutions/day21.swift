//
//  day21.swift
//  2015swiftSolutions
//
//  Created by Caleb Wilson on 01/03/2021.
//

import Foundation


class Item {
    var name : String
    var cost : Int
    
    init (name : String,cost : Int){
        self.name = name
        self.cost = cost
    }
}

class Weapon : Item {
    var damage : Int
    
    init(name : String, damage : Int, cost : Int){
        self.damage = damage
        super.init(name: name,cost: cost)
    }
}

class Armor : Item {
    var protection : Int
    
    init(name : String, protection : Int, cost : Int){
        self.protection = protection
        super.init(name: name,cost : cost)
    }
}

class Ring : Item, Hashable, Equatable {
    
    static func == (lhs: Ring, rhs: Ring) -> Bool {
        lhs.name == rhs.name
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    var damage : Int
    var protection : Int
    
    init(name : String, protection : Int, damage : Int, cost : Int) {
        self.damage = damage
        self.protection = protection
        super.init(name: name, cost : cost)
    }
}


struct Setup {
    var cost : Int
    var damageTotal : Int
    var armourTotal : Int
}


//func getAllSetups() -> [Setup] {}


var weapons = [
    Weapon(name: "Dagger", damage: 4, cost : 8),
    Weapon(name: "Shortsword", damage: 5, cost : 10),
    Weapon(name: "Warhammer", damage: 6, cost : 25),
    Weapon(name: "Longsword", damage: 7, cost : 40),
    Weapon(name: "Greataxe", damage: 8, cost : 74)
]

var armours = [
    Armor(name: "None", protection: 0, cost: 0),
    Armor(name: "Leather", protection: 1, cost: 13),
    Armor(name: "Chainmail", protection: 2, cost: 31),
    Armor(name: "Splintmail", protection: 3, cost: 53),
    Armor(name: "Bandedmail", protection: 4, cost: 75),
    Armor(name: "Platemail", protection: 5, cost: 102)
    
]

var rings = [
    Ring(name: "None", protection: 0, damage: 0, cost: 0),
    Ring(name: "Damage+1", protection: 0, damage: 1, cost: 25),
    Ring(name: "Damage+2", protection: 0, damage: 2, cost: 50),
    Ring(name: "Damage+3", protection: 0, damage: 3, cost: 100),
    Ring(name: "Defense+1", protection: 1, damage: 0, cost: 20),
    Ring(name: "Defense+2", protection: 2, damage: 0, cost: 40),
    Ring(name: "Defense+3", protection: 3, damage: 0, cost: 80)
    
]

class Day21 {
    
    func part1() {
        let options = getAllSetups().sorted(by: {$0.cost < $1.cost})
        
        for s in options {
            if fightBoss(setup: s) {
                print(s.cost)
                return
            }
        }
    }
    
    func part2() {
        let options = getAllSetups().sorted(by: {$0.cost > $1.cost})
        
        for s in options {
            if !fightBoss(setup: s) {
                print(s.cost)
                return
            }
        }
    }
    
    func fightBoss(setup : Setup) -> Bool {
        var bossHealth = 103
        var playerHealth = 100
        
        while (true) {
            bossHealth -= (setup.damageTotal - 2)
            if (bossHealth <= 0) {
                return true
            }
            
            playerHealth -= (9 - setup.armourTotal)
            if (playerHealth <= 0){
                return false
            }
        }
    }
    func getListCombinations(allLists : [Ring] = rings) -> Set<[Ring]> {
        var results = [[Ring]]()
        
        for ring1 in allLists {
            for ring2 in allLists {
                if (ring1.name != ring2.name || ring1.name == "None" ) {
                    results.append([ring1,ring2].sorted { $0.name < $1.name })
                }
            }
        }
        
        return Set(results)
    }


    func getAllSetups() -> [Setup] {
        var setups = [Setup]()
        let possibleRings = getListCombinations().sorted(by: {
            ($0[0].cost + $0[1].cost) < ($1[0].cost + $1[1].cost)
        })
        
        for w in weapons {
            for a in armours {
                for rs in possibleRings {
                    setups.append(Setup(
                        cost: (w.cost + a.cost + rs[0].cost + rs[1].cost),
                        damageTotal: (w.damage + rs[0].damage + rs[1].damage),
                        armourTotal: (a.protection + rs[0].protection + rs[1].protection))
                    )
                }
            }
        }
        
        return setups
    }

}
