//
//  AppModel.swift
//  TanuGotchiSimple
//
//  Created by Kalcsevszki Regina on 2018. 06. 19..
//  Copyright © 2018. Kalcsevszki Regina. All rights reserved.
//

import Foundation

class AppModel {
    
    static private var user : User?
    
    static private var fileUrl : URL{
        let filename = "savedUser.txt"
        let directoryURL : URL? = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let url = directoryURL!.appendingPathComponent(filename)
        return url
    }
    
    static func getUser() -> User {
        guard AppModel.user != nil else {
            AppModel.user = User()
            return AppModel.user!
        }
        return AppModel.user!
    }
    
    static func save() {
        do {
            //let data = NSKeyedArchiver.archivedData(withRootObject: AppModel.user!)
            let encodedData = try? JSONEncoder().encode(AppModel.user!)
            try encodedData!.write(to: AppModel.fileUrl)
        } catch {
            print("Problemoccured while saveing")
        }
    }
    
    static func load() {
        //let loadedUser = NSKeyedUnarchiver.unarchiveObject(withFile: AppModel.fileUrl.absoluteString) as? User
        do {
            let loadedText = try String(contentsOf: fileUrl)
            let jsonData = loadedText.data(using: .utf8)
            let userObject = try? JSONDecoder().decode(User.self, from: jsonData!)
            AppModel.user = userObject
        } catch {
            print("Problemoccured while loading")

        }
    }
}

class Lesson : Codable {
    let name: String
    var events: [LessonEvent]

/*
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        events = [LessonEvent]()
        //events = try values.decode([LessonEvent.self], forKey: .events)
        var eventVals = try values.nestedUnkeyedContainer(forKey: .events)
        while (!eventVals.isAtEnd){
            events.append(try eventVals.decode(LessonEvent.self))
        
        }
    }
 */
/*
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)

        try container.encode(events.map(AnyLessonEvent.init), forKey: .events)

        
        //var additionalInfo = container.nestedContainer(keyedBy: self, forKey: .events)
        //try additionalInfo.encode(events, forKey: .events)
    }*/
    
    init(name: String) {
        self.name = name
        self.events = [LessonEvent]()
    }
}

class LessonEvent : Codable {
    var name: String
    var hours: Int
    var minutes: Int
    var type: String
    var date : Date?
    var weekDay : WeekDay?
    var lastOccurance : Date?
    
    init(name: String, date: Date){
        self.date = date
        self.type = "special"
        self.name = name
        self.hours = Calendar.current.component(.hour, from: date)
        self.minutes = Calendar.current.component(.minute, from: date)
        self.date = date
    }
    
    init(name: String, hours: Int, minutes: Int, weekDay: WeekDay){
        self.weekDay = weekDay
        type = "regular"
        self.name = name
        if hours > 23 { self.hours = 23 } else {
            if hours < 0 { self.hours = 0 } else {
                self.hours = hours
            }
        }
        if minutes > 59 { self.minutes = 59 } else {
            if minutes < 0 { self.minutes = 0 } else {
                self.minutes = minutes
            }
        }
    }
    
    enum WeekDay : Int, Codable {
        case Sunday = 0
        case Monday = 1
        case Tuesday = 2
        case Wednesday = 3
        case Thurstday = 4
        case Friday = 5
        case Saturday = 6
    }
    
    static func == (lhs: LessonEvent, rhs: LessonEvent) -> Bool {
        if lhs.type == rhs.type {
            if lhs.type == "special" {
                return lhs.name == rhs.name && lhs.hours == rhs.hours && lhs.minutes == rhs.minutes && lhs.date == rhs.date
            } else {
                return lhs.name == rhs.name && lhs.hours == rhs.hours && lhs.minutes == rhs.minutes && lhs.weekDay == rhs.weekDay
            }
        } else {
            return false
        }
    }

    func getDesc() -> String {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy.MM.dd EEEE HH:mm"
        // again convert your date to string
        let dateString = formatter.string(from: getNextDate())
        
        return dateString
    }
    
