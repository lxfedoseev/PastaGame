//
//  GameScene.swift
//  PastaGame
//
//  Created by Alex Fedoseev on 30/09/2019.
//  Copyright © 2019 Alex Fedoseev. All rights reserved.
//

import SpriteKit
import GameplayKit
import GameKit

protocol EventListenerNode {
    func didMoveToScene()
}

protocol InteractiveNode {
    func interact()
}

let pastas = [
    PastaType(name: NSLocalizedString("Spaghetti", comment: "Spaghetti pasta"), jarImage: "spaghetti.png", aldenteCookTime: 8, softCookTime: 11),
    PastaType(name: NSLocalizedString("Penne", comment: "Penne pasta"), jarImage: "penne.png", aldenteCookTime: 11, softCookTime: 16),
    PastaType(name: NSLocalizedString("Farfalle", comment: "Farfalle pasta"), jarImage: "farfalle.png", aldenteCookTime: 10, softCookTime: 15),
    PastaType(name: NSLocalizedString("Macaroni", comment: "Macaroni pasta"), jarImage: "macaroni.png", aldenteCookTime: 7, softCookTime: 10),
    PastaType(name: NSLocalizedString("Conchiglie", comment: "Conchiglie pasta"), jarImage: "conchiglie.png", aldenteCookTime: 10, softCookTime: 12),
    PastaType(name: NSLocalizedString("Fettuccine", comment: "Fettuccine pasta"), jarImage: "fettuccine.png", aldenteCookTime: 6, softCookTime: 8),
    PastaType(name: NSLocalizedString("Fusilli", comment: "Fusilli pasta"), jarImage: "fusilli.png", aldenteCookTime: 12, softCookTime: 17),
    PastaType(name: NSLocalizedString("Linguine", comment: "Linguine pasta"), jarImage: "linguine.png", aldenteCookTime: 9, softCookTime: 13),
    PastaType(name: NSLocalizedString("Orecchiette", comment: "Orecchiette pasta"), jarImage: "orecchiette.png", aldenteCookTime: 11, softCookTime: 13),
    PastaType(name: NSLocalizedString("Vermicelli", comment: "Vermicelli pasta"), jarImage: "vermicelli.png", aldenteCookTime: 2, softCookTime: 3),
    PastaType(name: NSLocalizedString("Rigatoni", comment: "Rigatoni pasta"), jarImage: "rigatoni.png", aldenteCookTime: 12, softCookTime: 15),
    PastaType(name: NSLocalizedString("Ziti", comment: "Ziti pasta"), jarImage: "ziti.png", aldenteCookTime: 14, softCookTime: 15),
    PastaType(name: NSLocalizedString("Rotelle", comment: "Rotelle pasta"), jarImage: "rotelle.png", aldenteCookTime: 10, softCookTime: 12),
    PastaType(name: NSLocalizedString("Tagliatelle", comment: "Tagliatelle pasta"), jarImage: "tagliatelle.png", aldenteCookTime: 7, softCookTime: 9),
    PastaType(name: NSLocalizedString("Pappardelle", comment: "Pappardelle pasta"), jarImage: "pappardelle.png", aldenteCookTime: 7, softCookTime: 9),
    PastaType(name: NSLocalizedString("Cavatappi", comment: "Cavatappi pasta"), jarImage: "cavatappi.png", aldenteCookTime: 11, softCookTime: 13),
    PastaType(name: NSLocalizedString("Anelloni", comment: "Anelloni pasta"), jarImage: "anelloni.png", aldenteCookTime: 11, softCookTime: 13),
    PastaType(name: NSLocalizedString("Gemelli", comment: "Gemelli pasta"), jarImage: "gemelli.png", aldenteCookTime: 12, softCookTime: 15),
    PastaType(name: NSLocalizedString("Casarecce", comment: "Casarecce pasta"), jarImage: "casarecce.png", aldenteCookTime: 9, softCookTime: 12)
]

class GameScene: SKScene {
    
    var jarNodes: [JarNode]!
    var jars: [PastaType]!
    var theWinner = 0
    let jarNumber = 4

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        enumerateChildNodes(withName: "//*", using: { node, _ in
            if node.isPaused {node.isPaused = false}
            if let eventListenerNode = node as? EventListenerNode {
                eventListenerNode.didMoveToScene()
            }
        })
        
        for i in 1...jarNumber{
            let jarNode = childNode(withName: "jar\(i)") as! JarNode
            let jarLabel = jarNode.childNode(withName: "label\(i)") as! SKLabelNode
            jarLabel.text = jars[i-1].name
        }
    }
    
    class func level() -> GameScene?{
        let scene = GameScene(fileNamed:"GameScene")!
        scene.scaleMode = .aspectFill
        
        scene.jars = generateRandomArray(from: pastas, count: scene.jarNumber)
        
        scene.theWinner = Int.random(in: 0...scene.jars!.count-1)
        print("the winner \(scene.theWinner)")
        if let jars = scene.jars {
            for pst in jars {
                print(pst.name)
            }
        }
        
        return scene
        
    }
    
    func newGame() {
        view!.presentScene(GameScene.level())
    }
    
    func win(){
        
    }
    
    func lose() {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        print("something touched")
    }
}
