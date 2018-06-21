//
//  LessonsTableViewController.swift
//  TanuGotchiSimple
//
//  Created by Kalcsevszki Regina on 2018. 06. 19..
//  Copyright © 2018. Kalcsevszki Regina. All rights reserved.
//

import UIKit

class LessonsTableViewController: UITableViewController {
    
    let user : User = AppModel.getUser()
    var selected : IndexPath? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        let editButton   = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_add_box"),  style: .plain, target: self, action: #selector(didTapEditButton(sender:)))

        navigationItem.rightBarButtonItems = [editButton]
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return user.lessons.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return user.lessons[section].events.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)

        cell.textLabel?.text = user.lessons[indexPath.section].events[indexPath.row].name
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return user.lessons[section].name
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selected = indexPath
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Törlés") { (action, indexPath) in
            guard self.user.lessons.count > indexPath.section && self.user.lessons[indexPath.section].events.count > indexPath.row else {
                print("Delete did not happen")
                return
            }
            self.user.lessons[indexPath.section].events.remove(at: indexPath.row)
            if self.user.lessons[indexPath.section].events.isEmpty {
                self.user.lessons.remove(at: indexPath.section)
            }
            tableView.reloadData()
            
        }
        return [delete]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "EventSegue") {
            let eventViewController = segue.destination as? EventViewController
            if let evc = eventViewController {
                guard let indexPath = selected else {
                    return
                }
                evc.lessonIndex = indexPath.section
                evc.eventIndex = indexPath.row
                /*evc.refresh = {
                    self.tableView.reloadData()
                }*/
            }
        }
    }
    
    @objc func didTapEditButton(sender: AnyObject){
        if let mvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddElementViewController") as? AddEventViewController {
            mvc.refresh = {
                self.tableView.reloadData()
            }
            self.present(mvc, animated: true, completion: nil)
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
