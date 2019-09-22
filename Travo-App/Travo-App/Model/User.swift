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
    private var favourites:[Place]
    private var interests:String
    
    init(name:String,password:String,email:String,aboutMeDesc:String,interests:String) {
        self.name = name
        self.password = password
        self.email = email
        self.aboutMeDesc = aboutMeDesc
        self.citiesVisited = []
        self.favourites = [Place]()
        self.interests = interests
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
    
    func getCity(index:Int)->String{
        return self.citiesVisited[index]
    }
    
    func getCities()->[String]{
        return self.citiesVisited
    }
    
    func setCities(city:String)->Bool{
        citiesVisited.append(city)
        return true
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
    
    func getInterests()->String{
        return self.interests
    }
    
    func setInterests(newInterest:String)->Bool{
        self.interests = newInterest
        return true
    }
    func addToFavourites(place:Place)->Bool{
        if(favourites.count<=0) {
            favourites.append(place)
            return true
        }else if(favourites.contains(where: { (Place) -> Bool in
            Place.name != place.name
        })){
            favourites.append(place)
            return true
        }
        return false
    }
    
    func removeFavourites(place:Place) -> Bool{
        if(favourites.contains(where: { (Place) -> Bool in
            Place.name == place.name
        })){
            favourites.removeAll { (Place) -> Bool in
                return Place.name == place.name
            }
          return true
        }
        return false
    }
    
    func getFavourites()->[Place]{
        return self.favourites
    }
    
}
