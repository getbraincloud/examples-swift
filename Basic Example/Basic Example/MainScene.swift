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
        
        view.addGestureRecognizer(
            UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
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
        if(sender.selectedSegmentIndex == 0) {
            //
        } else if(sender.selectedSegmentIndex == 1) {
            AppDelegate._bc.playerStateService.logout(nil, errorCompletionBlock: nil, cbObject: nil);
            
            AppDelegate._bc.getBCClient().authenticationService.clearSavedProfile();
            AppDelegate._bc.storedAnonymousId = "";
            AppDelegate._bc.storedProfileId = "";
            
            UserDefaults.standard.set(false, forKey: "HasAuthenticated")
            
            self.performSegue(withIdentifier: "onLogout", sender: nil)
        }
    }
    
    
    
    
    
    /**
        Push Notifications
 
     */
    
    @IBOutlet weak var deviceToken: UILabel!
    
    @IBAction func OnRegisterPushNotificationsClicked(_ sender: Any) {
        
      //  const char * token = "grnuo234gf89vrn2v789h24gf2gmk583490jgn0er";
        
       // _bc->getPushNotificationService()->
         //   registerPushNotificationDeviceToken(Platform::iOS, token, this);
    }
    
    @IBAction func OnDeregisterPushNotificationsClicked(_ sender: Any) {
    }
    
    @IBAction func OnSendPushNotificationsClicked(_ sender: Any) {
    
    }
    
}

