//
//  BlogItems.swift
//  Blog Reader
//
//  Created by Mark on 8/19/16.
//
//

import Foundation
import CoreData


class BlogItems: NSManagedObject {

    class func blogItemsWithItemInfo(title: String, content: String, inManagedObjectContext context: NSManagedObjectContext) -> BlogItems?
    {
        let request = NSFetchRequest(entityName: "BlogItems")
        request.predicate = NSPredicate(format: "any title contains[c] %@", title)
        
        if let blogItem = (try? context.executeFetchRequest(request))?.first as? BlogItems {
            return blogItem
        } else if let blogItem = NSEntityDescription.insertNewObjectForEntityForName("BlogItems", inManagedObjectContext: context) as? BlogItems {
            blogItem.title = title
            blogItem.content = content
            return blogItem
        }
        return nil
    }
    
}
