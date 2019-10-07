//
//  Users.swift
//  Travo-App
//
//  Created by Jun Cheong on 14/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Users {
    private var userCoreDate = HardCodedUsersCoreData.init()
    private var users:[String:User]
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext: NSManagedObjectContext
    static let shared = Users()
    
    init() {
        users = userCoreDate.getUsersList()
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func getAllUsers() -> [User]{
        var list:[User] = [User]()
        for (_, user) in self.users {
            list.append(user)
        }
        return list
    }
    
    func addUser(user:User)->Bool{
//        let dictionaryKey = user.getEmail()
//        if (users[dictionaryKey]  != nil) {
//            return false
//        }
//        users.updateValue(user, forKey: dictionaryKey)
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        
        let nsUser = NSManagedObject(entity: userEntity, insertInto: managedContext) as! User
        
//        nsUser.setValue(user.name, forKey: "name")
//        nsUser.setValue(user.password, forKey: "password")
        
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
    
    
//    func addToFavourites(place:Place)->Bool{
//        if(self.getFavourites().count<=0) {
//            self.getFavourites?.append(place)
//            return true
//        }else if(self.favourites!.contains(where: { (Place) -> Bool in
//            Place.name == place.name
//        })){
//            return false
//        }else{
//            self.favourites?.append(place)
//            return true
//        }
//    }
//    
//    func removeFavourites(place:Place) -> Bool{
//        if(self.favourites!.contains(where: { (Place) -> Bool in
//            Place.name == place.name
//        })){
//            self.favourites?.removeAll { (Place) -> Bool in
//                return Place.name == place.name
//            }
//            return true
//        }
//        return false
//    }
//    
//    func getFavourites()->[Place]{
//        return self.favourites!
//    }
}
