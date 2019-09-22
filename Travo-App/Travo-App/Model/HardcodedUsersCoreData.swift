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
    private let cities = ["Camptown","Clarence","Fishing Creek","Huslia","Lennox"]
    
    init() {
        populateUsersList()
    }
    
    private let abutMeCommonDesc:String = "I am a very enthusiastic student and I think this is a strong point of mine. My friends say that I am a very funny and an interesting girl with a good sense of humor."
    
    private let interestsCommon:String = "Listening to music has always been my go to activity for all occasions. My love for music can be traced back to when I was a child"
    func populateUsersList() {
        
        for x in range {
            let key = "email\(x)"
            let newUser = User(name: "user\(x)", password: "password\(x)", email: key, aboutMeDesc: abutMeCommonDesc, interests: interestsCommon)
            for y in cities {
                 newUser.setCities(city: y)
            }
            self.users.updateValue(newUser, forKey: key)
        }
    }
    
    func getUsersList() -> [String:User] {
        return self.users
    }
}
