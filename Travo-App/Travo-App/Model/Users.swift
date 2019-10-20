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
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext: NSManagedObjectContext
    static let shared = Users()
    var coreDataUsersList : [UserCoreData] = []
    var user:UserCoreData?
    
    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

    init() {
        print(urls[urls.count-1] as URL)
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func addCoreDataUser(name:String, password:String, email:String,image:UIImage)->Bool{
        let userEntity = NSEntityDescription.entity(forEntityName: "UserCoreData", in: managedContext)!
        let nsUser = NSManagedObject(entity: userEntity, insertInto: managedContext) as! UserCoreData

        
        // Signup Variables
        nsUser.setValue(name, forKey: "name")
        nsUser.setValue(password, forKey: "password")
        nsUser.setValue(email, forKey: "email")
        let data = image.pngData() as NSData?
        nsUser.userImage = data
        // Variables that are unpopulated for a new user
        nsUser.setValue("I am a very enthusiastic student and I think this is a strong point of mine. My friends say that I am a very funny and an interesting person with a good sense of humor.", forKey: "aboutMe")
        nsUser.setValue("Listening to music has always been my go to activity for all occasions. My love for music can be traced back to when I was a child", forKey: "interests")
        nsUser.setValue(["Melbourne"], forKey: "citiesVisited")
        nsUser.setValue([], forKey: "favourites")
        
        do{
            try managedContext.save()
            getUser()
        }catch let error as NSError{
            print(error, error.userInfo)
            return false
        }
        return true
    }

    func getUser(){
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserCoreData")
            let results = try managedContext.fetch(fetchRequest)
            coreDataUsersList = results as! [UserCoreData]
        }catch let error as NSError{
            print("Could not retrive users \(error), \(error.userInfo) ")
        }
    }
    
    // Nuclear remove option for coredata
    func removeUser()->Bool{
        managedContext.delete(self.user!)
        do{
            try managedContext.save()
        }catch let error as NSError{
            print(error, error.userInfo)
            return false
        }
        return true
    }
    
    func retrieveUser()->UserCoreData?{
        getUser()
        return coreDataUsersList.last
    }
    
    // Trigger This To manually update core data
    func updateCoreData(){
        do{
            try managedContext.save()
        }catch let error as NSError{
            print(error, error.userInfo)
        }
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
