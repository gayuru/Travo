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
    private var loggedInUser:UserCoreData?
    
    init() {
        users = Users.init()
    }
    
    // TODO Make sure this sets the logged in user Properly
    func existingUserFound()->Bool{
        guard let user = users.retrieveUser() else {
            return false
        }
        loggedInUser = user
        return true
    }
    
    func authenticate(email:String?, password:String?)->Bool{
        if (email == nil || password == nil) {
            return false
        }
        guard let user = users.retrieveUser() else {
            return false
        }
        // Above already checks for nil presence
        if (user.getPassword() == password) {
            loggedInUser = user
            return true
        }
        return false
    }
    
    func createUser(username:String?, email:String?, password:String?)->Bool{
        if let validName = username, let validEmail = email, let validPassword = password{
            if (!validName.isEmpty ||  !validEmail.isEmpty || !validPassword.isEmpty) {
                let added:Bool = users.addCoreDataUser(name: validName, password: validPassword, email: validEmail)
                if (added == true) {
                    loggedInUser = users.retrieveUser()
                    return true
                }
            }
        }
        return false
    }
    
    func getCurrentUser()->UserCoreData?{
        return self.loggedInUser
    }
    
}
