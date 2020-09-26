//
//  ViewController.swift
//  Box of Notes
//
//  Created by Dizzi on 9/11/20.
//

import UIKit

class MessageViewController: UIViewController {
    
    //date and calendar setup
    var date = Date()
    var calendar = Calendar.current
    
    //time variable setups
    var sec = 0
    
    //other variables
    
    var messageString : String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: update)
        self.view.layer.removeAllAnimations()
        
        messageOutlet.text = messageString
        
    }
    
    //outlets
    @IBOutlet weak var messageOutlet: UILabel!
    
    
    //update the labels on screen
    func update(a : Timer) {
        sec = calendar.component(.second, from: date)
        date = Date()
        
        print(sec)
        if (sec == 0) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
