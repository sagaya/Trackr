//
//  mainViewController.swift
//  Trackr
//
//  Created by sagaya Abdulhafeez on 28/06/2016.
//  Copyright © 2016 sagaya Abdulhafeez. All rights reserved.
//

import UIKit
import Material
class mainViewController: UIViewController {
    @IBOutlet weak var manifest: TextField!
    @IBOutlet weak var pickupNum: TextField!
    @IBOutlet weak var pickupAdd: TextField!
    @IBOutlet weak var pickupName: TextField!
    @IBOutlet weak var dropOffNum: TextField!
    @IBOutlet weak var dropOffAdd: TextField!
    @IBOutlet weak var dropoffname: TextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        trackIcon.enabled = false
        view1.hidden = true
        UIApplication.sharedApplication().statusBarStyle = .Default

    }
    @IBOutlet weak var view1: UIView!
    @IBAction func hide1(sender: AnyObject) {
        
        view1.hidden = true
        view.backgroundColor = UIColor.whiteColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var trackIcon: UIButton!
    
    @IBAction func sendPackage(sender: AnyObject) {
        
        //PICKUP ADDRESS AND DROP OFF ADDRESS SHOULD BE AUTOCOMPLETED BUT GOOGLE'S AUTOCOMPLETE API FOR IOS/SWIFT IS DEPRICATED SO HAD TO HARD CODE THE ADDRESS ALSO POSTMATE'S API REQUIRE A VALID ADDRESS TO MAKE POST CALL
        trackIcon.enabled = true

        Dataservice.ds.postDelivery("101 Market St, San Francisco, CA", pickup_address: "20 McAllister St, San Francisco, CA", pickup_name: pickupName.text!, pickup_phone_number: "415-555-8484", dropoff_name: dropoffname.text!, dropoff_phone_number: "415-555-8484", maifes: manifest.text!)
        
        view1.hidden = false
        view.backgroundColor = UIColor.grayColor()
        emptyTextField(manifest)
        emptyTextField(pickupName)
        emptyTextField(pickupAdd)
        emptyTextField(pickupNum)
        emptyTextField(dropOffNum)
        emptyTextField(dropoffname)
        emptyTextField(dropOffAdd)
    }
    
    func emptyTextField(te: UITextField){
        te.text = ""
        
    }
    

}
