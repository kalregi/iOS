//
//  EventViewController.swift
//  TanuGotchiSimple
//
//  Created by Kalcsevszki Regina on 2018. 06. 19..
//  Copyright © 2018. Kalcsevszki Regina. All rights reserved.
//

import UIKit
class EventViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    let user : User = AppModel.getUser()
    
    var lessonIndex = -1
    var eventIndex = -1
    //var refresh : (() -> ())? = nil
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var repeatLabel: UILabel!
    
    @IBOutlet weak var repeatSwitch: UISwitch!
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    
    @IBOutlet weak var repeatDayLabel: UILabel!
    
    @IBOutlet var dayPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Esemény módosítása"
        
        nameTextField.delegate = self

        let event = getEvent()
        
        dayPicker.delegate = self
        dayPicker.dataSource = self
        dayPicker.reloadAllComponents()

        //Esemény nevének beállítása
        nameTextField.insertText(event!.name)
        //Esemény típusától függő beállítások
        if event?.type == "special" {
            
            //Ismétődés switcher beállítása
            repeatSwitch.setOn(false, animated: false)
            
            //Dátum kiválasztó beállítása
            dateTimePicker.datePickerMode = .dateAndTime
            
            //Esemény időpontjának beállítása
            dateTimePicker.setDate(event!.date!, animated: false)
            
            repeatDayLabel.isHidden = true
            dayPicker.isHidden = true
            
        } else {
            //Ismétlődés switcher beállítása
            repeatSwitch.setOn(true, animated: false)
            
            //Időpont kiválasztó beállítása
            dateTimePicker.datePickerMode = .time
            
            //Ismétlődés időpontjának beállítása
            /*
            let dateString = (event!.hours > 9 ? String(event!.hours) : "0" + String(event!.hours)) + ":" + (event!.minutes > 9 ? String(event!.minutes) : "0" + String(event!.minutes))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            //dateFormatter.timeZone = NSTimeZone(abbreviation: "HUN") as TimeZone?
            let dataDate = dateFormatter.date(from: dateString)
            dateTimePicker.setDate(dataDate!, animated: false)
            */
            let date = (event?.getNextDate())!
            dateTimePicker.setDate(date, animated: false)
            //Nap választó beállítása
            dayPicker.selectRow(Calendar.current.component(.weekday, from: date)-1, inComponent: 0, animated: false)

        }
    }
    
    func getEvent() -> LessonEvent? {
        guard lessonIndex > -1 && eventIndex > -1 else {
            return nil
        }
        return user.lessons[lessonIndex].events[eventIndex]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let pickerData = [["Vasárnap", "Hétfő", "Kedd", "Szerda", "Csütörtök", "Péntek", "Szombat"]]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let event = getEvent()
        guard event?.type == "regular" else {
            return
        }
        
        event?.weekDay = LessonEvent.WeekDay(rawValue: (dayPicker.selectedRow(inComponent: 0)+1))!
        //refresh!()
    }
    
    @IBAction func nameEditDidEnd(_ sender: UITextField) {
        let event = getEvent()
        event?.name = sender.text!
        //refresh!()
    }
    
    @IBAction func repeatSwichChanged(_ sender: Any) {
        refreshEventValues()
    }
    
    @IBAction func dateChanged(_ sender: Any) {
        let event = getEvent()
        let selectedDate = dateTimePicker.date
        
        if repeatSwitch.isOn {
            event?.hours = Calendar.current.component(.hour, from: selectedDate)
            event?.minutes = Calendar.current.component(.hour, from: selectedDate)
        } else {
            guard event?.type == "special" else {
                return
            }
            event?.date = selectedDate
        }
        //refresh!()
    }
    
    
    func refreshEventValues(){
        if repeatSwitch.isOn {
            let selectedDate = dateTimePicker.date
            if (dayPicker.selectedRow(inComponent: 0) == 0){
                let date = (getEvent()?.getNextDate())!
                dayPicker.selectRow(Calendar.current.component(.weekday, from: date)-1, inComponent: 0, animated: false)
            }
            let newEvent = LessonEvent(name: nameTextField.text!, hours: Calendar.current.component(.hour, from: selectedDate), minutes: Calendar.current.component(.minute, from: selectedDate), weekDay: LessonEvent.WeekDay(rawValue: (dayPicker.selectedRow(inComponent: 0)+1))!)
            user.lessons[lessonIndex].events[eventIndex] = newEvent
            dateTimePicker.datePickerMode = .time
            dayPicker.isHidden = false
            repeatDayLabel.isHidden = false
        } else {
            let newEvent = LessonEvent(name: nameTextField.text!, date: dateTimePicker.date)
            user.lessons[lessonIndex].events[eventIndex] = newEvent
            dateTimePicker.datePickerMode = .dateAndTime
            dayPicker.isHidden = true
            repeatDayLabel.isHidden = true
        }
        //refresh!()
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

}
