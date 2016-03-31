//
//  ViewController.swift
//  ForumAppBasic
//
//  Created by Shalom Ononuju on 19/03/2016.
//  Copyright © 2016 Shalom Ononuju. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        DataService.instance.loadPosts()
        // listen for notification when poasts are loaded, then call the fucntion 'On posts loaded'
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onPostsLoaded:", name: "postsLoaded", object: nil)
        

        
        // modify data source  so table viiw is reloaded
        tableView.reloadData()
    
           }
    
// one section in table
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //resuse cells to save memory

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       // grab current post out of array based on index
        
        // grab post from Data service (singleton)
        let post = DataService.instance.loadedPosts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostCell {
            // take data from post and pass it into the cell and update the cell
            cell.configureCell(post)
            return cell
            
        } else {
            
            // if we are unable to retrieve the old cell create a fresh cell
            
            let cell = PostCell()
            cell.configureCell(post)
            return cell
        }
        
        
    }
    
    // to know height of cell
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    
        return 98.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.loadedPosts.count
    }
    
    func onPostsLoaded(notif: AnyObject) {
        tableView.reloadData()
   
    }
}

