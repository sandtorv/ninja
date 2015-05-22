//
//  GameViewController.swift
//  Ninja
//
//  Created by Sebastian Sandtorv  on 19/05/15.
//  Copyright (c) 2015 Sebastian Sandtorv . All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var scene: GameScene!
    var wallGenerator: WallGenerator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        
        // Create and configure the scene
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill

        // Debug info
        //        skView.showsNodeCount = true
        //        skView.showsFPS = true
        
        // Present the scenee
        skView.presentScene(scene)
    }
//    TODO: fix pause
//    @IBAction func pauseButton(sender: AnyObject) {
//     
//       if(scene.view?.paused == true){
//            scene.view?.paused = false
//        } else{
//            scene.view?.paused = true
//        }
//    }
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
