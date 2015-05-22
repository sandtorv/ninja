//
//  GameScene.swift
//  Ninja
//
//  Created by Sebastian Sandtorv  on 19/05/15.
//  Copyright (c) 2015 Sebastian Sandtorv . All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var movingGround: MovingGround!
    var hero: Hero!
    var cloudGenerator: CloudGenerator!
    var wallGenerator: WallGenerator!
    
    var isStarted = false
    var isGameOver = false
    
    override func didMoveToView(view: SKView) {
        backgroundColor = UIColor(red: 159.0/255.0, green: 201.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        
        addMovingGround()
        addHero()
        addCloudGenerator()
        addWallGenerator()
        addTapToStartLabel()
        addPointsLabels()
        addPhysicsWorld()
        loadHighscore()
        
    }
    
    func addMovingGround() {
        movingGround = MovingGround(size: CGSizeMake(view!.frame.width, kGroundHeight))
        movingGround.position = CGPointMake(0, view!.frame.size.height/2)
        addChild(movingGround)
    }
    
    func addHero() {
        hero = Hero()
        hero.position = CGPointMake(70, movingGround.position.y + movingGround.frame.size.height/2 + hero.frame.size.height/2)
        addChild(hero)
        hero.breathe()
    }
    
    func addCloudGenerator() {
        cloudGenerator = CloudGenerator(color: UIColor.clearColor(), size: view!.frame.size)
        cloudGenerator.position = view!.center
        addChild(cloudGenerator)
        cloudGenerator.populate(7)
        cloudGenerator.startGeneratingWithSpawnTime(5)
    }
    
    func addWallGenerator() {
        wallGenerator = WallGenerator(color: UIColor.clearColor(), size: view!.frame.size)
        wallGenerator.position = view!.center
        addChild(wallGenerator)
    }
    
    func addTapToStartLabel() {
        let tapToStartLabel = SKLabelNode(text: "Tap to start!")
        tapToStartLabel.name = "tapToStartLabel"
        tapToStartLabel.position.x = view!.center.x
        tapToStartLabel.position.y = view!.center.y + 40
        tapToStartLabel.fontName = "GillSans"
        tapToStartLabel.fontColor = UIColor.blackColor()
        tapToStartLabel.fontSize = 22.0
        addChild(tapToStartLabel)
        tapToStartLabel.runAction(blinkAnimation())
    }
    
    func addPointsLabels() {
        let pointsLabel = PointsLabel(num: 0)
        pointsLabel.position = CGPointMake(20.0, view!.frame.size.height - 35)
        pointsLabel.name = "pointsLabel"
        addChild(pointsLabel)
        
        let highscoreLabel = PointsLabel(num: 0)
        highscoreLabel.name = "highscoreLabel"
        highscoreLabel.position = CGPointMake(view!.frame.size.width - 20, view!.frame.size.height - 35)
        addChild(highscoreLabel)
        
        let highscoreTextLabel = SKLabelNode(text: "High")
        highscoreTextLabel.fontColor = UIColor.blackColor()
        highscoreTextLabel.fontSize = 14.0
        highscoreTextLabel.fontName = "GillSans"
        highscoreTextLabel.position = CGPointMake(0, -20)
        highscoreLabel.addChild(highscoreTextLabel)
    }
    
    func addPhysicsWorld() {
        physicsWorld.contactDelegate = self
    }
    
    func loadHighscore() {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let highscoreLabel = childNodeWithName("highscoreLabel") as! PointsLabel
        highscoreLabel.setTo(defaults.integerForKey("highscore"))
    }
    
    // MARK: - Game Lifecycle
    func start() {
        isStarted = true
        
        let tapToStartLabel = childNodeWithName("tapToStartLabel")
        tapToStartLabel?.removeFromParent()
        
        hero.stop()
        hero.startRunning()
        movingGround.start()
        
        wallGenerator.startGeneratingWallsEvery(0.8)
    }
    
    func gameOver() {
        isGameOver = true
        
        // stop everything
        hero.fall()
        wallGenerator.stopWalls()
        movingGround.stop()
        hero.stop()
        
        // create game over label
        let gameOverLabel = SKLabelNode(text: "Game Over!")
        gameOverLabel.fontColor = UIColor.blackColor()
        gameOverLabel.fontName = "GillSans"
        gameOverLabel.position.x = view!.center.x
        gameOverLabel.position.y = view!.center.y + 40
        gameOverLabel.fontSize = 32.0
        addChild(gameOverLabel)
        gameOverLabel.runAction(blinkAnimation())
        
        
        // save current points label value
        let pointsLabel = childNodeWithName("pointsLabel") as! PointsLabel
        let highscoreLabel = childNodeWithName("highscoreLabel") as! PointsLabel
        
        if highscoreLabel.number < pointsLabel.number {
            highscoreLabel.setTo(pointsLabel.number)
            
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setInteger(highscoreLabel.number, forKey: "highscore")
        }
    }
    
    func restart() {
        cloudGenerator.stopGenerating()
        
        let newScene = GameScene(size: view!.bounds.size)
        newScene.scaleMode = .AspectFill
        
        view!.presentScene(newScene)
    }
    
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if isGameOver {
            restart()
        } else if !isStarted {
            start()
        } else {
            hero.flip()
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        if wallGenerator.wallTrackers.count > 0 {
            
            let wall = wallGenerator.wallTrackers[0] as Wall
            
            let wallLocation = wallGenerator.convertPoint(wall.position, toNode: self)
            if wallLocation.x < hero.position.x {
                wallGenerator.wallTrackers.removeAtIndex(0)
                
                let pointsLabel = childNodeWithName("pointsLabel") as! PointsLabel
                pointsLabel.increment()
                if(pointsLabel.number < 250){
                    wallGenerator.stopGenerating()
                    delay(0.25, closure: {
                        if !self.isGameOver {
                            self.wallGenerator.generateWall()
                        }})
                    var interval = 1.00 - (Double(pointsLabel.number)/500)
                    wallGenerator.startGeneratingWallsEvery(interval)
                }
            }
        }
        
    }
    
    // MARK: Delay Helper
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    // MARK: - SKPhysicsContactDelegate
    func didBeginContact(contact: SKPhysicsContact) {
        if !isGameOver {
            gameOver()
        }
    }
    
    // MARK: - Animations
    func blinkAnimation() -> SKAction {
        let duration = 0.4
        let fadeOut = SKAction.fadeAlphaTo(0.2, duration: duration)
        let fadeIn = SKAction.fadeAlphaTo(1.0, duration: duration)
        let blink = SKAction.sequence([fadeOut, fadeIn])
        return SKAction.repeatActionForever(blink)
    }
}
