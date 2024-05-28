//
//  ViewController.swift
//  Basic Example
//
//  Created by brainCloud Support on 2018-08-14.
//  Copyright © 2018 brainCloud Support. All rights reserved.
//

import UIKit

class ForgotScene: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(
            UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var InfoLabel: UILabel!
    
    @IBAction func OnRequestResetClicked(_ sender: Any) {
        AppDelegate._bc.getBCClient().authenticationService.resetEmailPassword(
            Email.text,
            withCompletionBlock: nil,
            errorCompletionBlock: nil,
            cbObject: nil)
        
        InfoLabel.isHidden = false;
    }
    
}

