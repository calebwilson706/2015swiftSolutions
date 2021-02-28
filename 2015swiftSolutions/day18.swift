//
//  day18.swift
//  2015swiftSolutions
//
//  Created by Caleb Wilson on 28/02/2021.
//

import Foundation



class Day18 {
    let startingGrid : [Point : Character]
    
    init() {
        let filePath = "/Users/calebjw/Documents/AdventOfCode/2015/inputs/Day18Input.txt"
        do {
            var endGrid : [Point : Character] = [:]
            let contents = try String(contentsOfFile: filePath)
            let inputLines = contents.components(separatedBy: "\n")
            
            var y = 0
            
            inputLines.forEach { line in
                var x = 0
                line.forEach { point in
                    endGrid[Point(x: x, y: y)] = point
                    x += 1
                }
                y += 1
            }
            startingGrid = endGrid
            //print(startingGrid.keys.count)
        } catch {
            print(error)
            startingGrid = [:]
        }
    }
    
    func part1() {
        
        var myWorkingMap = startingGrid
        
        for _ in 0..<100 {
            var newMap : [Point : Character] = [:]
            
            for x in 0...99 {
                for y in 0...99 {
                    let p = Point(x: x, y: y)
                    newMap[p] = newValue(p: p, myWorkingMap: myWorkingMap)
                }
            }
            
            myWorkingMap = newMap
        }
        
        print(myWorkingMap.values.reduce(0, { acc, next in
            acc + (next == "#" ? 1 : 0)
        }))
    }
    
    func newValue(p : Point, myWorkingMap : [Point : Character]) -> Character {
        var amountOfOnNeighbours = 0
        
        if myWorkingMap[p.up()] == "#" {
            amountOfOnNeighbours += 1
        }
        if myWorkingMap[p.upRight()] == "#" {
            amountOfOnNeighbours += 1
        }
        if myWorkingMap[p.right()] == "#" {
            amountOfOnNeighbours += 1
        }
        if myWorkingMap[p.downRight()] == "#" {
            amountOfOnNeighbours += 1
        }
        if myWorkingMap[p.down()] == "#" {
            amountOfOnNeighbours += 1
        }
        if myWorkingMap[p.downLeft()] == "#" {
            amountOfOnNeighbours += 1
        }
        if myWorkingMap[p.left()] == "#" {
            amountOfOnNeighbours += 1
        }
        if myWorkingMap[p.upLeft()] == "#" {
            amountOfOnNeighbours += 1
        }
        
        return (((myWorkingMap[p] == "#" && (amountOfOnNeighbours == 2 || amountOfOnNeighbours == 3)))
            || (myWorkingMap[p] != "#" && amountOfOnNeighbours == 3) ? "#" : ".")
    }
    
    func part2() {
        var myWorkingMap = startingGrid
        
        myWorkingMap[Point(x: 0, y: 0)] = "#"
        myWorkingMap[Point(x: 99, y: 0)] = "#"
        myWorkingMap[Point(x: 99, y: 99)] = "#"
        myWorkingMap[Point(x: 0, y: 99)] = "#"
        
        for _ in 0..<100 {
            var newMap : [Point : Character] = [:]
            
            for x in 0...99 {
                for y in 0...99 {
                    let p = Point(x: x, y: y)
                    newMap[p] = newValue(p: p, myWorkingMap: myWorkingMap)
                }
            }
            newMap[Point(x: 0, y: 0)] = "#"
            newMap[Point(x: 99, y: 99)] = "#"
            newMap[Point(x: 99, y: 0)] = "#"
            newMap[Point(x: 0, y: 99)] = "#"
            
            myWorkingMap = newMap
            
        }
        
        print(myWorkingMap.values.reduce(0, { acc, next in
            acc + (next == "#" ? 1 : 0)
        }))
    }
    
}
