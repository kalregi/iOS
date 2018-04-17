//
//  AppModel.swift
//  TanuGotchi
//
//  Created by Kalcsevszki Regina on 2018. 04. 07..
//  Copyright © 2018. Kalcsevszki Regina. All rights reserved.
//

import Foundation

class AppModel {
    
    static private var user : User?
    
    static func getUser() -> User {
        if AppModel.user == nil {
            AppModel.user = User()
            
        }
        return AppModel.user!
    }
}
