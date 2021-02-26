//
//  day17.swift
//  2015swiftSolutions
//
//  Created by Caleb Wilson on 26/02/2021.
//

import Foundation

class Day15 {
    var containerSizes = [11,30,47,31,32,36,3,1,5,3,32,36,15,11,46,26,28,1,19,3]
    
    func part1() {
        solution(part: 1)
    }
    func part2() {
        solution(part: 2)
    }
    func solution(part : Int){
        var combos : [[Int]] = []
        func containsSubsetSum(inputArr : [Int], n : Int, sum : Int, curr : [Int]) {
            
            if sum == 0 {
                combos.append(curr)
                return
            }
            
            if (sum < 0 || n < 0){
                return
            }
            
            containsSubsetSum(inputArr: inputArr, n: n - 1, sum: sum, curr: curr)
            
            var working = curr
            working.append(inputArr[n])
            containsSubsetSum(inputArr: inputArr, n: n - 1, sum: sum - inputArr[n], curr: working)
            
        }
        
        containsSubsetSum(inputArr: containerSizes, n: 19, sum: 150, curr: [])
        
        
        if part == 1 {
            print(combos.count)
        } else {
            let minimumAmount = combos.min(by: {$0.count < $1.count})!.count
            let valid = combos.filter {$0.count == minimumAmount}
            print(valid.count)
        }
    }
}
