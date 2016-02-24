//
//  ViewController.swift
//  calculator
//
//  Created by Ness, Bruce (US - New York) on 2/14/16.
//  Copyright © 2016 ness bruce. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    // enum allows you to set your own data type; in this setting calc operations to the case values
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    
    @IBOutlet weak var outputLbl:UILabel!
    
    // make button noise a variable using built in audio player service
    var btnSound: AVAudioPlayer!
    
    // Current number in the calc screen
    var runningNumber = ""
    // First number before operation
    var leftValStr = ""
    // Second "...."
    var rightValStr = ""
    // Current operation either / * + or -
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Get path of button.wav
        let path = NSBundle.mainBundle().pathForResource("btn", ofType:"wav")
        
        // let creates constant of soundURL
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        // tyr/catch to get sound and prepare it otherwise print error
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        
        runningNumber += "\(btn.tag)" // takes object tag name as variable
        outputLbl.text = runningNumber
    }
    
    

    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }

    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            // Run some math
            
            // if runningNumber is not empty
            // Otherwise user selected an operator twice instead of
            // first entering another runnningNumber
            if runningNumber != "" {
                
                rightValStr = runningNumber
                runningNumber = ""
            
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                
                leftValStr = result
                outputLbl.text = result
                
            }
            
            currentOperation = op

            
        } else {
            // Evaluates that this is the first time they are typing on calculator
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
        
    }
    
    
    // encapsulates button sound
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
}

