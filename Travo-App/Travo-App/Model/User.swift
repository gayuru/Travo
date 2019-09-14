//
//  User.swift
//  Travo-App
//
//  Created by Gayuru Gunawardana on 11/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import Foundation

class User{
    private let name:String
    private let email:String
    private let password:String
    private let aboutMeDesc:String
    private var citiesVisited: [String]
    
    init(name:String,password:String,email:String,aboutMeDesc:String) {
        self.name = name
        self.password = password
        self.email = email
        self.aboutMeDesc = aboutMeDesc
        self.citiesVisited = []
    }
}
