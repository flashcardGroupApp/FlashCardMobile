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
  
     
    @IBAction func mainButton(sender: MainButton) {
        
        let gamePlayVC = storyboard?.instantiateViewControllerWithIdentifier("gamePlayVC") as! GamePlayViewController
        
        switch sender.tag {
        
        case SelectedButtonTag.First.rawValue: 0
            print("do something when first button is tapped")
        
        case SelectedButtonTag.Second.rawValue: 1
            print("do something when second button is tapped")
        
        case SelectedButtonTag.Third.rawValue: 2
            print("do something when third button is tapped")
        
        case SelectedButtonTag.Fourth.rawValue: 3
        print("do something when third button is tapped")
        
        default:
            print("default")
        }
        
        
        gamePlayVC.hardMode = hardModeSwitch.on
        
        // set hardmode property
        
        self.presentViewController(gamePlayVC, animated:true, completion:nil)
    }
   
}


        

     

    

