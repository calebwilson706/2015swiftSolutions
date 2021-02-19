//
//  main.swift
//  2015swiftSolutions
//
//  Created by Caleb Wilson on 17/02/2021.
//

import Foundation

print("Hello, World!")

var currentDay = Day5()
timeTest(call: currentDay.part1, num: 1, factor: 1000.0)
timeTest(call: currentDay.part1Optomized, num: 1, factor: 1000.0)
timeTest(call: currentDay.part2, num: 1, factor: 1000.0)
timeTest(call: currentDay.part2optomized, num: 2, factor: 1000.0)
