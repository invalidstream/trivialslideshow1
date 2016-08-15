//
//  Collection+TrivialSlideshow.swift
//  TrivialSlideshow1
//
//  Created by Chris Adamson on 8/14/16.
//  Copyright © 2016 Subsequently & Furthermore, Inc. All rights reserved.
//

import Foundation


// from http://stackoverflow.com/questions/24026510/how-do-i-shuffle-an-array-in-swift#24029847
extension Collection {
    /// Return a copy of `self` with its elements shuffled
    func shuffled() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollection where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        // TODO: type conversions here are fugly. pls do better
        let last = count - 1 as! Int
        for i in 0..<last {
            let target = count.advanced(by: -1 *  i) as! Int
            let j = Int(arc4random_uniform(UInt32(target))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}
