//
//  ViewController.swift
//  TanuGotchi
//
//  Created by Kalcsevszki Regina on 2018. 03. 03..
//  Copyright © 2018. Kalcsevszki Regina. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {
    
        static var model = User()

        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let firstItem = tabBar.items?.first {
            firstItem.title = "Óráim"
            firstItem.image = #imageLiteral(resourceName: "ic_receipt")
        }
        if let secondItem = tabBar.items?.last {
            secondItem.title = "Feladataim"
            secondItem.image = #imageLiteral(resourceName: "ic_dns")
        }
    }
    
}

