//
//  HeaderUIView.swift
//  TanuGotchi2.0
//
//  Created by Kalcsevszki Regina on 2018. 04. 15..
//  Copyright © 2018. Kalcsevszki Regina. All rights reserved.
//

import UIKit

class HeaderUIView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    private struct Constants {
        static let titlePadding: CGPoint = CGPoint(x: 10.0, y: -10.0)
        static let height: CGFloat = 60.0
    }
    
    let titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return l
    }()
    
    var height: CGFloat { return Constants.height }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white.withAlphaComponent(0.8)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        NSLayoutConstraint.activate([titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.titlePadding.x),
                                     titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.titlePadding.y)])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
