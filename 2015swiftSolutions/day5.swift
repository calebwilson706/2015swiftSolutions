//
//  day5.swift
//  2015swiftSolutions
//
//  Created by Caleb Wilson on 19/02/2021.
//

import Foundation


class Day5 {
    private var input = [String]()
    private let vowels = [Character]("aeiou")
    private let forbidden = ["ab","cd","pq","xy"]
    
    init(){
        let filePath = "/Users/calebjw/Documents/AdventOfCode/2015/inputs/Day5Input.txt"
        do {
            let contents = try String(contentsOfFile: filePath)
            self.input = contents.components(separatedBy: "\n")
            //print(input)
        } catch {
            print(error)
        }
    }
    
    private func bothPartsHelper(condition : (String) -> Bool ) {
        print(
            input.reduce(0, { acc, next in
                acc + (condition(next) ? 1 : 0 )
            })
        )
    }
    func part1() {
        bothPartsHelper(condition: rules1Combined)
    }
    func part1Optomized() {
        bothPartsHelper(condition: rules1Combined_optomized)
    }
    func part2() {
        bothPartsHelper(condition: part2RulesCombined)
    }
    func part2optomized() {
        bothPartsHelper(condition: part2rulesCombined_optomized)
    }
    private func rules1Combined(str : String) -> Bool {
        return self.vowelChecker(str: str) && !self.containsForbidden(str: str) && str.doesContainDoubleLetter()
    }
    
    private func rules1Combined_optomized(str : String) -> Bool {
        if containsForbidden(str: str){
           return false
        }
        if !str.doesContainDoubleLetter() {
            return false
        }
        
        return vowelChecker(str: str)
    }
    private func vowelChecker(str : String) -> Bool {
        let characters = [Character](str)
        var index = 0
        var total = 0
        
        while ((index < characters.count) && (total < 3)){
            if (vowels.contains(characters[index])){
                total += 1
            }
            index += 1
        }
        
        return (total >= 3)
    }
    
    private func containsForbidden(str : String) -> Bool {
        for item in forbidden {
            if str.contains(item) {
                return true
            }
        }
        
        return false
    }
    private func part2rule1(str : String) -> Bool {
        var indexAtBase = 0
        let chars = [Character](str)
        
        while (indexAtBase < str.count - 1) {
            let tempFinding = "\(chars[indexAtBase])\(chars[indexAtBase + 1])"
            
            if (str.dropFirst(indexAtBase + 2).contains(tempFinding)){
                return true
            }
            
            indexAtBase += 1
        }
        
        return false
    }
    private func part2rule1Optomized(str : String) -> Bool {
        var indexAtBase = 0
        let chars = [Character](str)
        var currentToEvaluate = str.dropFirst()
        
        while (indexAtBase < str.count - 1) {
            let tempFinding = "\(chars[indexAtBase])\(chars[indexAtBase + 1])"
            currentToEvaluate = currentToEvaluate.dropFirst()
            
            if (currentToEvaluate.contains(tempFinding)){
                return true
            }
            
            indexAtBase += 1
        }
        
        return false
    }
    private func part2rule2(str : String) -> Bool {
        let chars = [Character](str)
        
        for index in 0..<(chars.count - 2) {
            if (chars[index] == chars[index + 2]){
                return true
            }
        }
        
        return false
    }
    
    private func part2RulesCombined(str : String) -> Bool {
        return (part2rule1(str: str) && part2rule2(str: str))
    }
    
    private func part2rulesCombined_optomized(str : String) -> Bool {
        if !(part2rule1Optomized(str: str)){
            return false
        }
        
        return part2rule2(str: str)
    }
    
}

