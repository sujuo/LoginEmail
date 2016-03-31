//
//  DataService.swift
//  ForumAppBasic
//
//  Created by Shalom Ononuju on 20/03/2016.
//  Copyright © 2016 Shalom Ononuju. All rights reserved.
//

import Foundation
import UIKit

class DataService {
    // creating a singleton , one onstance in memory and accessibly blobally ( to all)
    //only create one instance of this i.e. static . always in memory
    
    static let instance = DataService()
    let KEY_POSTS = "posts"
    private var _loadedPosts = [Post]()
    //getter
    var loadedPosts: [Post] {
        return _loadedPosts
    }
    
    //save posts on hardrive of the app
    //archive data ( in bytes and bits)
    //take array of posts and convert into data to store on disk
    //grabbing user defualt and giving a key
    func savePosts() {
        let postsData = NSKeyedArchiver.archivedDataWithRootObject(_loadedPosts)
        NSUserDefaults.standardUserDefaults().setObject(postsData, forKey: KEY_POSTS)
        // save data to disk 
        NSUserDefaults.standardUserDefaults().synchronize()
    }
 // grab object for that key , if an object exists for the key the turn data into array of posts
    func loadPosts() {
         if let postsData = NSUserDefaults.standardUserDefaults().objectForKey(KEY_POSTS) as? NSData {
            // Take data  and put it back to what we can read
            if let postsArray = NSKeyedUnarchiver.unarchiveObjectWithData(postsData) as? [Post] {
                _loadedPosts = postsArray
            }
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "postsLoaded", object: nil ))
            
        
    }
    }
    //save file path to image to be grabbed from file structure
    
    func saveImageAndCreatePath(image: UIImage) -> String {
        // turn image into Data (from PNG to data)
        
        let imgData = UIImagePNGRepresentation(image)
        // each image has a unique identifier
        let imgPath = "image\(NSDate.timeIntervalSinceReferenceDate()).png"
        // call function which passes it name and adds it to  the end of the document directory. Grab directory where it is saved
        let fullPath = documentsPathForFileName(imgPath)
        // if written to back up file and no error (save data safely in file
        imgData?.writeToFile(fullPath, atomically: true)
        //return path of image to the object that is calling to save in NS User defaults (so it can look it up to load)
        return imgPath
    }

    
    // return Image to be used
    func imageForPath(path: String)  -> UIImage? {
        // pass to the path name of the file    
        let fullPath = documentsPathForFileName(path)
        //load full file path
        let image = UIImage(named: fullPath)
        return image
    }
    
    func addPost(post: Post) {
        _loadedPosts.append(post)
        savePosts()
        loadPosts()
        
    }
    
    // function for directory when you  save and load images 
    
    // get path for a specific file name
    
    // pass name of file , grab file path in document directory, append name to end of the path and save data there
    
    func documentsPathForFileName(name:String) -> String {
        // stored in personal documents directory
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        //get first element out of array of it
        let fullPath = paths[0] as
        NSString
        
        return fullPath.stringByAppendingPathComponent(name)
    }
    
}