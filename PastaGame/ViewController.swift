//
//  ViewController.swift
//  PastaGame
//
//  Created by Alex Fedoseev on 30/09/2019.
//  Copyright © 2019 Alex Fedoseev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startButtonPressed(_ sender: UIButton) {
        if let gameViewController = storyboard?.instantiateViewController(identifier: "GameViewController") as? GameViewController {
        //navigationController?.pushViewController(gameViewController, animated: true)
            gameViewController.modalPresentationStyle = .fullScreen
            self.present(gameViewController, animated: true, completion: nil)
        }
    }
    
    
}

