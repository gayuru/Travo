//
//  HardcodedUsersCoreData.swift
//  Travo-App
//
//  Created by Jun Cheong on 14/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import Foundation

class HardCodedUsersCoreData {
    let range:ClosedRange = 1...10
    private var users = [String:User]()
    
    init() {
        populateUsersList()
    }
    
    func populateUsersList() {
        
        for x in range {
            let newUsername = "user\(x)"
            let newUser = User(name: newUsername, password: "password\(x)", email:"email\(x)", aboutMeDesc: "I am User Number:\(x)")
            self.users.updateValue(newUser, forKey: newUsername)
        }
    }
    
    func getUsersList() -> [String:User] {
        return self.users
    }
}
