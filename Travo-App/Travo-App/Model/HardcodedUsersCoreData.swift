//
//  HardcodedUsersCoreData.swift
//  Travo-App
//
//  Created by Jun Cheong on 14/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import Foundation

// Uses The Email as the unique identifier in this dictionary
class HardCodedUsersCoreData {
    let range:ClosedRange = 1...10
    private var users = [String:User]()
    
    init() {
        populateUsersList()
    }
    
    func populateUsersList() {
        
        for x in range {
            let key = "email\(x)"
            let newUser = User(name: "user\(x)", password: "password\(x)", email: key, aboutMeDesc: "I am User Number:\(x)")
            self.users.updateValue(newUser, forKey: key)
        }
    }
    
    func getUsersList() -> [String:User] {
        return self.users
    }
}
