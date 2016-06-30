//
//  ViewController.swift
//  Trackr
//
//  Created by sagaya Abdulhafeez on 26/06/2016.
//  Copyright © 2016 sagaya Abdulhafeez. All rights reserved.
//

import UIKit
import Material
import Firebase

class ViewController: UIViewController,TextFieldDelegate {

    @IBOutlet weak var activityInd: UIActivityIndicatorView!
    @IBOutlet weak var signupbtn: RaisedButton!
    @IBOutlet weak var confirmPassword: TextField!
    @IBOutlet weak var emailField: TextField!
    @IBOutlet weak var passwordField: TextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        prepareNameField()
        prepareEmailField()
        activityInd.hidden = true
    }

    private func prepareEmailField() {
        emailField.delegate = self
        emailField.textColor = UIColor.whiteColor()
        emailField.clearIconButtonAutoHandle = true
        emailField.clearIconButton?.tintColor = UIColor.redColor()
    }
    private func prepareNameField() {
        passwordField.delegate = self
        passwordField.textColor = UIColor.whiteColor()
        passwordField.secureTextEntry = true
        passwordField.visibilityIconButtonAutoHandle = true
        confirmPassword.visibilityIconButton?.tintColor = UIColor.whiteColor()
        confirmPassword.delegate = self
        confirmPassword.textColor = UIColor.whiteColor()
        confirmPassword.secureTextEntry = true
        confirmPassword.visibilityIconButtonAutoHandle = true
        confirmPassword.visibilityIconButton?.tintColor = UIColor.whiteColor()
    }
    

    
    override func viewDidAppear(animated: Bool) {
        //CHECK IF THERES A UID IN NSUSERSDEFAULT
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil{
            self.performSegueWithIdentifier(LOGGED_IN, sender: nil)
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Firebase Login starts here
    //Sign Up
    
    
    @IBAction func SignUp(sender: AnyObject) {
        
        if let email = emailField.text where email != "", let passwd = passwordField.text where passwd != ""{
            
            
            Dataservice.ds.REF_BASE.createUser(email, password: passwd, withValueCompletionBlock: { (error, result) in
                
                if error != nil{
                    self.showErrowAlert("Could not create account", msg: "Problem create account try something else")
                }else{
                    NSUserDefaults.standardUserDefaults().setValue(result["uid"], forKey: KEY_UID)
                    
                    Dataservice.ds.REF_BASE.authUser(email, password: passwd, withCompletionBlock: { (error, data) in
                        if error != nil{
                            print(error.debugDescription)
                        }
                        self.performSegueWithIdentifier(LOGGED_IN, sender: nil)
                    })
                    
                }
                
            })
            
            signupbtn.enabled = false
            activityInd.startAnimating()
            activityInd.hidden = false
            
        }else{
            showErrowAlert("Email and Password required", msg: "You must enter an email and password")
            signupbtn.enabled = true
            activityInd.stopAnimating()
        }
        
    }
    
    func showErrowAlert(title:String, msg:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
}

