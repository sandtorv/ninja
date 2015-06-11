//
//  GameScene.swift
//  Ninja
//
//  Created by Sebastian Sandtorv  on 11/06/15.
//  Copyright (c) 2015 Sebastian Sandtorv . All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var ninja: Ninja!
    var ground: Ground!
    var wallGenerator: WallGenerator!
    
    var isStarted = false
    var isGameOver = false
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        addGround()
        addNinja()
        addWallGenerator()
        addPhysicsWorld()
        backgroundColor = UIColor.whiteColor()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            if isGameOver{
                restart()
            } else if !isStarted {
                start()
            } else {
                ninja.jump()
            }
        }
    }
    
    func start(){
        isStarted = true
        isGameOver = false
        ground.start()
        ninja.startRunning()
        wallGenerator.startGeneratingWalls(0.8)
    }
    
    func gameOver(){
        isGameOver = true
        ninja.fall()
        ninja.stop()
        wallGenerator.stopWalls()
        ground.stop()
    }
    
    func restart(){
        let newScene = GameScene(size: view!.bounds.size)
        newScene.scaleMode = .AspectFill
        
        view!.presentScene(newScene)
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
    
    func addWallGenerator(){
        wallGenerator = WallGenerator(color: UIColor.clearColor(), size: view!.frame.size)
        wallGenerator.position = view!.center
        addChild(wallGenerator)
    }
    
    // MARK: - SKPhysicsContactDelegate
    func didBeginContact(contact: SKPhysicsContact) {
        if !isGameOver {
            gameOver()
            println("Game over?!?")
        } else{
            println("Not game over?!?")
        }
    }
    
    func addPhysicsWorld(){
        physicsWorld.contactDelegate = self
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        if wallGenerator.wallTrackers.count > 0 {
            
            let wall = wallGenerator.wallTrackers[0] as Wall
            
            let wallLocation = wallGenerator.convertPoint(wall.position, toNode: self)
            if wallLocation.x < ninja.position.x {
                wallGenerator.wallTrackers.removeAtIndex(0)
            }
        }
        
    }
}
