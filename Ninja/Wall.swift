//
//  Wall.swift
//  Ninja
//
//  Created by Sebastian Sandtorv  on 11/06/15.
//  Copyright (c) 2015 Sebastian Sandtorv . All rights reserved.
//

import Foundation
import SpriteKit

class Wall: SKSpriteNode{
    let wallWidth: CGFloat = 20.0
    let wallHeight: CGFloat = 30.0
    let wallColor = UIColor.blackColor()
    
    init(){
        let size = CGSizeMake(wallWidth, wallHeight)
        super.init(texture: nil, color: wallColor, size: size)
        println("Size is: \(size)")
        loadPhysicsBody(size)
        startMoving()
    }
    
    func loadPhysicsBody(size: CGSize){
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody?.categoryBitMask = wallCategory
        physicsBody?.affectedByGravity = false
    }
    
    func startMoving(){
        let moveLeft = SKAction.moveByX(-moveXSpeed, y: 0, duration: 1)
        runAction(SKAction.repeatActionForever(moveLeft))
    }
    
    func stopMoving(){
        removeAllActions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}