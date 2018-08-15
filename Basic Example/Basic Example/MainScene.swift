//
//  ViewController.swift
//  Basic Example
//
//  Created by brainCloud Support on 2018-08-14.
//  Copyright © 2018 brainCloud Support. All rights reserved.
//

import UIKit

class MainScene: UIViewController {
    
    @IBOutlet var test: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var entityId: UITextField!
    @IBOutlet weak var entityType: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    
    @IBOutlet weak var entityLog: UITextView!
    
    @IBAction func onCreateEntity(_ sender: Any) {
        let jsonData = "{ \"name\": \"\(name)\", \"age\": \"\(age)\" }"
        let jsonAcl = "{ \"other\": 0 }"
        
        AppDelegate._bc.entityService.createEntity("Person", jsonEntityData: jsonData, jsonEntityAcl: jsonAcl,
                                                   completionBlock: { (serviceName, serviceOperation, jsonData, cbObject) in
                                                    print("Success \(String(describing: jsonData))")
                                                          self.entityLog.text = "\nSuccess \(String(describing: jsonData))"
                                                    
                                                    
                                                    
                                                    
        },
                                                   errorCompletionBlock: { (serviceName, serviceOperation, statusCode, reasonCode, jsonError, cbObject) in
                                                    print("Failure \(String(describing: serviceName))")
                                                    
                                                    self.entityLog.text = "\nFailure \(String(describing: jsonError))"
                                                    
                                                    
                                                    
        }, cbObject: nil)
    
    }
    
    @IBAction func onDeleteEntity(_ sender: Any) {
    }
    
    @IBOutlet weak var entityMenu: UIStackView!
    @IBOutlet weak var pushNotificationMenu: UIStackView!
    
    @IBAction func onChangeMenu(_ sender: UISegmentedControl) {
        if(sender.state.rawValue == 0) {
            entityMenu.isHidden = false;
            pushNotificationMenu.isHidden = true;
        } else if(sender.state.rawValue == 1) {
            entityMenu.isHidden = true;
            pushNotificationMenu.isHidden = false;
        }
    }
    
}

