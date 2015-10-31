//
//  ViewController.swift
//  BullsEye
//
//  Created by 超平 谢 on 15/3/9.
//  Copyright (c) 2015年 超平 谢. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    var currentValue: Int = 0
    var targetValue: Int = 0
    var score = 0
    var round = 0
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, forState: .Normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        if let trackLeftImage = UIImage(named: "SliderTrackLeft"){
            let trackLeftResizable = trackLeftImage.resizableImageWithCapInsets(insets)
            slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        }
        
        if let trackRightImage = UIImage(named: "SliderTrackRight"){
            let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
            slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
        }
        
        startNewGame()
        updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert(){
        //var difference: Int
        let difference = abs(targetValue - currentValue)
        let points = 100 - difference
        
        score += points
        var title: String
        if difference == 0{
            title = "perfect"
        }else if difference < 5{
            title = "you almost had it"
        }else if difference < 10 {
            title = "pretty good!"
        }else{
            title = "not even close..."
        }
        
        
        
        let message = "You scored \(points) points"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "ok", style: .Default, handler: {action in
                                                                            self.startNewRound()
                                                                            self.updateLabels()})
        
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func sliderMoved(slider: UISlider){
        //println("the value if the slider is now: \(slider.value)")
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func startOver(){
        startNewGame()
        updateLabels()
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.addAnimation(transition, forKey: nil)
    }
    
    func startNewGame(){
        score = 0
        round = 0
        startNewRound()
    }
    
    func startNewRound(){
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
}

