//
//  NewLessonViewController.swift
//  TanuGotchi
//
//  Created by Kalcsevszki Regina on 2018. 04. 07..
//  Copyright © 2018. Kalcsevszki Regina. All rights reserved.
//

import UIKit

class NewLessonViewController: ViewController {

    @IBOutlet weak var LessonNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SaveButton(_ sender: UIButton) {
    }
    @IBAction func CancelButton(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
