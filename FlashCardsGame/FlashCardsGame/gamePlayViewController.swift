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
    var seconds = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    

    
    @IBOutlet weak var answerTextField: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        
        print("timer created")
        
    
        
    }
    
    @IBAction func okayButton(sender: AnyObject) {
        
    }
    
    
    
    
    
    func update() {
        
        seconds++
        
        timerLabel.text = "\(seconds)"
        
        if seconds == 10 {
            
            timer?.invalidate()
         
//            timerLabel.text = ""
            
        }
        
        print("boom")
        
      
    

    }
 
    
            
    
}


        // Do any additional setup after loading the view.



