//
//  GameViewController.swift
//  PastaGame
//
//  Created by Alex Fedoseev on 30/09/2019.
//  Copyright © 2019 Alex Fedoseev. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController{
    
    var gameScene: GameScene!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scene = GameScene.level() {
            
            gameScene = scene
            
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.ignoresSiblingOrder = true
            scene.scaleMode = .aspectFill
            
            skView.presentScene(scene)
        
        }
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.dismiss(animated: true, completion: nil)
    }
    
}
