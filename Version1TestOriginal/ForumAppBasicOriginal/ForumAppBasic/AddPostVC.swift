//
//  AddPostVC.swift
//  ForumAppBasic
//
//  Created by Shalom Ononuju on 19/03/2016.
//  Copyright © 2016 Shalom Ononuju. All rights reserved.
//

import UIKit

class AddPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var postImg: UIImageView!
    
    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var descField: UITextField!

    var imagePicker : UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //image shape is circle
        postImg.layer.cornerRadius = postImg.frame.size.width / 2
        // cut off anything outside of circle
        postImg.clipsToBounds = true
        // initialise the image picker
         imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    
        
       
    }

    @IBAction func addPicBtnPressed(sender: AnyObject!) {
    
           //hide text on button image
        sender.setTitle("", forState: .Normal)
        // show the image picker 
        presentViewController(imagePicker, animated: true, completion: nil)
    }
  //create new post object with title and description and add to posts.
    // to
   
   
    @IBAction func makePostBtnPressed(sender: AnyObject) {
    
        // make sure title and description are in posts
        if let title = titleField.text, let desc = descField.text, let img = postImg.image {
        let imgPath = DataService.instance.saveImageAndCreatePath(img)
            let post = Post(imagePath: imgPath, title: title, description: desc)
            // Button pressed
            //  to data service, to add post, appended post, save posts, loaded the posts, send notifcation to view controller, heard for listening to notification, 'onpostsloaded' (called  it) and reloaded the table view, which comes from Data Source in Data service.
            DataService.instance.addPost(post)
dismissViewControllerAnimated(true, completion: nil)
        }
        
        
    }
   
    @IBAction func cancelBtnPressed(sender: AnyObject) {
        //view controller dissapears when cancel is pressed
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    // implicated UI image picker controller delegate to recognise when picture is picked, then calls the function as delegate is looking for it
    // links to save image to image view
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        postImg.image = image
    }

}
