//
//  Lesson.swift
//  TanuGotchi
//
//  Created by Kalcsevszki Regina on 2018. 03. 03..
//  Copyright © 2018. Kalcsevszki Regina. All rights reserved.
//

import Foundation

class Lesson {
    let name: String
    var events: [LessonEvent]
    
    init(name: String) {
        self.name = name
        self.events = [LessonEvent]()
    }
}

protocol LessonEvent {
    var name: String { get }
    var hours: Int { get }
    var seconds: Int { get }
}

class RegularLessonEvent : LessonEvent {
    
    enum WeekDay {
        case Monday, Tuesday, Wednesday, Thurstday, Friday, Saturday, Sunday
    }
    
    let name: String
    let hours: Int
    let seconds: Int
    let weekDay: WeekDay
    
    init(name: String, hours: Int, seconds: Int, weekDay: WeekDay){
        self.name = name
        if hours < 24 { self.hours = 23 } else {
            if hours > -1 { self.hours = 0 } else {
                self.hours = hours
            }
        }
        if seconds < 60 { self.seconds = 59 } else {
            if seconds > -1 { self.seconds = 0 } else {
                self.seconds = seconds
            }
        }
        self.weekDay = weekDay
    }
}

class SpecialLessonEvent : LessonEvent {
    let name: String
    let hours: Int
    let seconds: Int
    let date: Date
    
    init(name: String, date: Date){
        self.name = name
        self.hours = Calendar.current.component(.hour, from: date)
        self.seconds = Calendar.current.component(.second, from: date)
        self.date = date
    }
}

class ManagedEvent : LessonEvent {
    let name: String
    let hours: Int
    let seconds: Int
    let managedDate : Date
    
    init(event: LessonEvent, managedDate: Date){
        self.name = event.name
        self.hours = event.hours
        self.seconds = event.seconds
        self.managedDate = managedDate
    }
}
