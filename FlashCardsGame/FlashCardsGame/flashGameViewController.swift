//
//  flashGameViewController.swift
//  FlashCardsGame
//
//  Created by Kelly Robinson on 11/4/15.
//  Copyright © 2015 Paul Vagner. All rights reserved.
//

import UIKit

class flashGameViewController: UIViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var info = RequestInfo()
        
        info.endpoint = "/cards"
        
        info.method = .POST
        
        
        RailsRequest.session().requiredWithInfo(info) { (returnedInfo) -> () in
            
            if let cards = returnedInfo?["cards"] as? [[String:AnyObject]] {
                
               
            }
            
            
            if let errors = returnedInfo?["errors"] as? [String] {
                //loops through errors
            }
            
        }

        // Do any additional setup after loading the view.
    }

 
    

}
