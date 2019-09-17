//
//  User.swift
//  Travo-App
//
//  Created by Gayuru Gunawardana on 11/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import Foundation

class User{
    private var name:String
    private var email:String
    private var password:String
    private var aboutMeDesc:String
    private var citiesVisited: [String]
    
    init(name:String,password:String,email:String,aboutMeDesc:String) {
        self.name = name
        self.password = password
        self.email = email
        self.aboutMeDesc = aboutMeDesc
        self.citiesVisited = []
    }
    
    func getUsername()->String{
        return self.name
    }
    
    func setUsername(newUsername:String)->Bool{
        let oldUsername = self.name
        self.name = newUsername
        if (self.name == oldUsername) {
            return false
        }
        return true
    }
    
    func getPassword()->String{
        return self.password
    }
    
    func setPassword(newPassword:String)->Bool{
        let oldPassword = self.password
        self.password = newPassword
        if (self.password == oldPassword) {
            return false
        }
        return true
    }
    
    func getEmail()->String{
        return self.email
    }
    
    func setEmail(newEmail:String)->Bool{
        let oldEmail = self.email
        self.email = newEmail
        if (self.email == oldEmail) {
            return false
        }
        return true
    }
    
    func getDescription()->String{
        return self.aboutMeDesc
    }
    
    func setDescription(newDesc:String)->Bool{
        self.aboutMeDesc = newDesc
        return true
    }
    
}
