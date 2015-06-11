//
//  WallGenerator.swift
//  Ninja
//
//  Created by Sebastian Sandtorv  on 11/06/15.
//  Copyright (c) 2015 Sebastian Sandtorv . All rights reserved.
//

import Foundation
import SpriteKit

class WallGenerator: SKSpriteNode{
    var generationTimer: NSTimer?
    var walls = [Wall]()
    var wallTrackers = [Wall]()
    
    func startGeneratingWalls(seconds: NSTimeInterval){
        generationTimer = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: "generateWall", userInfo: nil, repeats: true)
    }
    
    func stopGenerating() {
        if(generationTimer != nil){
            generationTimer?.invalidate()
        }
    }
    
    func generateWall() {
        let wall = Wall()
        wall.position.x = size.width/2 + wall.size.width/2
        wall.position.y = groundHeight/2 + wall.size.height/2
        walls.append(wall)
        wallTrackers.append(wall)
        addChild(wall)
    }
    
    func stopWalls() {
        stopGenerating()
        for wall in walls {
            wall.stopMoving()
        }
    }

}