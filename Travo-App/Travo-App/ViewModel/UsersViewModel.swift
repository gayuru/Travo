//
//  UsersViewModel.swift
//  Travo-App
//
//  Created by Jun Cheong on 14/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import Foundation

class UsersViewModel {
    private var users:Users
    private var loggedInUser:User?
    
    init() {
        users = Users.init()
    }
    
    func authenticate(email:String?, password:String?)->Bool{
        if (email == nil || password == nil) {
            return false
        }
        
        // Above already checks for nil presence
        let attemptedUser:User? = users.findUserByEmail(email: email!)
        
        if (attemptedUser != nil) {
            // Above already checks for nil presence
            if (attemptedUser!.getPassword() == password) {
                loggedInUser = attemptedUser
                return true
            }
            return false
        }
        return false
    }
    
    func createUser(username:String, email:String, password:String, aboutMeDesc:String)->Bool{
        let newUser:User = User.init(name: username, password: password, email: email, aboutMeDesc: aboutMeDesc)
        let added:Bool = self.users.addUser(user: newUser)
        if (added == false) {
            // TODO throw bigger error
            return false
        }
        loggedInUser = newUser
        return true
    }
    
    func getCurrentUser()->User?{
        return self.loggedInUser
    }
}
