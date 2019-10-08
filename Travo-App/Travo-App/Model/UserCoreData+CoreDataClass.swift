//
//  UserCoreData+CoreDataClass.swift
//  Travo-App
//
//  Created by Sogyal Thundup Sherpa on 9/10/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//
//

import Foundation
import CoreData


public class UserCoreData: NSManagedObject {
    convenience init(name:String,password:String,email:String,aboutMeDesc:String,interests:String) {
        self.init()
        self.name = name
        self.password = password
        self.email = email
        self.aboutMe = aboutMeDesc
        self.citiesVisited = []
        self.favourites = [Place]()
        self.interests = interests
    }
    
    func getUser()->String{
        return self.name!
    }
    
    func getPassword()->String{
        return self.password!
    }
    
    func getEmail()->String{
        return self.email!
    }
    
    func getCity(index:Int)->String{
        return self.citiesVisited![index]
    }
    
    func getCities()->[String]{
        return self.citiesVisited!
    }
    
    func setCities(city:String)->Bool{
        self.citiesVisited?.append(city)
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
        return self.aboutMe!
    }
    
    func setDescription(newDesc:String)->Bool{
        self.aboutMe = newDesc
        return true
    }
    
    func getInterests()->String{
        return self.interests!
    }
    
    func setInterests(newInterest:String)->Bool{
        self.interests = newInterest
        return true
    }
    
    func addToFavourites(place:Place)->Bool{
        if(favourites!.count<=0) {
            self.favourites?.append(place)
            return true
        }else if((favourites?.contains(where: { (Place) -> Bool in
            Place.name == place.name
        }))!){
            return false
        }else{
            self.favourites?.append(place)
            return true
        }
    }
    
    
    func removeFavourites(place:Place) -> Bool{
        if((favourites?.contains(where: { (Place) -> Bool in
            Place.name == place.name
        }))!){
            self.favourites?.removeAll(where: { (Place) -> Bool in
                return Place.name == place.name
            })
            return true
        }
        return false
    }
    
    func getFavourites()->[Place]{
        return self.favourites!
    }
}
