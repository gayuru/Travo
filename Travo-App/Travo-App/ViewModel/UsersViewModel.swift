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
    
    // TODO Make sure this sets the logged in user Properly
    func existingUserFound()->Bool{
        if users.getAllUsers().count > 0 {
            loggedInUser = users.findUserByEmail(email: "email1")
            return true
        }
        return false
    }
    
    func authenticate(email:String?, password:String?)->Bool{
        if (email == nil || password == nil) {
            return false
        }
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
    
    func createUser(username:String?, email:String?, password:String?, aboutMeDesc:String?,interests:String?)->Bool{
        if let validName = username, let validEmail = email, let validPassword = password, let validAboutMeDesc = aboutMeDesc, let validInterests = interests{
            if (!validName.isEmpty ||  !validEmail.isEmpty || !validPassword.isEmpty) {
                do {
                    // This is a new account, create a new keychain item with the account name.
                    let passwordItem = KeychainLoginModel(service: KeychainConfiguration.serviceName,
                                                            account: validEmail,
                                                            accessGroup: KeychainConfiguration.accessGroup)
                    
                    // Save the password for the new item.
                    try passwordItem.savePassword(password: validPassword)
                    return true
                } catch {
                    fatalError("Error updating keychain - \(error)")
                }
                
//                let newUser:User = User.init(name: validName, password: validPassword, email: validEmail, aboutMeDesc: validAboutMeDesc,interests: validInterests)
//                let added:Bool = self.users.addUser(user: newUser)
//                if (added == true) {
//                    loggedInUser = newUser
//                    return true
//                }
            }
        }
        return false
    }
    
    func getCurrentUser()->User?{
        return self.loggedInUser
    }
}
