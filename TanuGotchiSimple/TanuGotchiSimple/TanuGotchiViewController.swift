//
//  TanuGotchiViewController.swift
//  TanuGotchiSimple
//
//  Created by Kalcsevszki Regina on 2018. 06. 20..
//  Copyright © 2018. Kalcsevszki Regina. All rights reserved.
//

import UIKit
import SpriteKit

class TanuGotchiViewController: UIViewController {

    @IBOutlet weak var skView: SKView!
    var scene : TanuGotchi?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = TanuGotchi(size: skView.bounds.size)
        skView.presentScene(scene)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scene = TanuGotchi(size: skView.bounds.size)
        skView.presentScene(scene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
