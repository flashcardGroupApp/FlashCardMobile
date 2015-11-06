////
////  LoginViewController.swift
////  Login
////
////  Created by Paul Vagner on 10/15/15.
////
////  Copyright © 2015 Paul Vagner. All rights reserved.



import UIKit

import Foundation

class LoginViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var usernameField: UITextField!
    
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBOutlet weak var emailField: UITextField!
    
    
    @IBAction func pressedLogin(sender: AnyObject) {
        
        //is password field blank?
        guard let password = passwordField.text else { return }
        //is username field blank?
        guard let username = usernameField.text else { return }
        //if they aren't empty
        

        RailsRequest.session().loginWithUsername(username , andPassword: password)
        print("loged in pressed")
    
    }
    
    
    @IBAction func pressedRegister(sender: AnyObject) {
    
        guard let password = passwordField.text else { return }
        
        guard let username = usernameField.text else { return }
        
        guard let email = emailField.text else { return }
        
        //send request to server to create registration
        
        RailsRequest.session().registerWithUsername(username, andPassword: password, email: email)
        
        print("registered pressed")
            
        }
    
    }
    
