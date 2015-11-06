//
//  gamePlayViewController.swift
//  FlashCardsGame
//
//  Created by Kelly Robinson on 11/4/15.
//  Copyright © 2015 Paul Vagner. All rights reserved.
//

import UIKit



class gamePlayViewController: UIViewController, UITextFieldDelegate  {
    
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var timer: NSTimer?
    var seconds = 30
    var count = 0
   
    
    
    @IBOutlet weak var questionLabel: UILabel!
    

    
    @IBOutlet weak var answerTextField: UITextField!
    
//    var count = 0
    
    func setupGame()  {
        seconds = 30
        count = 0
        
        timerLabel.text = "Time: \(seconds)"
//        scoreLabel.text = "Score: \(count)"
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("subtractTime"), userInfo: nil, repeats: true)
        
        print("timer created")
        
        
    
        
    }
    
    @IBAction func okayButton(sender: AnyObject) {

        
    }
    
    @IBAction func gameOver(sender: AnyObject) {
        
        
    }

    func subtractTime() {
        seconds--
        timerLabel.text = "Time: \(seconds)"
        
        if(seconds == 0)  {
            
            timer?.invalidate()
            
        }
        
        print("boom")
    }
    
    
    
    

    
    
       
      
    

    }
 
    
            
    






