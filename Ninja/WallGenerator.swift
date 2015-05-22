//
//  WallGenerator.swift
//  Ninja
//
//  Created by Sebastian Sandtorv  on 19/05/15.
//  Copyright (c) 2015 Sebastian Sandtorv . All rights reserved.
//

import Foundation
import SpriteKit

class WallGenerator: SKSpriteNode {
    
    var generationTimer: NSTimer?
    var walls = [Wall]()
    var wallTrackers = [Wall]()
    
    func startGeneratingWallsEvery(seconds: NSTimeInterval) {
        generationTimer = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: "generateWall", userInfo: nil, repeats: true)
        
    }
    
    func stopGenerating() {
        if(generationTimer != nil){
            generationTimer?.invalidate()
        }
    }
    
    func generateWall() {
        var scale: CGFloat
        let rand = arc4random_uniform(2)
        if rand == 0 {
            scale = -1.0
        } else {
            scale = 1.0
        }
        
        let wall = Wall()
        wall.position.x = size.width/2 + wall.size.width/2
        wall.position.y = scale * (kGroundHeight/2 + wall.size.height/2)
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
