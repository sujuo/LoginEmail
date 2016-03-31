//
//  CreateAccountViewController.swift
//  Version1Test
//
//  Created by Shalom Ononuju on 19/03/2016.
//  Copyright © 2016 Shalom Ononuju. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // when the create account is clicked if the textfields are not empty create account. If they are empty show error
    @IBAction func createAccountAction(sender: AnyObject)
        
    {
        let email = self.emailTextField.text
        let password = self.passwordTextField.text
        
        
        if email != "" && password != ""
        {
            FIREBASE_REF.createUser(email, password: password, withValueCompletionBlock: { (error, result) -> Void in
                
                if error == nil
                {
                    FIREBASE_REF.authUser(email, password: password, withCompletionBlock: { (error, authData) -> Void in
                        
                        if error == nil
                        {
                            NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                            print("Account created")
                            
                            self.dismissViewControllerAnimated(true, completion: nil)
                        }
                        else
                        {
                            print(error)
                        }

        })
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

    @IBAction func cancelAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
}
