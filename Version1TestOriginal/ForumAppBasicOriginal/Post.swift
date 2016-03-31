//
//  Post.swift
//  ForumAppBasic
//
//  Created by Shalom Ononuju on 19/03/2016.
//  Copyright © 2016 Shalom Ononuju. All rights reserved.
//

import Foundation
//inheritance from NS Object,  NS Object  and NS Coding (fix bug), for archiving
// use NS Coding protocol and inherirt NS object
// To save and and upload data conform to coding
class Post: NSObject, NSCoding {
    //! means they are implicitly unwrapped they are not forced to have any value
    private var _imagePath: String!
    private var _title: String!
    private var _postDesc: String!
    
    var imagePath: String {
        return _imagePath
    }
    
    var title: String {
        return _title
    }
    
    var postDesc: String {
        return _postDesc
    }
    
    init(imagePath: String, title: String, description: String) {
        self._imagePath = imagePath
        self._title = title
        self._postDesc = description
    }
    // make getters and setters as the variables are private ( to put in the Post cell)
    
    //initialiser function ,  when loading it begins in this fucntion
    override init() {
        
    }
    
    // call this when its loaded
    //when load posts is called, this tells it how to unarchive the data

    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        
        //decode when being unarchived. When load post is called show it how to unarchive data
        self._imagePath = aDecoder.decodeObjectForKey("imagePath") as? String
        self._title = aDecoder.decodeObjectForKey("title") as? String
        self._postDesc = aDecoder.decodeObjectForKey("description") as? String
        
    }
// function to encode when its saving
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self._imagePath, forKey: "imagePath")
        aCoder.encodeObject(self._postDesc, forKey: "description")
        aCoder.encodeObject(self._title, forKey: "title")
        
    }
    
}