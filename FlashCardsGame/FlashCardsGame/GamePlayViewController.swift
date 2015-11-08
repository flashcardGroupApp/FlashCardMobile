//
//  gamePlayViewController.swift
//  FlashCardsGame
//
//  Created by Kelly Robinson on 11/4/15.
//  Copyright © 2015 Paul Vagner. All rights reserved.
//

import UIKit

class GamePlayViewController: UIViewController, UITextFieldDelegate  {
    
    @IBOutlet weak var combatImageView: UIImageView!
    @IBOutlet weak var restartLabel: UILabel!
    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var droidLabel: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    
    var timer: NSTimer?
    var seconds = 30
    var count = 0
    var hardMode: Bool = false
    var deckID: Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    
    var cards: [[String:AnyObject]] = []
    var currentCard: Int = 0
    
    func setupGame()  {
        seconds = 30
        count = 0
        
        timerLabel.text = "Time: \(seconds)"

    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let topScore = GameData.mainData().topScore
        
        // make request for cards using deckID

        var info = RequestInfo()
        
        info.endpoint = "/decks/6/cards"
        info.method = .GET
        
        
        RailsRequest.session().requiredWithInfo(info) { (returnedInfo) -> () in
            
            if let cards = returnedInfo as? [[String:AnyObject]] {
                
                self.cards = cards
                self.populateQuestionLabel()
                
            }
            
        }
        
        answerTextField!.layer.borderWidth = 10
        answerTextField!.layer.borderColor = UIColor.blackColor().CGColor
        
        if hardMode {
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("subtractTime"), userInfo: nil, repeats: true)
        }
        
        print("timer created")
        
    }
    
    func populateQuestionLabel() {
        
        // set question label to the question of the current card
        questionLabel.text = cards[currentCard]["question"] as? String
        
    }
    
    @IBAction func okayButton(sender: AnyObject) {

        // if on last card ... alert user game over and go back to deck choice
        
        // if correct answer add to currentScore (on singleton)
        
        let answer = cards[currentCard]["answer"] as! String
        let guess = answerTextField.text ?? ""
        
        
        if answer == guess {
            
            // if answer is true
            currentCard++
            populateQuestionLabel()
            
        } else {
            
            // do something since they failed
            
        }
        
    }
    
    
    @IBAction func resetButton(sender: AnyObject) {
        
        let gamePlayVC = storyboard?.instantiateViewControllerWithIdentifier("gameVC") as! FlashGameViewController
        
        self.presentViewController(gamePlayVC, animated:true, completion:nil)
        
    }
    


    func subtractTime() {
        
        
        seconds--
        timerLabel.text = "Time: \(seconds)"
        
        if(seconds == 0)  {
            
            timer?.invalidate()
            endGame()
            
            
     
        }
        
        print("boom")
    }
    
    func endGame() {
        
        let gamePlayVC = storyboard?.instantiateViewControllerWithIdentifier("gameVC") as! FlashGameViewController
        
        self.presentViewController(gamePlayVC, animated:true, completion:nil)
        
    }
    
  
}
 
    
            
    






