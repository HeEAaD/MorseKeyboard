//
//  ViewController.swift
//  Morse
//
//  Created by Steffen on 03.06.14.
//  Copyright (c) 2014 Steffen. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
                            
    @IBOutlet var inputTextField : UITextField

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.inputTextField.becomeFirstResponder()
    }

  }

