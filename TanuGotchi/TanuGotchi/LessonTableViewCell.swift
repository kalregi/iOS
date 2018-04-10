//
//  LessonTableViewCell.swift
//  TanuGotchi
//
//  Created by Kalcsevszki Regina on 2018. 03. 12..
//  Copyright © 2018. Kalcsevszki Regina. All rights reserved.
//

import UIKit

class LessonTableViewCell: UITableViewCell {
    
    var lesson: Lesson?
    
    var title: String? = nil {
        didSet {
            titleLabel.text = title
        }
    }
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight.bold)
        return l
    }()
    
    private let removeImageView: UIImageView = UIImageView(image: #imageLiteral(resourceName: "ic_remove_circle"))
    
    public func initialize(){
        var constraints: [NSLayoutConstraint] = []
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(contentsOf: [titleLabel.leadingAnchor.constraint(equalTo: (titleLabel.leadingAnchor), constant: 8.0),
                                        titleLabel.trailingAnchor.constraint(equalTo: (titleLabel.trailingAnchor), constant: -8.0),
                                        titleLabel.centerYAnchor.constraint(equalTo: (titleLabel.centerYAnchor))])
        
        contentView.addSubview(removeImageView);
        removeImageView.translatesAutoresizingMaskIntoConstraints = false;
        constraints.append(contentsOf: [removeImageView.leadingAnchor.constraint(equalTo: (removeImageView.leadingAnchor), constant: 8.0),
                                        removeImageView.trailingAnchor.constraint(equalTo: (removeImageView.trailingAnchor), constant: -8.0),
                                        removeImageView.centerYAnchor.constraint(equalTo: (removeImageView.centerYAnchor))])
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required public init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        var constraints: [NSLayoutConstraint] = []
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(contentsOf: [titleLabel.leadingAnchor.constraint(equalTo: (contentView.leadingAnchor), constant: 20.0),
                                        titleLabel.trailingAnchor.constraint(equalTo: (titleLabel.trailingAnchor)),
                                        titleLabel.centerYAnchor.constraint(equalTo: (contentView.centerYAnchor))])
        
        contentView.addSubview(removeImageView);
        removeImageView.translatesAutoresizingMaskIntoConstraints = false;
        constraints.append(contentsOf: [removeImageView.leadingAnchor.constraint(equalTo: (contentView.trailingAnchor), constant: -30.0),
                                        removeImageView.trailingAnchor.constraint(equalTo: (removeImageView.trailingAnchor)),
                                        removeImageView.centerYAnchor.constraint(equalTo: (contentView.centerYAnchor))])
        
        NSLayoutConstraint.activate(constraints)
        initialize()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func transition() {
        let newLessonViewController:NewLessonViewController = NewLessonViewController()
        self.parentViewController?.present(newLessonViewController, animated: true, completion: nil)
        
    }
    
    func setLesson(lesson Lesson){
        self.lesson = Lesson
    }

}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
