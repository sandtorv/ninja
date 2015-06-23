//
//  Constants.swift
//  Ninja
//
//  Created by Sebastian Sandtorv  on 11/06/15.
//  Copyright (c) 2015 Sebastian Sandtorv . All rights reserved.
//

import Foundation
import UIKit

// Activate if debug mode
let debugActive: Bool = false

let groundHeight: CGFloat = 10.0
let moveXSpeed: CGFloat = 320.0
var ninjaPositionY: CGFloat!

// Collision Detection
let ninjaCategory: UInt32 = 0x1 << 0
let wallCategory: UInt32 = 0x1 << 1

// MARK: Delay Helper
func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}