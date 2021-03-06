//
//  RailsRequest.swift
//  RR
//
//  Created by Paul Vagner on 11/5/15.
//  Copyright © 2015 Paul Vagner. All rights reserved.
//
//
//
// THIS WILL FUNCTION WITH ALL REQUESTS

import UIKit

private let _rr = RailsRequest()

private let _d = NSUserDefaults.standardUserDefaults()

class RailsRequest: NSObject {
   
    /**
     Creates a class function for the "RailsRequest"class
     
     - returns: the "RailsRequest"
     */
    class func session() -> RailsRequest { return _rr }
    
    /// The token captured after login/register used to make authenticated API calls.
    var token: String? {
        
        get { return _d.objectForKey("token") as? String }
        set { _d.setObject(newValue, forKey: "token") }
        
    }
    //will need out own server info
    private let APIbaseURL = "http://secret-shore-7735.herokuapp.com"
    
    /**
     This method will try to login a user with credentials below.
     
     - parameter username: The name used when registering.
     - parameter password: The password used when registering.
     */
    func loginWithUsername(username: String, andPassword password: String, completion: () -> ()) {
        
        var info = RequestInfo()
        
        info.endpoint = "/login"
        
        info.method = .POST
        
        info.parameters = [
            
            "username" : username,
            "password" : password
            
        ]

        requiredWithInfo(info) { (returnedInfo) -> () in
            
            if let user = returnedInfo?["user"] as? [String:AnyObject] {
                
                if let key = user["auth_token"] as? String {
                    
                    self.token = key
                    
                }
            }
            
            
            if let errors = returnedInfo?["errors"] as? [String] {
                //loops through errors
            }
            
            completion()
            
        }
        
    }
    
    /**
     Makes a generic request to the API, configured by the info parameter.
     
     - parameter info:       Used to configure the API request.
     - parameter completion: A completion black that may be calld with an optional object.
     The object could be an Array or Dictionary, YOU MUST handle the type within the completion black.
     */
    func registerWithUsername(username: String, andPassword password: String, email: String, completion: () -> ()) {
        
        var info = RequestInfo()
        
        info.endpoint = "/signup"
        
        info.method = .POST
        
        info.parameters = [
            
            "username" : username,
            "password" : password,
            "email" : email
            
        ]
        
        requiredWithInfo(info) { (returnedInfo) -> () in
            
            if let user = returnedInfo?["user"] as? [String:AnyObject] {
                
                print("user")
                
                if let key = user["auth_token"] as? String {
                    
                    self.token = key
                    
                }
            }
            
            
            if let errors = returnedInfo?["errors"] as? [String] {
                //loops through errors
            }
            
            completion()
            
        }
        
    }
    
    
    func requiredWithInfo(info: RequestInfo, completion: (returnedInfo: AnyObject?) -> ()) {
        
        let fullURLString = APIbaseURL + info.endpoint
        
        print(fullURLString)
        
        guard let url = NSURL(string: fullURLString) else { return } //add run completion with fail
        
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = info.method.rawValue
        
        
        
        //add token if we have one
        
        if let token = token {
            
            request.setValue(token, forHTTPHeaderField: "Access-Token")
            
            print(token)
            
        }
        
        if info.parameters.count > 0 {
        
            if let requestData = try? NSJSONSerialization.dataWithJSONObject(info.parameters, options: .PrettyPrinted) {
                
                if let jsonString = NSString(data: requestData, encoding: NSUTF8StringEncoding) {
                    
                    request.setValue("\(jsonString.length)", forHTTPHeaderField: "Content-Length")
                    
                    //possibly remove this line
                    let postData = jsonString.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
                    
                    request.HTTPBody = postData
                    
                }
                
            }
            
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //here we grab the access token & user id
        
        
        
        // add parameters to body
        
        //creates a task from request
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                
                print(data)
                print(error)
                
                //work with the data returned
                if let data = data {
                    
                    //have data
                    if let returnedInfo = try? NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) {
                        
                        print(returnedInfo)
                        completion(returnedInfo: returnedInfo)
                        
                    }
                    
                } else {
                    
                    //no data: check if error is not nil
                    
                }
                
                
            })
            
        }
        
        //runs the task (aka: makes the request call)
        task.resume()
    }
    
    
}

struct RequestInfo {
    
    enum MethodType: String {
        
        case POST, GET, DELETE
    }
    
    var endpoint: String!
    var method: MethodType = .GET
    var parameters: [String:AnyObject] = [:]
    
}



//RailsRequest.session()

