//
//  ScoreLabel.swift
//  Ninja
//
//  Created by Sebastian Sandtorv  on 11/06/15.
//  Copyright (c) 2015 Sebastian Sandtorv . All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class ScoreLabel: SKLabelNode {
    
    var number = 0
    
    init(num:Int){
        super.init()
        fontColor = UIColor.blackColor()
        fontName = "GillSans"
        fontSize = 24
        
        number = num
        text = "\(num)"
    }
    
    func increment(){
        number++
        text = "\(number)"
    }
    
    func setTo(num: Int){
        number = num
        text = "\(number)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
