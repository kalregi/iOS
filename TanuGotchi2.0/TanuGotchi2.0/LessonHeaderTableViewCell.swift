//
//  LessonHeaderTableViewCell.swift
//  TanuGotchi2.0
//
//  Created by Kalcsevszki Regina on 2018. 04. 17..
//  Copyright © 2018. Kalcsevszki Regina. All rights reserved.
//

import UIKit

class LessonHeaderTableViewCell: UITableViewCell {

    var user : User = AppModel.getUser()
    var lesson: Lesson?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    init(lesson: Lesson, resueIdentifier: String) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: resueIdentifier)
        //
        self.lesson = lesson
        let titleLabel = UILabel()
        titleLabel.text = lesson.name
        titleLabel.textColor = UIColor.cyan
        
        var constraints: [NSLayoutConstraint] = []
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(contentsOf: [titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
                                        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 15),
                                        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
                                        titleLabel.heightAnchor.constraint(equalToConstant: 30)])
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate(constraints)
        
        contentView.backgroundColor = UIColor(displayP3Red: CGFloat(100) / 255.0, green: CGFloat(200) / 255.0, blue: CGFloat(100) / 255.0, alpha: CGFloat(100) / 255.0)
        self.layer.cornerRadius = 0
        self.layer.masksToBounds = true
        
        let maskPath = UIBezierPath(roundedRect: self.layer.bounds,
                                    byRoundingCorners: [.topLeft, .topRight],
                                    cornerRadii: CGSize(width: 16.0, height: 16.0))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
