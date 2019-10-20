//
//  UsersViewModel.swift
//  Travo-App
//
//  Created by Jun Cheong on 14/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import Foundation
import UIKit

class UsersViewModel {
    private var users:Users
    private var loggedInUser:UserCoreData?
    
    init() {
        users = Users.init()
    }
    
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
    
    func createUser(username:String?, email:String?, password:String?,image:UIImage?)->Bool{
        if let validName = username, let validEmail = email, let validPassword = password{
            if (!validName.isEmpty ||  !validEmail.isEmpty || !validPassword.isEmpty) {
                var profileImage = image
                if profileImage == nil {
                    profileImage = UIImage(named: "profile")
                }
                let added:Bool = users.addCoreDataUser(name: validName, password: validPassword, email: validEmail,image: profileImage!)
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
