//
//  ViewController.swift
//  Basic Example
//
//  Created by brainCloud Support on 2018-08-14.
//  Copyright © 2018 brainCloud Support. All rights reserved.

import UIKit

class MainScene: UIViewController {
    
    @IBOutlet var test: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBOutlet weak var entityId: UITextField!
    @IBOutlet weak var entityType: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    
    @IBOutlet weak var entityLog: UITextView!
    
    @IBAction func onCreateEntity(_ sender: Any) {
        let jsonData = "{ \"name\": \"\(name)\", \"age\": \"\(age)\" }"
        let jsonAcl = "{ \"other\": 0 }"
        
        AppDelegate._bc.entityService.createEntity("Person",
                                                   jsonEntityData: jsonData,
                                                   jsonEntityAcl: jsonAcl,
                                                   completionBlock: onCreateEntity,
                                                   errorCompletionBlock: onCreateEntityFailed,
                                                   cbObject: nil)
        
    }
    
    func onCreateEntity(serviceName:String?, serviceOperation:String?, jsonData:String?, cbObject: NSObject?) {
        print("Success \(String(describing: jsonData))")
        self.entityLog.text = "\nCreateEntity Success \(String(describing: jsonData))"
        
        let data = jsonData?.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: AnyObject]
            let entityIdData = json["data"]?["entityId"] as! String;
            let entityTypeData = json["data"]?["entityType"] as! String;
            
            self.entityId.text = entityIdData;
            self.entityType.text = entityTypeData;
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        
    }
    
    func onCreateEntityFailed(serviceName:String?, serviceOperation:String?, statusCode:Int?, reasonCode:Int?, jsonError:String?, cbObject: NSObject?) {
        self.entityLog.text = "\nCreateEntity Failed \(String(describing: jsonError))"
        
    }
    
    @IBAction func onDeleteEntity(_ sender: Any) {
        AppDelegate._bc.entityService.delete(entityId.text,
                                             version: -1,
                                             completionBlock: onDeleteEntity,
                                             errorCompletionBlock: onDeleteEntityFailed,
                                             cbObject: nil)
    }
    
    func onDeleteEntity(serviceName:String?, serviceOperation:String?, jsonData:String?, cbObject: NSObject?) {
        
        self.entityLog.text = "\nDeleteEntity Success \(String(describing: jsonData))"
        
        self.entityId.text = "";
        self.entityType.text = "";
    }
    
    func onDeleteEntityFailed(serviceName:String?, serviceOperation:String?, statusCode:Int?, reasonCode:Int?, jsonError:String?, cbObject: NSObject?) {
        self.entityLog.text = "\nDeleteEntity Failed \(String(describing: jsonError))"
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

