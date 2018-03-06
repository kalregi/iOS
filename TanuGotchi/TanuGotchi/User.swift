//
//  User.swift
//  TanuGotchi
//
//  Created by Kalcsevszki Regina on 2018. 03. 03..
//  Copyright © 2018. Kalcsevszki Regina. All rights reserved.
//

import Foundation

class User {
    let username: String
    let email: String
    let password: String
    var friends: [Friend]
    var lessons: [Lesson]
    var managedEvent: [ManagedEvent]
    let tanuGotchi: TanuGotchi
    /*
    init(username: String, email: String, password: String) {
        self.username = username
        self.email = email
        self.password = password
        self.lessons = [Lesson]()
        self.friends = [Friend]()
        self.managedEvent = [ManagedEvent]()
        self.tanuGotchi = TanuGotchi()
    }*/
    
    init(){
        self.username = "SampleBéla"
        self.email = "bela@sample.com"
        self.password = "password"
        self.lessons = [Lesson]()
        self.friends = [Friend]()
        self.managedEvent = [ManagedEvent]()
        self.tanuGotchi = TanuGotchi()
        
        let analysis = Lesson(name: "Funtional Analyzis")
        let bankinfo = Lesson(name: "Bank informatika")
        
        let analysisHomework = RegularLessonEvent(name: "Analysis homework", hours: 19, seconds: 00, weekDay: RegularLessonEvent.WeekDay.Sunday)
        let analysisDefinitions = RegularLessonEvent(name: "Analysis learning", hours: 19, seconds: 30, weekDay: RegularLessonEvent.WeekDay.Wednesday)
        
        analysis.events.append(analysisHomework)
        analysis.events.append(analysisDefinitions)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let dateTime = formatter.date(from: "2018/04/06 16:00")
        
        let bankInfoProject = SpecialLessonEvent(name: "Bankinfo project", date: dateTime!)
        
        bankinfo.events.append(bankInfoProject)
        
        self.lessons.append(analysis)
        self.lessons.append(bankinfo)
        
    }
}

class Friend {
    let username: String
    let tanuGotchi: TanuGotchi
    let lessons: [Lesson]
    
    init(friendUser: User){
        self.username = friendUser.username
        self.tanuGotchi = friendUser.tanuGotchi
        self.lessons = friendUser.lessons
    }
}
