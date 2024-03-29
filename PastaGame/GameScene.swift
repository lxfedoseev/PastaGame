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
import AVFoundation

protocol EventListenerNode {
    func didMoveToScene()
}

let pastas = [
    PastaType(name: NSLocalizedString("Spaghetti", comment: "Spaghetti pasta"), jarImage: "spaghetti.png", onePasta: "one_spaghetti.png", aldenteCookTime: 8.0, softCookTime: 11.0),
    PastaType(name: NSLocalizedString("Penne", comment: "Penne pasta"), jarImage: "penne.png", onePasta: "one_penne.png", aldenteCookTime: 11.0, softCookTime: 16.0),
    PastaType(name: NSLocalizedString("Farfalle", comment: "Farfalle pasta"), jarImage: "farfalle.png", onePasta: "one_farfalle.png", aldenteCookTime: 10.0, softCookTime: 15.0),
    PastaType(name: NSLocalizedString("Macaroni", comment: "Macaroni pasta"), jarImage: "macaroni.png", onePasta: "one_macaroni.png", aldenteCookTime: 7.0, softCookTime: 10.0),
    PastaType(name: NSLocalizedString("Conchiglie", comment: "Conchiglie pasta"), jarImage: "conchiglie.png", onePasta: "one_conchiglie.png", aldenteCookTime: 10.0, softCookTime: 12.0),
    PastaType(name: NSLocalizedString("Fettuccine", comment: "Fettuccine pasta"), jarImage: "fettuccine.png", onePasta: "one_fettuccine.png", aldenteCookTime: 6.0, softCookTime: 8.0),
    PastaType(name: NSLocalizedString("Fusilli", comment: "Fusilli pasta"), jarImage: "fusilli.png", onePasta: "one_fusilli.png", aldenteCookTime: 12.0, softCookTime: 17.0),
    PastaType(name: NSLocalizedString("Linguine", comment: "Linguine pasta"), jarImage: "linguine.png", onePasta: "one_linguine.png", aldenteCookTime: 9.0, softCookTime: 13.0),
    PastaType(name: NSLocalizedString("Orecchiette", comment: "Orecchiette pasta"), jarImage: "orecchiette.png", onePasta: "one_orecchiette.png", aldenteCookTime: 11.0, softCookTime: 13.0),
    PastaType(name: NSLocalizedString("Vermicelli", comment: "Vermicelli pasta"), jarImage: "vermicelli.png", onePasta: "one_vermicelli.png", aldenteCookTime: 2.0, softCookTime: 3.0),
    PastaType(name: NSLocalizedString("Rigatoni", comment: "Rigatoni pasta"), jarImage: "rigatoni.png", onePasta: "one_rigatoni.png", aldenteCookTime: 12.0, softCookTime: 15.0),
    PastaType(name: NSLocalizedString("Ziti", comment: "Ziti pasta"), jarImage: "ziti.png", onePasta: "one_ziti.png", aldenteCookTime: 14.0, softCookTime: 15.0),
    PastaType(name: NSLocalizedString("Rotelle", comment: "Rotelle pasta"), jarImage: "rotelle.png", onePasta: "one_rotelle.png", aldenteCookTime: 10.0, softCookTime: 12.0),
    PastaType(name: NSLocalizedString("Tagliatelle", comment: "Tagliatelle pasta"), jarImage: "tagliatelle.png", onePasta: "one_tagliatelle.png", aldenteCookTime: 7.0, softCookTime: 9.0),
    PastaType(name: NSLocalizedString("Pappardelle", comment: "Pappardelle pasta"), jarImage: "pappardelle.png", onePasta: "one_pappardelle.png", aldenteCookTime: 7.0, softCookTime: 9.0),
    PastaType(name: NSLocalizedString("Cavatappi", comment: "Cavatappi pasta"), jarImage: "cavatappi.png", onePasta: "one_cavatappi.png", aldenteCookTime: 11.0, softCookTime: 13.0),
    PastaType(name: NSLocalizedString("Anelloni", comment: "Anelloni pasta"), jarImage: "anelloni.png", onePasta: "one_anelloni.png", aldenteCookTime: 11.0, softCookTime: 13.0),
    PastaType(name: NSLocalizedString("Gemelli", comment: "Gemelli pasta"), jarImage: "gemelli.png", onePasta: "one_gemelli.png", aldenteCookTime: 12.0, softCookTime: 15.0),
    PastaType(name: NSLocalizedString("Casarecce", comment: "Casarecce pasta"), jarImage: "casarecce.png", onePasta: "one_casarecce.png", aldenteCookTime: 9.0, softCookTime: 12.0)
]

class GameScene: SKScene {
    
    //var jarNodes: [JarNode]!
    var jars: [PastaType]!
    var theWinner = 0
    let jarNumber = 4
    static var parentVC: UIViewController? = nil
    var pastaNode: SKSpriteNode!
    var labels:[SKLabelNode]!
    
    enum LocalStrings {
        static let jarString = "jar"
        static let pastaString = "pasta"
        static let labelString = "label"
        static let closeString = "close"
    }

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        enumerateChildNodes(withName: "//*", using: { node, _ in
            if node.isPaused {node.isPaused = false}
            
            if let eventListenerNode = node as? EventListenerNode {
                eventListenerNode.didMoveToScene()
            }
        })
        
