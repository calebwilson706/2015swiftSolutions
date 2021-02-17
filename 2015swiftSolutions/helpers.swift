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
