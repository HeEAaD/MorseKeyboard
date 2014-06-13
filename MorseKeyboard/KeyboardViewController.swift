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
    @IBOutlet var spaceButton: UIButton
    @IBOutlet var returnButton: UIButton
    @IBOutlet var delButton: UIButton

    var touchedDown:NSTimeInterval = 0.0
    var touchedUp:NSTimeInterval = 0.0
    var morseSequence: MorseSequence = MorseSequence()
    var pauseTimer:NSTimer?
    var typedTextDocumentProxy: UITextDocumentProxy {
        return textDocumentProxy as UITextDocumentProxy
    }

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()

        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {

        view = NSBundle.mainBundle().loadNibNamed("KeyboardView", owner: view, options: nil)[0] as UIView

        dahDitLabel = view.viewWithTag(1) as UILabel

        nextKeyboardButton = view.viewWithTag(2) as UIButton
        nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)

        spaceButton = view.viewWithTag(3) as UIButton
        spaceButton.addTarget(self, action: "spaceButtonTouched", forControlEvents: .TouchUpInside)

        returnButton = view.viewWithTag(4) as UIButton
        returnButton.addTarget(self, action: "dismissKeyboard", forControlEvents: .TouchUpInside)

        delButton = view.viewWithTag(5) as UIButton
        delButton.addTarget(self, action: "delButtonTouched", forControlEvents: .TouchUpInside)

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

        pauseTimer?.invalidate()
        
        let touch = touches.anyObject() as UITouch
        touchedDown = touch.timestamp

        if (touchedUp < 0.1) {
            return
        }

        let pauseLength = touchedDown - touchedUp
        let context = typedTextDocumentProxy.documentContextBeforeInput

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
            typedTextDocumentProxy.insertText("\(letter)")
        }

        morseSequence.clear()
        dahDitLabel.text = ""
    }

    func spaceButtonTouched() {
        typedTextDocumentProxy.insertText(" ")
    }

    func delButtonTouched() {
        typedTextDocumentProxy.deleteBackward()
    }
}
