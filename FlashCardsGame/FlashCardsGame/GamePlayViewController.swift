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
    
    /// creates a variable of "timer" and sets it as NSTimer
    var timer: NSTimer?
    
    /// creates a variable of seconds and sets it to 30
    var seconds = 30
    
    /// creates a variable of count and sets it to 0
    var count = 0
    
    /// creates variable of hardMode of type Bool and sets it to false (Bool is only true/false)
    var hardMode: Bool = false
    
    /// creates variable of deckID of type Int and sets it to 0
    var deckID: Int = 0
    
    /// creates a visual outlet called "questionLabel" of type UILabel (which is force-unwrapped)
    @IBOutlet weak var questionLabel: UILabel!
   
    /// creates a visual outlet called "answerTextField" of type UITextField (shich is force-unwrapped)
    @IBOutlet weak var answerTextField: UITextField!
    
    /// creates variable cards of type Dictionary and sets it to an EMPTY Array
    var cards: [[String:AnyObject]] = []
    
    /// creates a variable currentCard of type Int and sets it to 0
    var currentCard: Int = 0
    
    

    func setupGame()  {
        
        /**
        sets the seconds to 30 as part of the setupGame
        */
        seconds = 30
        
        /**
        sets the count to 0 as part of the setupGame
        */
        count = 0
        
        /**
        sets the "timerLabel.text" to String of "Time: injected with \(seconds) parameter.
        */
        timerLabel.text = "Time: \(seconds)"

    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        let answer = cards[currentCard]["answer"] as! String
        if let guess = textField.text {
            
            
        if guess == answer {
            
            currentCard++
            
            populateQuestionLabel()
            
            
            }
           
            
        }
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GameData.mainData().correctCards = 0
        
        answerTextField.delegate = self
        
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
            GameData.mainData().correctCards++
            populateQuestionLabel()
            answerTextField.text = ""
            
        } else {
            
            // do something since they failed
            
        }
        
    }
    
    
    @IBAction func resetButton(sender: AnyObject) {
        
        let gamePlayVC = storyboard?.instantiateViewControllerWithIdentifier("gameVC") as! FlashGameViewController
        
        self.presentViewController(gamePlayVC, animated:true, completion:nil)
        
    }
    

    /**
     creates the timer function that counts down.
     */
    func subtractTime() {
        /**
        *  Operates the timer
        *
        *  @param seconds counts down the seconds
        *
        *  @return timerLabel with the seconds
        */
        
        seconds--
        timerLabel.text = "Time: \(seconds)"
        /**
        *  If the timer reaches 0 then timer stops and "endGame" condition is tripped.
        */
        if(seconds == 0)  {
            
            timer?.invalidate()
            endGame()
            
            
     
        }
        
        print("boom")
    }
    /**
     Sets up when game ends the user is taken back to the "FlashGameViewController"
     */
    func endGame() {
 /// This returns the user to the "FlashGameViewController"
        let gamePlayVC = storyboard?.instantiateViewControllerWithIdentifier("gameVC") as! FlashGameViewController
        /**
        *  Presents the "FlashGameViewController"
        */
        self.presentViewController(gamePlayVC, animated:true, completion:nil)
        
    }
    
  
}
 
    
            
    






