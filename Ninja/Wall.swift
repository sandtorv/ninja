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
    let wallWidth: CGFloat = 5.0
    let wallHeight: CGFloat = 20.0
    var wallColor = UIColor.blackColor()
    
    init(){
        var randomWallHeight: CGFloat = wallHeight + CGFloat(arc4random_uniform(70))
        var randomWallWidth: CGFloat = wallWidth + CGFloat(arc4random_uniform(80))
        let size = CGSizeMake(randomWallWidth,randomWallHeight)
        super.init(texture: nil, color: wallColor, size: size)
        color = randomColor()
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
    
    // Generates a random color
    func randomColor() -> UIColor{
        var red:CGFloat = CGFloat(drand48())
        var green:CGFloat = CGFloat(drand48())
        var blue:CGFloat = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}