//
//  LoginViewController.swift
//  Version1Test
//
//  Created by Shalom Ononuju on 19/03/2016.
//  Copyright © 2016 Shalom Ononuju. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
 // two variables
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var logoutButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // if user logs in sucessfully, show log in button
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
         if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && CURRENT_USER.authData != nil
         {
            self.logoutButton.hidden = false
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func loginAction(sender: AnyObject)
    {
        let email = self.emailTextField.text
        let password = self.passwordTextField.text
        
        if  email != "" && password != ""
        {
            FIREBASE_REF.authUser(email, password: password, withCompletionBlock: { (error, authData) -> Void in
                
                if error == nil
                {
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                    print("Logged in")
                    self.logoutButton.hidden = false
                }
                else
                {
                    print(error)
                }
            })
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Enter email and password", preferredStyle: .Alert)
            
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func logoutAction(sender: AnyObject)
    {
        CURRENT_USER.unauth()
        
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
        self.logoutButton.hidden = true 
    }
}
