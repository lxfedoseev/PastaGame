//
//  JarNode.swift
//  PastaGame
//
//  Created by Alex Fedoseev on 01/10/2019.
//  Copyright © 2019 Alex Fedoseev. All rights reserved.
//

import SpriteKit

class JarNode: SKSpriteNode, EventListenerNode, InteractiveNode {
    
    func didMoveToScene(){
        print("jar added to scene")
        isUserInteractionEnabled = true
    }
    
    func interact() {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("jar touched")
        interact()
    }
    
    
}
