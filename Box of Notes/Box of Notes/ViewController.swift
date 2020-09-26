//
//  ViewController.swift
//  Box of Notes
//
//  Created by Dizzi on 9/11/20.
//

import UIKit

class ViewController: UIViewController {
    var messageController : MessageViewController?
    
    
    //date and calendar setup
    var date = Date()
    var calendar = Calendar.current
    
    //time variable setups
    var min = 0
    var sec = 0
    var month = 0
    var hour = 0
    
    //other variables
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    let messages = ["hi there! you're looking at message #1", "you're looking at message #2!"]
    var amPmHour = 0
    var editedMinute = ""
    var editedSecond = ""
    var tmC : CGFloat = 0
    var dtC : CGFloat = 0
    let textMove : CGFloat = 30
    var currentMessage = 0
    var outOfMessages = false
    var messageUpdated = false
    
    
    override func viewWillAppear(_ animated: Bool) {
        _ = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: update)
        tmC = timeConstraintOutlet.constant
        dtC = dateConstraintOutlet.constant
        
        timeConstraintOutlet.constant -= textMove
        dateConstraintOutlet.constant -= textMove
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        timeConstraintOutlet.constant = tmC
        dateConstraintOutlet.constant = dtC
        
        UIView.animate(withDuration: 2,
                       delay: 0,
                       options: [.curveEaseOut],
                       animations: { [weak self] in self?.view.layoutIfNeeded()}, completion: nil)
        
        
 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageController = MessageViewController()
        //self.view.layer.removeAllAnimations()
        
    }
    
    //outlets
    @IBOutlet weak var dateOutlet: UILabel!
    @IBOutlet weak var timeOutlet: UILabel!
    @IBOutlet weak var dateConstraintOutlet: NSLayoutConstraint!
    @IBOutlet weak var timeConstraintOutlet: NSLayoutConstraint!
    @IBAction func messageButtonAction(_sender: UIButton){
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is MessageViewController
        {
            let vc = segue.destination as? MessageViewController
            if (outOfMessages == false) {
                vc?.messageString = messages[currentMessage]
            } else {
                vc?.messageString = "Out of messages!"
            }
        }
    }
    
    //update the labels on screen
    func update(a : Timer) {
        min = calendar.component(.minute, from: date)
        hour = calendar.component(.hour, from: date)
        sec = calendar.component(.second, from: date)
        month = calendar.component(.month, from: date)
        date = Date()
        
        //print("updating" + String(sec))
        
        if (hour > 12) {
            amPmHour = hour - 12
        } else {
            amPmHour = hour
        }
        
        if (min < 10) {
            editedMinute = "0" + String(min)
        } else {
            editedMinute = String(min)
        }
        
        if (sec < 10) {
            editedSecond = "0" + String(sec)
        } else {
            editedSecond = String(sec)
        }
        
        timeOutlet.text = "It's currently \(amPmHour):\(editedMinute):\(editedSecond)"
        dateOutlet.text = "Today is \(months[month-1]) \(calendar.component(.day, from: date)), \(calendar.component(.year, from: date))"
        
        
        if (sec != 0) { messageUpdated = false }
        
        if (sec == 0 && messageUpdated == false) {
            if (currentMessage < messages.count - 1) {
                currentMessage += 1
                messageUpdated = true
            } else {
                outOfMessages = true
            }
        }
        
        
        
    }
    
}