    func getNextDate() -> Date {
        if type == "regular" {
            let components = DateComponents(hour: hours, minute: minutes, weekday: weekDay!.rawValue+2)
            let nextOccurrence = Calendar.current.nextDate(after: (lastOccurance != nil ? lastOccurance! : Date()), matching: components, matchingPolicy: .nextTime)
            guard nextOccurrence != nil else {
                return Date()
            }
            return nextOccurrence!
        } else {
            return date!
        }
    }
}
/*
class RegularLessonEvent : LessonEvent {
    
    private enum CodingKeys: String, CodingKey {
        case name
        case hours
        case minutes
        case weekDay
        case lastOccurance
    }
    
    static func == (lhs: RegularLessonEvent, rhs: RegularLessonEvent) -> Bool {
        return lhs.name == rhs.name && lhs.hours == rhs.hours && lhs.minutes == rhs.minutes && lhs.weekDay == rhs.weekDay
    }
    
    enum WeekDay : Int, Codable {
        case Monday = 0
        case Tuesday = 1
        case Wednesday = 2
        case Thurstday = 3
        case Friday = 4
        case Saturday = 5
        case Sunday = 6
    }
    
    var weekDay: WeekDay
    var lastOccurance: Date?
    
    init(name: String, hours: Int, minutes: Int, weekDay: WeekDay){
        self.weekDay = weekDay
        super.init()
        type = "Regular"
        self.name = name
        if hours > 23 { self.hours = 23 } else {
            if hours < 0 { self.hours = 0 } else {
                self.hours = hours
            }
        }
        if minutes > 59 { self.minutes = 59 } else {
            if minutes < 0 { self.minutes = 0 } else {
                self.minutes = minutes
            }
        }
        self.weekDay = weekDay
        

    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    override func getNextDate() -> Date {
        let components = DateComponents(hour: hours, minute: minutes, weekday: weekDay.rawValue)
        let nextOccurrence = Calendar.current.nextDate(after: (lastOccurance != nil ? lastOccurance! : Date()), matching: components, matchingPolicy: .nextTime)
        guard nextOccurrence != nil else {
            return Date()
        }
        return nextOccurrence!
    }
    

    
}

class SpecialLessonEvent : LessonEvent {
    static func == (lhs: SpecialLessonEvent, rhs: SpecialLessonEvent) -> Bool {
        return lhs.name == rhs.name && lhs.hours == rhs.hours && lhs.minutes == rhs.minutes && lhs.date == rhs.date
    }

    var date: Date
    
    init(name: String, date: Date){
        self.date = date
        super.init()
        self.type = "special"
        self.name = name
        self.hours = Calendar.current.component(.hour, from: date)
        self.minutes = Calendar.current.component(.minute, from: date)
        self.date = date
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    override func getNextDate() -> Date {
        return date
    }
    
    override func getDesc() -> String {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy.MM.dd EEEE HH:mm"
        // again convert your date to string
        let dateString = formatter.string(from: getNextDate())
        
        return dateString
    }
}
*/
class ManagedEvent : Codable {
    var name: String
    var hours: Int
    var minutes: Int
    var managedDate : Date
    var managed: Bool
    var managedTime : Int
    
    init(event: LessonEvent, managedDate: Date, managed: Bool){
        self.name = event.name
        self.hours = event.hours
        self.minutes = event.minutes
        
        let eventDate = event.getNextDate()
        self.managedDate = eventDate > managedDate ? eventDate : managedDate
        self.managed = managed
        
        //self.managedTime = event.getNextDate() - Date()
        let calendar: Calendar = Calendar.current
        if eventDate > managedDate {
            let components = calendar.dateComponents([Calendar.Component.day], from: managedDate, to: eventDate)
            self.managedTime = -1 * components.day!
        } else {
            let components = calendar.dateComponents([Calendar.Component.day], from: eventDate, to: managedDate)
            self.managedTime = components.day!
        }
    }
    
