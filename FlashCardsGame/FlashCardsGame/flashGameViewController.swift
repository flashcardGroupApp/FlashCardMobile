//
//  flashGameViewController.swift
//  FlashCardsGame
//
//  Created by Kelly Robinson on 11/4/15.
//  Copyright © 2015 Paul Vagner. All rights reserved.
//

import UIKit

class flashGameViewController: UIViewController {
    
    @IBOutlet weak var firstDeck: MainButton!
    
    @IBOutlet weak var secondDeck: MainButton!
    
    @IBOutlet weak var thirdDeck: MainButton!
   
    @IBOutlet weak var fourthDeck: MainButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var info = RequestInfo()
        
        info.endpoint = "/decks"
        
        info.method = .GET
        
        
        RailsRequest.session().requiredWithInfo(info) { (returnedInfo) -> () in
            
            if let decks = returnedInfo?["decks"] as? [[String:AnyObject]] {
                
                
               
            }
            
            
            if let errors = returnedInfo?["errors"] as? [String] {
                //loops through errors
            }
            
        }

        // Do any additional setup after loading the view.
    }
    

    @IBAction func pressedButton(sender: AnyObject) {

        let flashGameViewController = storyboard?.instantiateViewControllerWithIdentifier("gamePlayVC") as! gamePlayViewController
        
        self.presentViewController(flashGameViewController, animated:true, completion:nil)
     
    }
    
}
