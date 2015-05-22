//
//  Cloud.swift
//  Ninja
//
//  Created by Sebastian Sandtorv  on 19/05/15.
//  Copyright (c) 2015 Sebastian Sandtorv . All rights reserved.
//

import Foundation
import SpriteKit

class Cloud: SKShapeNode {
    
    init(size: CGSize) {
        super.init()
        let path = CGPathCreateWithEllipseInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height), nil)
        self.path = path
        fillColor = UIColor.whiteColor()
        
        startMoving()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startMoving() {
        let randomSpeed = randomBetweenNumbers(-25, -40)
        let moveLeft = SKAction.moveByX(randomSpeed, y: 0, duration: 1)
        runAction(SKAction.repeatActionForever(moveLeft))
    }
    
    
}

func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
    return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
}

