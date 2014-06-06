//
//  KeyboardViewController.swift
//  MorseKeyboard
//
//  Created by Steffen on 03.06.14.
//  Copyright (c) 2014 Steffen. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var dahDitLabel: UILabel
    @IBOutlet var nextKeyboardButton: UIButton

    var touchedDown:NSTimeInterval = 0.0
    var touchedUp:NSTimeInterval = 0.0
    var dahDitSequence:Bool[] = []
    var letterTimer:NSTimer?

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {

        self.view = NSBundle.mainBundle().loadNibNamed("KeyboardView", owner: self.view, options: nil)[0] as UIView

        self.dahDitLabel = self.view.viewWithTag(1) as UILabel
//        self.dahDitLabel.text = "···−−−···"

        self.nextKeyboardButton = self.view.viewWithTag(2) as UIButton
        self.nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)

//        // Perform custom UI setup here
//        self.nextKeyboardButton = UIButton.buttonWithType(.System) as UIButton
//    
////        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
//        self.nextKeyboardButton.sizeToFit()
//        self.nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
//    
//        self.nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
//        
//        self.view.addSubview(self.nextKeyboardButton)
//    
//        var nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0)
//        var nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
//        self.view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])


//

        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput) {
        // The app has just changed the document's contents, the document context has been updated.
    
        var textColor: UIColor
        var proxy = self.textDocumentProxy as UITextDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
//        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }

    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {

        let touch = touches.anyObject() as UITouch
        touchedDown = touch.timestamp

        if (touchedUp < 0.1) {
            return
        }

        let pauseLength = touchedDown - touchedUp

        //        println("pause: \(pauseLength)")

        letterTimer?.invalidate()
    }

    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        let touch = touches.anyObject() as UITouch

        touchedUp = touch.timestamp;
        let touchLength = touchedUp - touchedDown

        let dit = touchLength < 0.15

        dahDitSequence.append(dit)

        let symbol = dit ? "·" : "−"

        self.dahDitLabel.text = self.dahDitLabel.text + symbol

        letterTimer = NSTimer.scheduledTimerWithTimeInterval(0.5,target: self, selector: "timerFired:", userInfo: nil, repeats: false)

    }

    func letterFinished() {

        let letter = self.intepretDahDitSequence(dahDitSequence)
//        println(" =  \(letter)")
//        inputTextField.text = inputTextField.text + letter

        var proxy = self.textDocumentProxy as UITextDocumentProxy

        dahDitSequence = []
        self.dahDitLabel.text = ""
    }

    func timerFired(timer: NSTimer) {
        self.letterFinished()
    }

    func intepretDahDitSequence(sequence: Bool[]) -> Character {

        var letter:Character?

        /* fancy pattern matching */
        switch dahDitSequence {
            case [true,false]: letter = "A"
            case [false,true,true,true]: letter = "B"
            case [true]: letter = "E"
            case [true,true,true]: letter = "S"
            case [false,false,false]: letter = "O"
            default:
                letter = "^"
        }
        
        return letter!
    }

}
