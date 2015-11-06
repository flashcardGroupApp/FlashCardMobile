//
//  flashGameViewController.swift
//  FlashCardsGame
//
//  Created by Kelly Robinson on 11/4/15.
//  Copyright © 2015 Paul Vagner. All rights reserved.
//

import UIKit

class flashGameViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var firstDeck: MainButton!
    @IBOutlet weak var secondDeck: MainButton!
    @IBOutlet weak var thirdDeck: MainButton!
    @IBOutlet weak var fourthDeck: MainButton!
    
    var totalTime: NSTimeInterval = 0
    var seconds = 30
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        scoreLabel.text = "Time: \(totalTime)"
        
        
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
    
    @IBAction func switchSlider(sender: AnyObject) {
    }

    @IBAction func pressedButton(sender: AnyObject) {
        
        

//        let storyBoard: UIStoryboard = UIStoryboard(name: "flashGameViewController", bundle:nil)
        
        let gamePlayVC = storyboard?.instantiateViewControllerWithIdentifier("gamePlayVC") as! gamePlayViewController
        
        self.presentViewController(gamePlayVC, animated:true, completion:nil)
     
    }
    
}
