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
    
    func authenticate(username:String, password:String)->Bool{
        // User Exists
        let attemptedUser:User? = users.findUserByUsername(username: username)
        
        if (attemptedUser != nil) {
            // TODO Fix this unwrap
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
        return true
    }
    
    func getCurrentUser()->User?{
        return self.loggedInUser
    }
}
