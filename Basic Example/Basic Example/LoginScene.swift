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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func OnLoginClicked(_ sender: Any) {
        
        /*
         BRAINCLOUD_INFO
         
         // On our apps login page, we request the user to give an username and password for the UNIVERSIAL_ID and PASSWORD required for authentication.
         
         // After a successful authentcation, the onAuthenticate function will be called
         
         AppDelegate._bc.authenticateUniversal(UNIVERSIAL_ID,
            password: PASSWORD,
            forceCreate: true,
            completionBlock: onAuthenticate,
            errorCompletionBlock: onAuthenticateFailed,
            cbObject: nil)
         */
        
        AppDelegate._bc.authenticateUniversal(userId.text,
                                              password: password.text,
                                              forceCreate: true,
                                              completionBlock: onAuthenticate,
                                              errorCompletionBlock: onAuthenticateFailed,
                                              cbObject: nil)
    }
    
    func onAuthenticate(serviceName:String?, serviceOperation:String?, jsonData:String?, cbObject: NSObject?) {
        print("Success \(String(describing: jsonData))")
        
        /*
         BRAINCLOUD_INFO
         
         // After our user logs in, we are going to see if they are a newUser, and if they are, we are going to update their "name" to match their universalId
         
         let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: AnyObject]
         let isNewUser = json["data"]?["newUser"] as! Bool;
         
         if(isNewUser) {
            AppDelegate._bc.playerStateService.updateName(self.userId.text,
            completionBlock: nil,
            errorCompletionBlock: nil,
            cbObject: nil)
         }
         
         After, we will go to our main app scene, given the user has logged in
         */
        
        let data = jsonData?.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: AnyObject]
            
            let data = json["data"] as AnyObject;
            let isNewUser = data["newUser"] as! String;
            
            if(isNewUser.elementsEqual("true")) {
                AppDelegate._bc.playerStateService.updateName(self.userId.text,
                                                              completionBlock: nil,
                                                              errorCompletionBlock: nil,
                                                              cbObject: nil)
                
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        
        
        self.performSegue(withIdentifier: "onLogin", sender: nil)
        
        self.loginError.text = ""
    }
    
    func onAuthenticateFailed(serviceName:String?, serviceOperation:String?, statusCode:Int?, reasonCode:Int?, jsonError:String?, cbObject: NSObject?) {
        print("Failure \(String(describing: serviceName))")
        
        /*
         BRAINCLOUD_INFO
         
         // The user has failed to login. Perhaps they entered the wrong password, or do not have an internet connection.
         
         // Display an error to the user, based on the problem that occured
         */
        
        self.loginError.text = "Login Error \(String(describing: reasonCode))"
    }
    
}

