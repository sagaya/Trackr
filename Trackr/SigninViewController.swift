//
//  SigninViewController.swift
//  Trackr
//
//  Created by sagaya Abdulhafeez on 27/06/2016.
//  Copyright © 2016 sagaya Abdulhafeez. All rights reserved.
//

import UIKit
import Material

class SigninViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var activityInd: UIActivityIndicatorView!
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

    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signin(sender: AnyObject) {
        
        if let email = emailField.text where email != "", let passwd = passwordField.text where passwd != ""{
            Dataservice.ds.REF_BASE.authUser(email, password: passwd, withCompletionBlock: { (error, data) in
                
                if error != nil{
                    self.showErrowAlert("Could not login", msg: "Please check your Username or password")
                }else{
     
                    self.performSegueWithIdentifier(LOGGED_IN, sender: nil)
                    NSUserDefaults.standardUserDefaults().setValue(data.uid, forKey: KEY_UID)

                }
            })
            
            activityInd.hidden = false
            activityInd.startAnimating()
            
        }else{
            self.showErrowAlert("Email and Password required", msg: "You must enter an email and password")
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
