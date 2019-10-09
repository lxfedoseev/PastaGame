//
//  Utils.swift
//  PastaGame
//
//  Created by Alex Fedoseev on 02/10/2019.
//  Copyright © 2019 Alex Fedoseev. All rights reserved.
//

import Foundation
import CoreGraphics

let π = CGFloat.pi

func generateRandomArray<T>(from theArray: [T], count: Int) -> [T]? {

    if theArray.count < count || count < 1 {
        return nil
    }

    var rndArray = [T]()
    var indexArray = [Int]()

    for i in 0...theArray.count-1 {
        indexArray.append(i)
    }

    for _ in 0...count-1 {
        let index = Int.random(in: 0...indexArray.count-1)
        rndArray.append(theArray[indexArray[index]])
        indexArray.remove(at: index)
    }

    return rndArray
}
