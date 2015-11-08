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
        
    }
    
    override func viewDidAppear(animated: Bool) {
    
        
        
        self.navigationController?.navigationBarHidden = true
        
        var info = RequestInfo()
        
        info.endpoint = "/decks"
        
        info.method = .GET
        
        
        RailsRequest.session().requiredWithInfo(info) { (returnedInfo) -> () in
            
            print(returnedInfo)
            
            //sets the deck with "title" information gathered from server
            if var decks = returnedInfo as? [[String:AnyObject]] {
                
                decks = decks.sort{ (_, _) -> Bool in arc4random() % 2 == 0 }
                
                let deck1 = decks[0]
                
                self.firstDeck?.setTitle(deck1["title"] as? String, forState: .Normal)
                
                let deck2 = decks[1]
                
                self.secondDeck?.setTitle(deck2["title"] as? String, forState: .Normal)
             
                let deck3 = decks[2]
                
                self.thirdDeck?.setTitle(deck3["title"] as? String, forState: .Normal)
                
                let deck4 = decks[3]
                
                self.fourthDeck?.setTitle(deck4["title"] as? String, forState: .Normal)
            }
            
            
            if let errors = returnedInfo?["errors"] as? [String] {
                
                //loops through errors
            }
            
        }

    }
    
    @IBAction func switchSlider(sender: AnyObject) {
    
    }

    
    @IBAction func pressedButton(sender: AnyObject) {
        
        let gamePlayVC = storyboard?.instantiateViewControllerWithIdentifier("gamePlayVC") as! gamePlayViewController
        
        // set hardmode property
        
        self.presentViewController(gamePlayVC, animated:true, completion:nil)
     
    }
    
}
