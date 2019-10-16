//
//  UserCoreData+CoreDataProperties.swift
//  Travo-App
//
//  Created by Jun Cheong on 15/10/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
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
    @NSManaged public var favourites: [Place]?
    @NSManaged public var interests: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var profilePicture: NSData?

}
