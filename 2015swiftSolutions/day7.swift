//
//  day7.swift
//  2015swiftSolutions
//
//  Created by Caleb Wilson on 21/02/2021.
//

import Foundation


enum OPERATIONS {
    case RSHIFT, LSHIFT, AND, OR, NOT, NONE
}

struct FullInstruction {
    let operation : OPERATIONS
    let targetLocation : String
    let firstLocation : String?
    let secondLocation : String?
    let value : Int?
    
    func quickBio() {
        print("\(operation) " + targetLocation + ",\(firstLocation ?? "nil")" + ",\(secondLocation ?? "nil")" + " number :\(value ?? 0)")
    }
    
}
class Day7 {
    var myItems = [FullInstruction]()
    
    init() {
        let filePath = "/Users/calebjw/Documents/AdventOfCode/2015/inputs/Day7Input.txt"
        
        do {
            
            let contents = try String(contentsOfFile: filePath)
            let rows = contents.components(separatedBy: "\n")
            
            rows.forEach { it in
                let uppercaseOnly = it.filter { $0.isUppercase }
                let tempOperation : OPERATIONS

                switch uppercaseOnly {
                case "RSHIFT":
                    tempOperation = .RSHIFT
                case "LSHIFT":
                    tempOperation = .LSHIFT
                case "AND":
                    tempOperation = .AND
                case "OR":
                    tempOperation = .OR
                case "NOT":
                    tempOperation = .NOT
                default :
                    tempOperation = .NONE
                }
                
                let allLocations = it.filter { $0.isLowercase || $0.isWhitespace }.components(separatedBy: .whitespaces).filter { $0 != ""}
                var location1 : String? = nil
                var location2 : String? = nil
                let finalLocation : String = allLocations.last!
               
                let number = Int(it.filter { $0.isNumber })
                
                switch allLocations.count {
                case 1:
                    print("")
                case 2:
                    location1 = allLocations.first!
                case 3:
                    location1 = allLocations.first!
                    location2 = allLocations[1]
                default:
                    print("error")
                }
                
                myItems.append(FullInstruction(operation: tempOperation, targetLocation: finalLocation, firstLocation: location1, secondLocation: location2, value: number))
            }
            
        } catch {
            print(error)
        }
        
    }
    func part1() {
        print(generalSolution(startResults: [:]))
    }
    func generalSolution(startResults : [String : Int]) -> Int {
        var results = startResults
        
        func calculate(for location : String) -> Int {
            let necessaryInstruction = myItems.first { $0.targetLocation == location }!
            
            if necessaryInstruction.firstLocation != nil {
                if results[necessaryInstruction.firstLocation!] == nil {
                    results[necessaryInstruction.firstLocation!] = calculate(for: necessaryInstruction.firstLocation!)
                }
            }
            if necessaryInstruction.secondLocation != nil {
                if results[necessaryInstruction.secondLocation!] == nil {
                    results[necessaryInstruction.secondLocation!] = calculate(for: necessaryInstruction.secondLocation!)
                }
            }
            //print(necessaryInstruction)
            
            switch necessaryInstruction.operation {
            case .RSHIFT:
                let temp = UInt16(results[necessaryInstruction.firstLocation!]!)
                return Int(temp >> necessaryInstruction.value!)
            case .LSHIFT:
                let temp = UInt16(results[necessaryInstruction.firstLocation!]!)
                return Int(temp << necessaryInstruction.value!)
            case .NONE:
                return ((necessaryInstruction.firstLocation == nil) ? necessaryInstruction.value! : results[necessaryInstruction.firstLocation!]!)
            case .AND:
                let first = UInt16( necessaryInstruction.firstLocation == nil ? necessaryInstruction.value! : results[necessaryInstruction.firstLocation!]!)
                let second = UInt16( necessaryInstruction.secondLocation == nil ? necessaryInstruction.value! : results[necessaryInstruction.secondLocation!]!)
                return Int(first & second)
            case .OR:
                let first = UInt16(results[necessaryInstruction.firstLocation!]!)
                let second = UInt16(results[necessaryInstruction.secondLocation!]!)
                return Int(first | second)
                
            case .NOT:
                let tempVal = UInt16(results[necessaryInstruction.firstLocation!]!)
                return Int(~tempVal)
            }
        }
        
        let res = calculate(for: "a")
        return res
    }
    
    func part2(){
        print(generalSolution(startResults: ["b" : 3176]))
    }
    
    
}

