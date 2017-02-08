//
//  Utils.swift
//  ft-ios
//
//  Created by Martin on 7/2/17.
//  Copyright © 2017 Martin. All rights reserved.
//

import Foundation

class Utils {
    
    class func indexOf(string: String, inArray array: Array<String>) -> Int {
        for index in 0 ... array.count - 1 {
            if (string == array[index]) {
                return index
            }
        }
        return -1
    }
    
}
