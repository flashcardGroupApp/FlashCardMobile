//
//  flashGameViewController.swift
//  FlashCardsGame
//
//  Created by Kelly Robinson on 11/4/15.
//  Copyright © 2015 Paul Vagner. All rights reserved.
//

import UIKit


class FlashGameViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!

    @IBOutlet weak var firstDeck: MainButton!

    @IBOutlet weak var secondDeck: MainButton!
    
    @IBOutlet weak var cakeWalkView: UIImageView!
    
    @IBOutlet weak var crazySmileView: UIImageView!
    
    @IBOutlet weak var thirdDeck: MainButton!
    
    @IBOutlet weak var fourthDeck: MainButton!
    
    @IBOutlet weak var threeMonkeysView: UIImageView!
    
    @IBOutlet weak var hardModeSwitch: UISwitch!
    
    var score: Int = 0
    
    var seconds = 30
    
    var count = 0
    
    enum SelectedButtonTag: Int {
    
        case First
        
        case Second
        
        case Third
        
        case Fourth
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        
    }
 
    
    override func viewDidAppear(animated: Bool) {
    
        // update score from singleton
        
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
//                
//                let numString = deck1["id"] as? String
//                if let
                
                let deckId = deck1["id"] as? Int
                
//                let callInt = Int(deckId!)
                
                
                self.firstDeck?.tag = deckId!
            
                // set tag = deck["id"]
                
                let deck2 = decks[1]
                
                self.secondDeck?.setTitle(deck2["title"] as? String, forState: .Normal)
                
                let deckId1 = deck2["id"] as? Int
                
//                let callInt1 = Int(deckId1!)
                
                self.secondDeck?.tag = deckId1!
                
             
                let deck3 = decks[2]
                
                self.thirdDeck?.setTitle(deck3["title"] as? String, forState: .Normal)
                
                let deckId2 = deck3["id"] as? Int
                
//                let callInt2 = Int(deckId2!)
                
                
                self.thirdDeck?.tag = deckId2!
                
                let deck4 = decks[3]
                
                self.fourthDeck?.setTitle(deck4["title"] as? String, forState: .Normal)
                
                let deckId3 = deck4["id"] as? Int
                
//                let callInt3 = Int(deckId3!)
                
                
                self.fourthDeck?.tag = deckId3!
            }
            
            
            if let errors = returnedInfo?["errors"] as? [String] {
                
                //loops through errors
            }
            
        }
        
        

    }
  
     
    @IBAction func mainButton(sender: MainButton) {
        
        let gamePlayVC = storyboard?.instantiateViewControllerWithIdentifier("gamePlayVC") as! GamePlayViewController
        
        gamePlayVC.deckID = sender.tag
        
        gamePlayVC.hardMode = hardModeSwitch.on
        
        // set hardmode property
        
        self.presentViewController(gamePlayVC, animated:true, completion:nil)
    }
   
}


        

     

    

