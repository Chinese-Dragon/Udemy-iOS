//
//  BlogItems+CoreDataProperties.swift
//  Blog Reader
//
//  Created by Mark on 8/19/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension BlogItems {

    @NSManaged var title: String?
    @NSManaged var content: String?

}
