//
//  ViewController.swift
//  TanuGotchi2.0
//
//  Created by Kalcsevszki Regina on 2018. 04. 15..
//  Copyright © 2018. Kalcsevszki Regina. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {
    
    static var model = AppModel.getUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lessonsViewController = LessonsViewController()
        lessonsViewController.tabBarItem = UITabBarItem(title: "Lessons", image: #imageLiteral(resourceName: "ic_receipt") , tag: 1)
        
        let tasksViewController = TasksViewController()
        tasksViewController.tabBarItem = UITabBarItem(title: "Tasks", image: #imageLiteral(resourceName: "ic_dns") , tag: 0)

        let viewControllerList = [ lessonsViewController, tasksViewController]
        viewControllers = viewControllerList
 
    }
    
}
