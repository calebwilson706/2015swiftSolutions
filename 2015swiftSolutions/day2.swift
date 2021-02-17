//
//  day2.swift
//  2015swiftSolutions
//
//  Created by Caleb Wilson on 17/02/2021.
//

import Foundation


//formula ->

// 2(lw + wh + hl) + l
func minOfThree<T>(x : T,y : T, z : T) -> T where T : Comparable {
    let firstMin = min(x, y)
    return min(firstMin, z)
}

struct Wrapper {
    var l : Int
    var w : Int
    var h : Int
    
    var sidesSorted : [Int]
    
    func getPaperSize() -> Int {
        let faceA = l*w
        let faceB = h*w
        let faceC = h*l
        
        return (2*(faceA + faceB + faceC) + minOfThree(x: faceA, y: faceB, z: faceC))
    }
    func getPaperOptomized() -> Int {
        let faceA = sidesSorted[0]*sidesSorted[1]
        let faceB = sidesSorted[1]*sidesSorted[2]
        let faceC = sidesSorted[0]*sidesSorted[2]
        
        return 2*(faceA + faceB + faceC) + faceA
    }
    private func volume() -> Int {
        return (l*w*h)
    }
    
    
    func getRibbonLength() -> Int {
        let perimA = 2*(l + w)
        let perimB = 2*(h + w)
        let perimC = 2*(h + l)
        
        return (self.volume() + minOfThree(x: perimA, y: perimB, z: perimC))
    }
    
    func getRibbonOptimized() -> Int {
        return (self.volume() + 2*(sidesSorted[0] + sidesSorted[1]))
    }
}

class Day2 {
    private var inputParsedAsWrappers = [Wrapper]()
    
    
    init() {
        let filePath = "/Users/calebjw/Documents/AdventOfCode/2015/inputs/Day2Input.txt"
        do {
            let contents = try String(contentsOfFile: filePath)
            self.inputParsedAsWrappers = self.parseString(str: contents)
        } catch {
            print(error)
        }
    }
    
    private func parseString(str : String) -> [Wrapper] {
        let components = str.components(separatedBy: "\n")
        let components_2D = components.map {$0.components(separatedBy: "x")}
        
        return components_2D.map { Wrapper(
            l: Int($0[0])!,
            w: Int($0[1])!,
            h: Int($0[2])!,
            sidesSorted: $0.map {Int($0)!}.sorted()
        )
        }
    }
    
    private func containerForParts(componentAlgo : (Wrapper) -> () -> Int){
        print (
            inputParsedAsWrappers.reduce(0, { acc, next in
                acc + componentAlgo(next)()
            })
        )
    }
    func part1() {
        containerForParts(componentAlgo: Wrapper.getPaperSize)
    }
    func part1Optomized() {
        containerForParts(componentAlgo: Wrapper.getPaperOptomized)
    }
    func part2() {
        containerForParts(componentAlgo: Wrapper.getRibbonLength)
    }
    func part2Optomized() {
        containerForParts(componentAlgo: Wrapper.getRibbonOptimized)
    }
}
