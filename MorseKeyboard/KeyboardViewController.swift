//
//  KeyboardViewController.swift
//  MorseKeyboard
//
//  Created by Steffen on 03.06.14.
//  Copyright (c) 2014 Steffen. All rights reserved.
//

import UIKit

let ditTime = 0.15

class KeyboardViewController: UIInputViewController {

    @IBOutlet var dahDitLabel: UILabel
    @IBOutlet var nextKeyboardButton: UIButton

    var touchedDown:NSTimeInterval = 0.0
    var touchedUp:NSTimeInterval = 0.0
    var morseSequence: MorseSequence = MorseSequence()
    var pauseTimer:NSTimer?

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

        if pauseLength > ditTime * 7 {
            var proxy = textDocumentProxy as UITextDocumentProxy
            proxy.insertText(" ")
        }

        pauseTimer?.invalidate()
    }

    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        let touch = touches.anyObject() as UITouch

        touchedUp = touch.timestamp;
        let touchLength = touchedUp - touchedDown

        let symbol: MorseSymbol = (touchLength < ditTime) ? .Dit : .Dah

        morseSequence.append(symbol)

        dahDitLabel.text = dahDitLabel.text + symbol.toRaw()

        pauseTimer = NSTimer.scheduledTimerWithTimeInterval(0.5,target: self, selector: "pauseTimerFired:", userInfo: nil, repeats: false)

    }

    func pauseTimerFired(timer: NSTimer) {
        self.letterFinished()
    }

    func letterFinished() {

        if let letter = morseSequence.intepretation {
            var proxy = textDocumentProxy as UITextDocumentProxy
            proxy.insertText("\(letter)")
        }

        morseSequence.clear()
        dahDitLabel.text = ""
    }

}
