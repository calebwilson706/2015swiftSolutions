//
//  day3.swift
//  2015swiftSolutions
//
//  Created by Caleb Wilson on 17/02/2021.
//

import Foundation




class Day3 {
    var str = ""
    var inputAsArray : [Character]
    init() {
        let filePath = "/Users/calebjw/Documents/AdventOfCode/2015/inputs/Day3Input.txt"
        do {
            let contents = try String(contentsOfFile: filePath)
            self.str = contents
            inputAsArray = [Character](str)
        } catch {
            print(error)
            inputAsArray = []
        }
        
    }
    
    func part1() {
        var destinations : [Point : Int] = [:]
        var total = 1
        
        destinations[Point(x: 0,y: 0)] = 1
        var currentPoint = Point(x: 0,y: 0)
        
        str.forEach { it in
            
            currentPoint = nextPoint(instruction: it, currentPoint: currentPoint)
            if (destinations[currentPoint] != nil){
                destinations[currentPoint] = destinations[currentPoint]! + 1
            } else {
                total += 1
                destinations[currentPoint] = 1
            }
        }
        
        print(total)
    }
    
    func part2() {
        
        var destinations : [Point : Bool] = [:]
        var total = 1
        
        var currentSantaPoint = Point(x : 0, y: 0)
        var currentRoboSantaPoint = Point(x : 0, y: 0)
        
        destinations[currentSantaPoint] = true
        
        var index = 0
        
        func updateMapValues(point : Point){
            if destinations[point] == nil {
                total += 1
                destinations[point] = true
            }
        }
        
        while ((index + 1) < str.count) {
            
            let santaInstruction = inputAsArray[index]
            let roboInstruction = inputAsArray[index + 1]
            
            
            currentSantaPoint = nextPoint(instruction: santaInstruction, currentPoint: currentSantaPoint)
            currentRoboSantaPoint = nextPoint(instruction: roboInstruction, currentPoint: currentRoboSantaPoint)
            
            
            updateMapValues(point: currentSantaPoint)
            updateMapValues(point: currentRoboSantaPoint)
            
            
            index += 2
        }
        
        print(total)
    }
    
    private func nextPoint(instruction : Character, currentPoint : Point) -> Point {
        switch instruction {
        case "^":
            return currentPoint.up()
        case "<":
            return currentPoint.left()
        case ">":
            return currentPoint.right()
        default :
            return currentPoint.down()
        }
    }
    
    
}
