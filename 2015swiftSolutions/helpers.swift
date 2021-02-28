//
//  helpers.swift
//  2015swiftSolutions
//
//  Created by Caleb Wilson on 17/02/2021.
//

import Foundation

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

func timeTest(call : () -> Void, num : Int, factor : Double = 1.0){
    let start = CFAbsoluteTimeGetCurrent()
    call()
    print("test \(num) : \((CFAbsoluteTimeGetCurrent() - start)*factor)")
}


extension String {
    func doesContainDoubleLetter() -> Bool {
        let chars = [Character](self)
        
        for index in 0 ..< (chars.count - 1) {
            if (chars[index] == chars[index + 1]){
                return true
            }
        }
        
        return false
    }
}

struct Point : Hashable {
    let x : Int
    let y : Int
    
    func up() -> Point {
        return Point(x: x, y: y + 1)
    }
    func down() -> Point {
        return Point(x: x, y: y - 1)
    }
    func right() -> Point {
        return Point(x: x + 1, y: y)
    }
    func left() -> Point {
        return Point(x: x - 1, y: y)
    }
    func upLeft() -> Point {
        return Point(x: x - 1, y: y + 1)
    }
    func downLeft() -> Point {
        return Point(x: x - 1, y: y - 1)
    }
    func upRight() -> Point {
        return Point(x: x + 1, y: y + 1)
    }
    func downRight() -> Point {
        return Point(x: x + 1, y: y - 1)
    }
}

