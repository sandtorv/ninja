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

var BGSound = AVAudioPlayer()
var jumpSound = AVAudioPlayer()
var crashSound = AVAudioPlayer()
var gameOverSound = AVAudioPlayer()
var newRecordSound = AVAudioPlayer()

func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer  {
    var path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
    var url = NSURL.fileURLWithPath(path!)
    var error: NSError?
    var audioPlayer:AVAudioPlayer?
    audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
    return audioPlayer!
}

func initSounds(){
    jumpSound = setupAudioPlayerWithFile("jump", "wav")
    newRecordSound = setupAudioPlayerWithFile("winning", "wav")
    crashSound = setupAudioPlayerWithFile("crash", "wav")
}