    func getDesc() -> String {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy.MM.dd EEEE HH:mm"
        // again convert your date to string
        let dateString = formatter.string(from: managedDate)
        
        return dateString
    }
}

class User : Codable {
    let username: String
    let email: String
    let password: String
    var friends: [Friend]
    var lessons: [Lesson]
    var managedEvent: [ManagedEvent]
    
    enum CodingKeys:String,CodingKey
    {
        //Encoding/decoding will only include the properties defined in this enum, rest will be ignored
        case username
        case email
        case password
        case friends
        case lessons
        case managedEvent
    }
    
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
        
        let analysis = Lesson(name: "Funtional Analyzis")
        let bankinfo = Lesson(name: "Bank informatika")
        
        let analysisHomework = LessonEvent(name: "Analysis homework", hours: 19, minutes: 00, weekDay: LessonEvent.WeekDay.Sunday)
        let analysisDefinitions = LessonEvent(name: "Analysis learning", hours: 19, minutes: 30, weekDay: LessonEvent.WeekDay.Wednesday)
        
        analysis.events.append(analysisHomework)
        analysis.events.append(analysisDefinitions)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let dateTime = formatter.date(from: "2018/04/06 16:00")
        
        let bankInfoProject = LessonEvent(name: "Bankinfo project", date: dateTime!)
        
        bankinfo.events.append(bankInfoProject)
        
        self.lessons.append(analysis)
        self.lessons.append(bankinfo)
        
    }
    
    func getSortedToDoEvents() -> [LessonEvent]{
        var list : [LessonEvent] = []
        
        for lesson in lessons{
            list.append(contentsOf: lesson.events)
        }
        
        list.sort(by: {$0.getNextDate() < $1.getNextDate()})
        
        return list
    }
    
    func missedEvent(event : LessonEvent) {
        if event.type == "special" {
            self.managedEvent.append(ManagedEvent(event: event, managedDate: Date(), managed: false))
            deleteEvent(event: event)
        } else {
            self.managedEvent.append(ManagedEvent(event: event, managedDate: Date(), managed: false))
            event.lastOccurance = event.getNextDate() > Date() ? event.getNextDate() : Date()
        }
    }
    
    func manageEvent(event : LessonEvent) {
        if event.type == "special"  {
            self.managedEvent.append(ManagedEvent(event: event, managedDate: Date(), managed: true))
            deleteEvent(event: event)
        } else {
            self.managedEvent.append(ManagedEvent(event: event, managedDate: Date(), managed: true))
            event.lastOccurance = event.getNextDate() > Date() ? event.getNextDate() : Date()
        }
    }
    
    private func deleteEvent(event: LessonEvent){
        for i in 0...lessons.count - 1{
            for j in 0...lessons[i].events.count - 1 {
                if event == lessons[i].events[j]{
                    lessons[i].events.remove(at: j)
                    if lessons[i].events.isEmpty{
                        lessons.remove(at: i)
                    }
                    return
                }
            }
        }
    }
    
    func getManagedSorted(){
        return managedEvent.sort(by: {$0.managedDate < $1.managedDate})

    }
    
    func getPoints() -> Int {
        var result = 0;
        for managed in managedEvent {
            if managed.managed {
                if managed.managedTime > 7 {
                    result+=1
                } else {
                    if managed.managedTime > 2 {
                        result+=5
                    } else {
                        if managed.managedTime > 0 {
                            result+=10
                        } else {
                            if managed.managedTime > -2 {
                                result+=20
                            } else {
                                result+=50
                            }
                        }
                    }
                }
            } else {
                result-=25
            }
        }
        return result
    }
}

class Friend : Codable {
    let username: String
    let tanuGotchi: TanuGotchi = TanuGotchi()
    let lessons: [Lesson]
    
    enum CodingKeys:String,CodingKey
    {
        //Encoding/decoding will only include the properties defined in this enum, rest will be ignored
        case username
        case lessons
    }
    
    init(friendUser: User){
        self.username = friendUser.username
        //self.tanuGotchi = friendUser.tanuGotchi
        self.lessons = friendUser.lessons
    }
}



