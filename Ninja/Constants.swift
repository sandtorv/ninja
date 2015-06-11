//
//  Constants.swift
//  Ninja
//
//  Created by Sebastian Sandtorv  on 11/06/15.
//  Copyright (c) 2015 Sebastian Sandtorv . All rights reserved.
//

import Foundation
import UIKit

let groundHeight: CGFloat = 10.0
let moveXSpeed: CGFloat = 320.0
var ninjaPositionY: CGFloat!

// Collision Detection
let ninjaCategory: UInt32 = 0x1 << 0
let wallCategory: UInt32 = 0x1 << 1
