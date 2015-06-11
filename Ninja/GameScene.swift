//
//  GameScene.swift
//  Ninja
//
//  Created by Sebastian Sandtorv  on 11/06/15.
//  Copyright (c) 2015 Sebastian Sandtorv . All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var ninja: Ninja!
    var ground: Ground!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        addGround()
        addNinja()
        start()
        backgroundColor = UIColor.whiteColor()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            ninja.jump()
        }
    }
    
    func start(){
        ground.start()
        ninja.startRunning()
    }
    
    func addNinja() {
        ninja = Ninja()
        ninjaPositionY = ground.position.y + ground.frame.size.height/2 + ninja.frame.size.height/2
        ninja.position = CGPointMake(70, ninjaPositionY)
        addChild(ninja)
        ninja.breathe()
    }
    
    func addGround(){
        ground = Ground(size: CGSizeMake(view!.frame.width, groundHeight))
        ground.position = CGPointMake(0, view!.frame.size.height/2)
        addChild(ground)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
