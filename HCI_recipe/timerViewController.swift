//
//  TimerViewController.swift
//  HCI_recipe
//
//  Created by Jie Tan on 2/22/16.
//  Copyright © 2016 Jie Tan. All rights reserved.
//

import UIKit

class timerViewController: UIViewController {
    
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var pauseButton: UIButton!
    
    var totalTime = 0
    var timer = NSTimer()
    var isCounting = false
    var remainingSeconds = 0
    
    
    @IBAction func pause_resume(sender: AnyObject) {
        if isCounting==false{
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: ("updateTimer"), userInfo: nil, repeats: true)
            isCounting = true
            pauseButton.setImage(UIImage(named: "pause timer"), forState: UIControlState.Normal)
            
        }
        else{
            pauseButton.setImage(UIImage(named: "start timer"), forState: UIControlState.Normal)
            isCounting = false
            timer.invalidate()
        }
    }
    
    
    @IBAction func reset(sender: AnyObject) {
        timer.invalidate()
        remainingSeconds = totalTime*60
        isCounting = false
        let mins = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        timerLabel.text = NSString(format: "%02d:%02d", mins, seconds) as String
        pauseButton.setImage(UIImage(named: "start timer"), forState: UIControlState.Normal)
        
    }
    
    func updateTimer(){
        remainingSeconds = remainingSeconds-1
        let mins = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        timerLabel.text = NSString(format: "%02d:%02d", mins, seconds) as String
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        remainingSeconds = totalTime*60
        let mins = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        timerLabel.text = NSString(format: "%02d:%02d", mins, seconds) as String
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
