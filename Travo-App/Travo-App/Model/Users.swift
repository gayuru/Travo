//
//  Users.swift
//  Travo-App
//
//  Created by Jun Cheong on 14/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import Foundation

class Users {
    private var userCoreDate = HardCodedUsersCoreData.init()
    private var users:[String:User]
    
    init() {
        users = userCoreDate.getUsersList()
    }
    
    func getAllUsers() -> [User]{
        var list:[User] = [User]()
        // TODO How to ignore this warning?
        for (_, user) in self.users {
            list.append(user)
        }
        return list
    }
    
    func addUser(user:User)->Bool{
        let dictionaryKey = user.getEmail()
        if (users[dictionaryKey]  != nil) {
            return false
        }
        users.updateValue(user, forKey: dictionaryKey)
        return true
    }
    
    func removeUser(user:User)->Bool{
        let dictionaryKey = user.getEmail()
        if (users[dictionaryKey] != nil) {
            users.removeValue(forKey: dictionaryKey)
            return true
        }
        return false
    }
    
    func findUserByEmail(email:String)->User?{
        return users[email]
    }
}
