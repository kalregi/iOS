//
//  LessonUITableTableViewCell.swift
//  TanuGotchi2.0
//
//  Created by Kalcsevszki Regina on 2018. 04. 15..
//  Copyright © 2018. Kalcsevszki Regina. All rights reserved.
//

import UIKit

class LessonUITableViewCell: UITableViewCell {
    
    var user : User = AppModel.getUser()
    var event: LessonEvent?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    init(event: LessonEvent, resueIdentifier: String) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: resueIdentifier)
        //
        self.event = event
        let titleLabel = UILabel()
        titleLabel.text = event.name
        titleLabel.textColor = UIColor.cyan
        
        var constraints: [NSLayoutConstraint] = []
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(contentsOf: [titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
                                        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 15),
                                        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
                                        titleLabel.heightAnchor.constraint(equalToConstant: 33)])
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate(constraints)
        contentView.backgroundColor = UIColor.myLightGreen
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}
