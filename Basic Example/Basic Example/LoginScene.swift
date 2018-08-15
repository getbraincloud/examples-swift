//
//  ViewController.swift
//  Basic Example
//
//  Created by brainCloud Support on 2018-08-14.
//  Copyright © 2018 brainCloud Support. All rights reserved.
//

import UIKit

class LoginScene: UIViewController {
    @IBOutlet weak var userId: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OnLoginClicked(_ sender: Any) {
        
        AppDelegate._bc.authenticateUniversal(userId.text,
                                             password: password.text,
                                             forceCreate: true,
                                             completionBlock: { (serviceName, serviceOperation, jsonData, cbObject) in
                                                print("Success \(String(describing: jsonData))")
                                                
                                                
                                                self.performSegue(withIdentifier: "onLogin", sender: nil)
                                                
                                                self.loginError.text = ""
                                                
        },
                                             errorCompletionBlock: { (serviceName, serviceOperation, statusCode, reasonCode, jsonError, cbObject) in
                                                print("Failure \(String(describing: serviceName))")
                                                
                                                self.loginError.text = "Login Error \(String(describing: reasonCode))"
                                                
                                                
                                                
                                                
                                                
        }, cbObject: nil)
    }
    
}

