//
//  Ground.swift
//  Ninja
//
//  Created by Sebastian Sandtorv  on 11/06/15.
//  Copyright (c) 2015 Sebastian Sandtorv . All rights reserved.
//

import Foundation
import SpriteKit

class Ground: SKSpriteNode{
    let numberOfPieces = 4
    let colorOne = UIColor.lightGrayColor()
    let colorTwo = UIColor.grayColor()
    
    init(size: CGSize){
        super.init(texture: nil, color: UIColor.brownColor(), size: CGSizeMake(size.width*2,size.height))
        anchorPoint = CGPointMake(0, 0.5)
        
        for var i = 0; i < numberOfPieces; i++ {
            var segmentColor: UIColor!
            if i % 2 == 0 {
                segmentColor = colorOne
            } else {
                segmentColor = colorTwo
            }
            let segment = SKSpriteNode(color: segmentColor, size: CGSizeMake(self.size.width / CGFloat(numberOfPieces), self.size.height))
            segment.anchorPoint = CGPointMake(0.0, 0.5)
            segment.position = CGPointMake(CGFloat(i)*segment.size.width, 0)
            addChild(segment)
        }
    }
    func start(){
        let adjustDuration = NSTimeInterval(frame.size.width/moveXSpeed)
        let moveLeft = SKAction.moveByX(-frame.size.width/2, y: 0, duration: adjustDuration/2)
        let resetPosition = SKAction.moveToX(0, duration: 0)
        let moveSequence = SKAction.sequence([moveLeft, resetPosition])
        runAction(SKAction.repeatActionForever(moveSequence))
    }
    func stop(){
        removeAllActions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}