//
//  CircularButton.swift
//  Calculator
//
//  Created by Kalcsevszki Regina on 2018. 03. 13..
//  Copyright © 2018. Kalcsevszki Regina. All rights reserved.
//

import UIKit

class CircularButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setRadius(){
        self.layer.cornerRadius = 0.5 * self.bounds.size.width;
        self.backgroundColor = UIColor.black
    }
    
}
