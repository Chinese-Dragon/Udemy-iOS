//
//  PostPageViewController.swift
//  Blog Reader
//
//  Created by Mark on 8/20/16.
//
//

import UIKit

class PostPageViewController: UIViewController {

    //Model 
    var blogItem: BlogItems? {
        didSet {
            print("blogitem is set")
            displayPostContent()
        }
    }
    
    @IBOutlet weak var webView: UIWebView! {
        didSet {
            displayPostContent()
        }
    }
    
    private func displayPostContent() {
        if let blog = blogItem {
            if let web = webView {
                web.loadHTMLString(blog.content!, baseURL: NSURL(string: "https://googleblog.blogspot.com"))
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
    }
}
