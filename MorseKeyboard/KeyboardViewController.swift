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

        self.nextKeyboardButton = self.view.viewWithTag(2) as UIButton
        self.nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)

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

    func timerFired(timer: NSTimer) {
        self.letterFinished()
    }

    func letterFinished() {

        if let letter = intepretDahDitSequence(dahDitSequence) {
            var proxy = textDocumentProxy as UITextDocumentProxy
            proxy.insertText("\(letter)")
        }

        dahDitSequence = []
        self.dahDitLabel.text = ""
    }

    func intepretDahDitSequence(sequence: Bool[]) -> Character? {

        var letter:Character?

        /* fancy pattern matching */
        switch dahDitSequence {
            case [true,false]: letter = "A"
            case [false,true,true,true]: letter = "B"
            case [true]: letter = "E"
            case [true,true,true]: letter = "S"
            case [false,false,false]: letter = "O"
            default:
                letter = nil
        }
        
        return letter
    }

}
