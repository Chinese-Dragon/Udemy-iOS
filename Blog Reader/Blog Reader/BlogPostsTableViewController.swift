//
//  BlogPostsTableViewController.swift
//  Blog Reader
//
//  Created by Mark on 8/19/16.
//
//

import UIKit
import CoreData

class BlogPostsTableViewController: CoreDataTableViewController {
    
    //Model
    private var managedObjectContext: NSManagedObjectContext? = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
    
    private var blogUrl: NSURL? {
        didSet {
            if blogUrl != nil {
                fetchData()
            }
        }
    }
    
    private var jsonResult: NSDictionary? {
        didSet {
            if jsonResult != nil {
                fetchBlogInfo()
                updateUI()
            }
        }
    }
    
    
    //public strings
    private struct Storyboard {
        static let CellIdentifier = "Blog Post"
        static let DetailSegue = "Show Blog"
    }
    
    private struct Urls {
        static let blogUrl = NSURL(string: "https://www.googleapis.com/blogger/v3/blogs/10861780/posts?key=AIzaSyDSF8HOwhbCPMf0PXLW8nsIkFtkt6Np7Z8")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blogUrl = Urls.blogUrl
        
    }
    
    private func fetchData() {
        let task = NSURLSession.sharedSession().dataTaskWithURL(blogUrl!) { (data, response, error) in
            if error != nil {
                print(error)
            } else {
                if let rawData = data {
                    do {
                        let json = try NSJSONSerialization.JSONObjectWithData(rawData, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        self.jsonResult = json
                    } catch let error{
                        print("Error when convert JSON object \(error)")
                    }
                }
            }
        }
        task.resume()
    }
    
    private func fetchBlogInfo() {
        if let items = jsonResult!["items"] as? NSArray {
            for item in items {
                if let title = item["title"] as? String, let content = item["content"] as? String{
                    
                    updateDatabase(title, content: content)
                }
            }
             printDatabaseStatistics()
        }
    }
    
    private func updateDatabase(title: String, content: String) {
        managedObjectContext?.performBlock{
            _ = BlogItems.blogItemsWithItemInfo(title, content: content, inManagedObjectContext: self.managedObjectContext!)
            do {
                try self.managedObjectContext?.save()
            } catch let error {
                print("Error detect when saving data \(error)")
            }
        }
    }
    
    private func printDatabaseStatistics() {
        managedObjectContext?.performBlock({ 
            let dataCount = self.managedObjectContext?.countForFetchRequest(NSFetchRequest(entityName:"BlogItems"), error: nil)
            print("There are \(dataCount!) data in my database")
        })
    }
    
    private func updateUI() {
        let request = NSFetchRequest(entityName: "BlogItems")
        request.sortDescriptors = [NSSortDescriptor(
            key: "title",
            ascending: true,
            selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))]
        
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: managedObjectContext!,
            sectionNameKeyPath: nil,
            cacheName: nil)
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellIdentifier, forIndexPath: indexPath)
        
        // configuare cell
        if let blogItem = fetchedResultsController?.objectAtIndexPath(indexPath) as? BlogItems {
            cell.textLabel?.text = blogItem.title
        }
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Storyboard.DetailSegue {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = self.fetchedResultsController?.objectAtIndexPath(indexPath) as! BlogItems
                let dvc = segue.destinationViewController.contentViewController as! PostPageViewController
                dvc.blogItem = object
                dvc.title = object.title
            }
        }
    }
    
}

extension UIViewController {
    var contentViewController: UIViewController {
        get {
            if let navcon = self as? UINavigationController{
                return navcon.visibleViewController ?? self
            } else {
                return self
            }
        }
    }
}