        for i in 0...jarNumber-1{
            let jarNode = childNode(withName: LocalStrings.jarString+"\(i)") as! JarNode
            let jarLabel = jarNode.childNode(withName: LocalStrings.labelString+"\(i)") as! SKLabelNode
            jarLabel.text = jars[i].name
            jarLabel.alpha = 0.0
            jarLabel.run(SKAction.fadeIn(withDuration: 0.5))
            
            // adapt for phones with notches
            if UIDevice.current.hasNotch &&  UIDevice.current.userInterfaceIdiom == .phone {
                if i == 0 || i == 1{
                    jarNode.position.x -= 80
                }else if i == 2 || i == 3 {
                    jarNode.position.x += 80
                }
            }
        }
        
        pastaNode = childNode(withName: LocalStrings.pastaString) as! SKSpriteNode
        let newImage = SKTexture(imageNamed: jars[theWinner].onePasta)
        pastaNode.texture = newImage
        pastaNode.size = newImage.size()
        pastaNode.setScale(0.1)
        let scaleBig = SKAction.scale(to: 2.0, duration: 0.25)
        let scaleNormal = SKAction.scale(to: 1.0, duration: 0.25)
        let scale = SKAction.sequence([scaleBig, scaleNormal])
        let rotate = SKAction.rotate(byAngle: π*2, duration: 0.5)
        pastaNode.run(SKAction.group([scale, rotate]))
        
        let closeNode = childNode(withName: LocalStrings.closeString) as! SKSpriteNode
        
        var deviceWidth: CGFloat = 0.0
        var deviceHeight: CGFloat = 0.0
        if UIScreen.main.bounds.width < UIScreen.main.bounds.height{
            deviceWidth = UIScreen.main.bounds.width
            deviceHeight = UIScreen.main.bounds.height
        }else {
            deviceWidth = UIScreen.main.bounds.height
            deviceHeight = UIScreen.main.bounds.width
        }
        let maxAspectRatio: CGFloat = deviceWidth / deviceHeight
        closeNode.position = CGPoint(x: size.height*maxAspectRatio/2-100, y: size.height/2-100)
    }
    
    class func level() -> GameScene?{
        let scene = GameScene(fileNamed:"GameScene")!
        scene.scaleMode = .aspectFill
        
        scene.jars = generateRandomArray(from: pastas, count: scene.jarNumber)
        
        scene.theWinner = Int.random(in: 0...scene.jars!.count-1)
        print("the winner is \(scene.theWinner)")
        if let jars = scene.jars {
            for pst in jars {
                print(pst.name)
            }
        }
        
        return scene
        
    }
    
    func generateJarDict(number: Int) -> [String:String] {
        var myDict = [String:String]()
        for i in 0...number-1{
            myDict[LocalStrings.labelString+"\(i)"] = LocalStrings.jarString+"\(i)"
        }
        return myDict
    }

    func newGame() {
        view!.presentScene(GameScene.level())
    }
    
    func win(name: String){
        print("win")
        
        let possibleName = getJarName(name: name)
        guard let jarName = possibleName else {
            return
        }
        
        let jarNode = childNode(withName: jarName) as! SKSpriteNode
        let movePasta = SKAction.move(to: jarNode.position, duration: 0.5)
        let scalePasta = SKAction.scale(to: 0.5, duration: 0.5)
        let rotatePasta = SKAction.rotate(byAngle: π*2, duration: 0.5)
        pastaNode.run(SKAction.group([movePasta, scalePasta, rotatePasta]))
        SKTAudio.sharedInstance().playSoundEffect("win.wav")
        
        run(SKAction.afterDelay(0.6, runBlock: newGame))
    }
    
    func lose(name: String) {
        print("lose")
        
        let possibleName = getJarName(name: name)
        guard let jarName = possibleName else {
            return
        }

        let jarNode = childNode(withName: jarName) as! SKSpriteNode

        let colorRed = SKAction.colorize(with: SKColor.red, colorBlendFactor: 1.0, duration: 0.1)
        let restoreColor = SKAction.colorize(withColorBlendFactor: 0.0, duration: 0.1)
        let colorize = SKAction.repeat(SKAction.sequence([colorRed, restoreColor]), count: 2)

        let vibro = SKAction.run() {
          UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        }
        let wait = SKAction.wait(forDuration: 0.1)
        let vibraite = SKAction.sequence([vibro, wait, vibro])
        let wrongJar = SKAction.group([colorize, vibraite])
        SKTAudio.sharedInstance().playSoundEffect("lose.wav")

        jarNode.run(wrongJar)
    }
    
    func getJarName(name: String) -> String? {
        
        var jarName: String
        if name.starts(with:LocalStrings.labelString){
            let dict = generateJarDict(number: jarNumber)
            if let jar = dict[name]{
                jarName = jar
            }else{
                return nil
            }
        }else{
            jarName = name
        }
        return jarName
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let touch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name {
            if name == LocalStrings.pastaString {
                return
            }
            if name == LocalStrings.jarString+"\(theWinner)" ||
                name == LocalStrings.labelString+"\(theWinner)" {
                win(name: name)
            }else if name == LocalStrings.closeString {
                GameScene.parentVC?.dismiss(animated: true, completion: nil)
            }else {
                lose(name: name)
            }
        }
    }
}
