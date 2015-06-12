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
    
    var scoreHolder: Int = 0
    var highscoreHolder: Int = 0
    var totalJumpsHolder: Int = 0
    
    var isStarted = false
    var isGameOver = false
    var isJumping = false
    var isDoubleJump = false
    
    let NSdefaults = NSUserDefaults.standardUserDefaults()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        addGround()
        addNinja()
        addWallGenerator()
        addPhysicsWorld()
        addLabels()
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
                if !isJumping{
                    ninja.jump()
                } else if (isJumping && !isDoubleJump){
                    isDoubleJump = true
                    ninja.jump()
                }
            }
        }
    }
    
    func start(){
        scoreHolder = 0
        isStarted = true
        isGameOver = false
        ground.start()
        ninja.startRunning()
        wallGenerator.startGeneratingWalls(0.8)
    }
    
    func gameOver(){
        isGameOver = true
        saveScore()
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
        ninjaPositionY = ground.position.y + ground.frame.size.height/2 + ninja.frame.size.height/2 - 2
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
    
    func addLabels(){
        // Add score label
        let scoreLabel = ScoreLabel(num:0)
        scoreLabel.position = CGPointMake(20, view!.frame.size.height - 35)
        scoreLabel.name = "scoreLabel"
        addChild(scoreLabel)
        
        let highscoreLabel = ScoreLabel(num: 0)
        highscoreLabel.name = "highscoreLabel"
        highscoreLabel.position = CGPointMake(view!.frame.size.width - (20 + highscoreLabel.frame.size.width), view!.frame.size.height - 35)
        addChild(highscoreLabel)
        
        let highscoreTextLabel = SKLabelNode(text: "Max")
        highscoreTextLabel.fontColor = UIColor.blackColor()
        highscoreTextLabel.fontSize = 14.0
        highscoreTextLabel.fontName = "GillSans"
        highscoreTextLabel.position = CGPointMake(0, -20)
        highscoreLabel.addChild(highscoreTextLabel)
        // Set highscore
        let highscoreLabelNode = childNodeWithName("highscoreLabel") as! ScoreLabel
        highscoreLabelNode.setTo(NSdefaults.integerForKey("highscore"))
    }
    
    func loadScore(){
        highscoreHolder = NSdefaults.integerForKey("highscore")
        totalJumpsHolder = NSdefaults.integerForKey("totalJumps")
    }
    
    func saveScore(){
        loadScore()
        NSdefaults.setInteger(totalJumpsHolder+scoreHolder, forKey: "totalJumps")
        if (debugActive){
            println("scoreholder: \(scoreHolder) highscore: \(highscoreHolder) and total jumps: \(totalJumpsHolder)")
        }
        if(scoreHolder >= highscoreHolder){
            NSdefaults.setInteger(scoreHolder, forKey: "highscore")
        }
        NSdefaults.synchronize()
    }
    
    // MARK: - SKPhysicsContactDelegate
    func didBeginContact(contact: SKPhysicsContact) {
        var x: CGFloat = contact.contactNormal.dx
        var y: CGFloat = contact.contactNormal.dy
        if !isGameOver {
            gameOver()
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
                let scoreLabel = childNodeWithName("scoreLabel") as! ScoreLabel
                scoreLabel.increment()
                scoreLabel.runAction(zoomAnimation())
                wallGenerator.wallTrackers.removeAtIndex(0)
                scoreHolder = scoreHolder + 1
            }
        }
        if(ninja.body.position.y < 3){
            isJumping = false
            isDoubleJump = false
        } else {
            isJumping = true
        }
    }
    
    func zoomAnimation() -> SKAction {
        let duration = 0.1
        let zoomIn = SKAction.scaleBy(1.25, duration: duration)
        let zoomOut = SKAction.scaleBy(0.8, duration: duration)
        let zoom = SKAction.sequence([zoomIn, zoomOut])
        return SKAction.repeatAction(zoom, count: 1)
    }

}
