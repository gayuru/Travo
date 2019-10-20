//
//  UserCoreData+CoreDataProperties.swift
//  
//
//  Created by Sogyal Thundup Sherpa on 20/10/19.
//
//

import Foundation
import CoreData


extension UserCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCoreData> {
        return NSFetchRequest<UserCoreData>(entityName: "UserCoreData")
    }

    @NSManaged public var aboutMe: String?
    @NSManaged public var citiesVisited: [String]?
    @NSManaged public var email: String?
    @NSManaged var favourites: [Place]?
    @NSManaged public var interests: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var userImage: NSData?

}
