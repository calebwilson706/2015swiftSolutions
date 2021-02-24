//
//  day12.swift
//  2015swiftSolutions
//
//  Created by Caleb Wilson on 24/02/2021.
//

import Foundation


class Day12 {
    let inputAsString : String
    
    init() {
        let filePath = "/Users/calebjw/Documents/AdventOfCode/2015/inputs/Day12Input.txt"
        do {
            var contents = try String(contentsOfFile: filePath)
            contents = String(contents.dropFirst())
            contents = String(contents.dropLast())
            contents.removeAll { $0 == "\""}
            self.inputAsString = contents
            //print(self.inputAsString)
        } catch {
            print(error)
            self.inputAsString = ""
        }
    
    }
    
    func part1() {
        solution(str: inputAsString)
    }
    
    func solution(str : String){
        var components = str.components(separatedBy: ",")
        components = components.map {$0.filter {$0.isNumber || $0 == "-"}}
        components = components.filter {$0 != ""}
        
        let total = components.reduce(0, { acc, new in
            acc + (Int(new) ?? -Int(new.dropFirst())!)
        })
        
        print(total)
    }
    func part2() {
        var charList = [Character](inputAsString)
        var index = 1
        var rangesToRemove : [Range<Int>] = []
        
        while index < charList.count - 1 {
            if charList[index] == "e" {
                if charList[index - 1] == "r" {
                    if charList[index + 1] == "d" {
                        var minimum : Int? = nil
                        var maximum : Int? = nil
                        
                        var tempIndexLower = index
                        var tempIndexMax = index
                        
                        var countCurly = 0
                        var countSquare = 0
                        
                        while true {
                            if charList[tempIndexLower] == "{" {
                                if countCurly == 0 {
                                    minimum = tempIndexLower
                                    break
                                } else {
                                    countCurly -= 1
                                }
                            }
                            
                            if charList[tempIndexLower] == "}" {
                                countCurly += 1
                            }
                            
                            if charList[tempIndexLower] == "[" {
                                if countSquare == 0 {
                                    break
                                } else {
                                    countSquare -= 1
                                }
                            }
                            
                            if charList[tempIndexLower] == "]" {
                                countSquare += 1
                            }
                            
                            tempIndexLower -= 1
                        }
                        
                        if minimum != nil {
                            
                            countSquare = 0
                            countCurly = 0
                            
                            while true {
                                if charList[tempIndexMax] == "}" {
                                    if countCurly == 0 {
                                        maximum = tempIndexMax
                                        break
                                    } else {
                                        countCurly -= 1
                                    }
                                }
                                
                                if charList[tempIndexMax] == "{" {
                                    countCurly += 1
                                }
                                
                                if charList[tempIndexMax] == "]" {
                                    if countSquare == 0 {
                                        break
                                    } else {
                                        countSquare -= 1
                                    }
                                }
                                
                                if charList[tempIndexMax] == "[" {
                                    countSquare += 1
                                }
                                
                                tempIndexMax += 1
                            }
                        }
                        
                        if (minimum != maximum) {
                            rangesToRemove.append((minimum! - 1)..<(maximum! + 1))
                        }
                    }
                }
            }
            
            index += 1
        }
        
        for item in rangesToRemove {
            item.forEach { index in
                charList[index] = "§"
            }
        }
        
       // print(String(charList))
        solution(str : String(charList))
    }
}

//less than 89085
//less than 75819

//above 59128
