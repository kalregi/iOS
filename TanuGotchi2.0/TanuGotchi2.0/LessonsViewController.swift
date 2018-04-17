//
//  LessonsViewController.swift
//  TanuGotchi2.0
//
//  Created by Kalcsevszki Regina on 2018. 04. 15..
//  Copyright © 2018. Kalcsevszki Regina. All rights reserved.
//

import UIKit

class LessonsViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var user: User = AppModel.getUser()
    let identifier = "LessonCellIdentifier"
    
    let headerHeight = 60.0

    var tableView: UITableView  =   UITableView()
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = LessonHeaderTableViewCell(lesson: user.lessons[section], resueIdentifier: "LessonHeaderCell")
        let constraints = [headerCell.heightAnchor.constraint(equalToConstant: CGFloat(headerHeight))]
        NSLayoutConstraint.activate(constraints)
        //headerCell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        return headerCell
    }
    /*
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(headerHeight)
    }
    */
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let  footerCell = LessonFooterTableViewCell(lesson: user.lessons[section], resueIdentifier: "LessonFooterCell")
        return footerCell
    }
    /*
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    */
    func numberOfSections(in tableView: UITableView) -> Int {
        return user.lessons.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.lessons[section].events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = user.lessons[indexPath.section].events[indexPath.row]
        let cell = LessonUITableViewCell(event: event, resueIdentifier: identifier)
        //cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)

        return cell
    }
/*
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return user.lessons[section].name
    }
    
    */
    
    let headerView: HeaderUIView = {
        let hv = HeaderUIView()
        hv.titleLabel.text = "Lessons"
        return hv
    }()

    override func viewDidLoad() {
        //super.viewDidLoad()
        

        self.title = "Lessons"
        // Do any additional setup after loading the view.
        
        
        view = UIView()
        view.backgroundColor = UIColor.blue
        
        var constraints: [NSLayoutConstraint] = []
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        constraints.append(contentsOf: [headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                        headerView.topAnchor.constraint(equalTo: view.topAnchor),
                                        headerView.heightAnchor.constraint(equalToConstant: headerView.height)])
        
        tableView.delegate = self
        tableView.dataSource = self

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        constraints.append(contentsOf: [tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
                                        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        
        NSLayoutConstraint.activate(constraints)
        //tableView.separatorColor = UIColor.lightGray
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        //self.tableView.separatorColor = UIColor.lightGray

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension UIColor  {
    func myLightGreen() -> UIColor {
        return UIColor(displayP3Red: CGFloat(100) / 255.0, green: CGFloat(200) / 255.0, blue: CGFloat(100) / 255.0, alpha: CGFloat(100) / 255.0)}
}
