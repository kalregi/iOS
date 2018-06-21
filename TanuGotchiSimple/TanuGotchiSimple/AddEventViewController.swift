//
//  AddEventViewController.swift
//  TanuGotchiSimple
//
//  Created by Kalcsevszki Regina on 2018. 06. 19..
//  Copyright © 2018. Kalcsevszki Regina. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    let user : User = AppModel.getUser()
    
    var pickerData : [[String]] {
        var list = [[]]
        for lesson in user.lessons {
            list[0].append(lesson.name)
        }
        return list as! [[String]]
    }
    
    let eventNameConstant = "Új esemény neve"
    let lessonNameConstant = "Új óra neve"
    
    var refresh : (() -> ())? = nil

    @IBOutlet weak var typeSwitch: UISwitch!
    
    @IBOutlet weak var nameTextField: UITextField!
        
    @IBOutlet weak var lessonPicker: UIPickerView!
    
    @IBOutlet weak var lessonLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Elem hozzáadása"
        
        lessonPicker.delegate = self
        lessonPicker.dataSource = self
        typeSwitch.isOn = false
        
        if user.lessons.isEmpty {
            typeSwitch.isOn = true
            lessonPicker.isHidden = true
            lessonLabel.isHidden = true
        } 
        
        nameTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        guard nameTextField.text != nil && nameTextField.text != "" else {
            showAlert(self)
            return
        }
        if typeSwitch.isOn {
            let newLesson = Lesson(name: nameTextField.text!)
            newLesson.events.append(LessonEvent(name: "Új esemény", date: Date()))
            user.lessons.append(newLesson)
        } else {
            user.lessons[lessonPicker.selectedRow(inComponent: 0)].events.append(LessonEvent(name: nameTextField.text!, date: Date()))
        }
        refresh!()
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showAlert(_ sender: Any) {
        let alertController = UIAlertController(title: "Elem hozzáadása", message:
            "Adj meg nevet!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func switched(_ sender: Any) {
        if typeSwitch.isOn {
            lessonPicker.isHidden = true
            lessonLabel.isHidden = true
            nameLabel.text = lessonNameConstant
        } else {
            if user.lessons.isEmpty {
                typeSwitch.isOn = true
                lessonPicker.isHidden = true
                lessonLabel.isHidden = true
                nameLabel.text = lessonNameConstant
            } else {
                lessonPicker.isHidden = false
                lessonLabel.isHidden = false
                nameLabel.text = eventNameConstant
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    
    /**
     * Called when 'return' key pressed. return NO to ignore.
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
