//
//  Dataservice.swift
//  Trackr
//
//  Created by sagaya Abdulhafeez on 27/06/2016.
//  Copyright © 2016 sagaya Abdulhafeez. All rights reserved.
//

import Foundation
import Firebase

let URL_BASE = "https://trackr123.firebaseio.com/"

class Dataservice {
    static let ds = Dataservice()
    private var _REF_BASE = Firebase(url: "\(URL_BASE)")
    
    var pickUpAdress: String?
    var lat = ""
    var long = ""
    var id = ""
    
    var REF_BASE: Firebase{
        return _REF_BASE
    }
    
    
    func postDelivery(dropoff_address: String, pickup_address: String, pickup_name: String, pickup_phone_number: String, dropoff_name: String, dropoff_phone_number:String, maifes: String){
        let urlString = "\(DELIVERY_URL)deliveries"
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.setValue("Basic MmNjNGNlMGQtZjJjNS00ZDgxLWIwM2UtODg3ODk4ZGMyNmE5Og==", forHTTPHeaderField: "Authorization")
        let postString = "dropoff_address=\(dropoff_address)&pickup_address=\(pickup_address)&pickup_name=\(pickup_name)&pickup_phone_number=\(pickup_phone_number)&dropoff_name=\(dropoff_name)&dropoff_phone_number=\(dropoff_phone_number)&manifest=\(maifes)"
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            
            if error != nil{
                print("d")
            }
            
            do{
                
                var json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                
                if let parseJson = json as? NSDictionary{
                    
                    if let dropoff = parseJson["dropoff"] as? NSDictionary{
                       if let location = dropoff["location"] as? NSDictionary{
                        if let lat = location["lat"] as? Double, long = location["lng"] as? Double{
                            print("Longitude:\(long) Latitude=\(lat)")
                            self.trackDelivery(lat, long: long)
                            self.pickUpAdress = pickup_address
                        }
                        
                        }
                    }
                }
                
            }catch{
                print("dd")
            }
            
        }
        task.resume()
        
    }
    
    func trackDelivery(lat: Double, long: Double){
        
    }
    
    
    
}