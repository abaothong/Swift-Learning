//
//  User+CoreDataProperties.swift
//  MyNameCard
//
//  Created by Thong Hao Yi on 26/03/2016.
//  Copyright © 2016 Thong Hao Yi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var date_of_birth: NSDate?
    @NSManaged var first_name: String?
    @NSManaged var last_name: String?
    @NSManaged var mobile_no: String?
    @NSManaged var create_date: NSDate?

}
