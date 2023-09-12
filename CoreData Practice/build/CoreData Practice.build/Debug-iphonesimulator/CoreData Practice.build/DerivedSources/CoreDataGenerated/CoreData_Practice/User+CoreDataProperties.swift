//
//  User+CoreDataProperties.swift
//  
//
//  Created by aBoelghet  on 12/09/2023.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var age: Int16
    @NSManaged public var password: NSObject?
    @NSManaged public var username: String?

}

extension User : Identifiable {

}
