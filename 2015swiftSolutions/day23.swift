//
//  day23.swift
//  2015swiftSolutions
//
//  Created by Caleb Wilson on 03/03/2021.
//

import Foundation

enum InstructionSet {
    case hlf, tpl, inc, jmp, jie , jio
}

struct Instruction : Hashable {
    var instruction : InstructionSet
    var register : String?
    var number : Int? = nil
}


class Day23 {
    var instructions = [Instruction]()
    
    init() {
        let filePath = "/Users/calebjw/Documents/AdventOfCode/2015/inputs/Day23Input.txt"
        do {
            let contents = try String(contentsOfFile: filePath)
            let lines = contents.components(separatedBy: "\n")
            
            lines.forEach { it in
                var tempInstruction : InstructionSet = .hlf
                
                let individualComponents = it.components(separatedBy: " ")
                
                switch individualComponents[0] {
                    case "tpl":
                        tempInstruction = .tpl
                    case "inc":
                        tempInstruction = .inc
                    case "jmp":
                        tempInstruction = .jmp
                    case "jie":
                        tempInstruction = .jie
                    case "jio":
                        tempInstruction = .jio
                    default :
                        tempInstruction = .hlf
                }
                
                switch tempInstruction {
                case .hlf,.inc,.tpl :
                    self.instructions.append(Instruction(
                                    instruction: tempInstruction,
                                    register: individualComponents[1])
                    )
                case .jmp :
                    let numTotalString = individualComponents[1]
                    let sign = numTotalString[0]
                    let value = Int(numTotalString.filter { $0.isNumber })!
                    self.instructions.append(Instruction(
                                    instruction: tempInstruction,
                                    register: nil,
                                    number: (
                                        value * (sign == "-" ? -1 : 1)
                                    ))
                    )
                
                case .jie,.jio :
                    var location = individualComponents[1]
                    location = String(location.dropLast())
                    
                    let numTotalString = individualComponents[2]
                    let sign = numTotalString[0]
                    let value = Int(numTotalString.filter { $0.isNumber })!
                    
                    self.instructions.append(Instruction(
                                    instruction: tempInstruction,
                                    register: location,
                                    number: (
                                            value * (sign == "-" ? -1 : 1)
                                    ))
                    )
                }
            }
            
            
            
        } catch {
            print(error)
        }
    }
    
    
    func solution(a value : Double) {
        var index = 0
        var answers = ["a" : value, "b" : 0.0]
        
        while (index >= 0 && index < instructions.count) {
            let it = instructions[index]
            
            switch it.instruction {
            case .hlf:
                answers[it.register!]! /= 2
                index += 1
            case .tpl:
                answers[it.register!]! *= 3
                index += 1
            case .inc:
                answers[it.register!]! += 1
                index += 1
            case .jmp:
                index += it.number!
            case .jie:
                index += (answers[it.register!]!.truncatingRemainder(dividingBy: 2) == 0) ? it.number! : 1
            case .jio:
                index += (answers[it.register!]! == 1) ? it.number! : 1
            }
            //print(index)
        }
        
        print(answers)
    }
    
    func part1() {
        solution(a: 0.0)
    }
    func part2() {
        solution(a: 1.0)
    }
    
}


