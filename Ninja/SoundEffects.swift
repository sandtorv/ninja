//
//  SoundEffects.swift
//  Ninja
//
//  Created by Sebastian Sandtorv  on 21/06/15.
//  Copyright (c) 2015 Sebastian Sandtorv . All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import SpriteKit

let jumpSound = SKAction.playSoundFileNamed("jump.wav", waitForCompletion: false)
let crashSound = SKAction.playSoundFileNamed("crash.wav", waitForCompletion: false)
let winSound = SKAction.playSoundFileNamed("winning.wav", waitForCompletion: false)