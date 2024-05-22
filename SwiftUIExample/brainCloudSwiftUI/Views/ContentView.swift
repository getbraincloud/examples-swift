//
//  ContentView.swift
//  brainCloudSwiftUI
//
//  Created by Jason Liang on 2021-08-25.
//

import SwiftUI
import BrainCloud

struct ContentView: View {
    @State var serviceOperationName = ""
    @State var jsonDataReturn = ""
    @EnvironmentObject var settings: GameSettings
    
    var body: some View {

        VStack {
            Image("textLogo")
            Spacer()
            Button("1 Initialize") {
                // read YOUR_SECRET and YOUR_APPID from info.plist
                var config: [String: Any]?
                
                if let infoPlistPath = Bundle.main.url(forResource: "Info", withExtension: "plist") {
                    do {
                        let infoPlistData = try Data(contentsOf: infoPlistPath)
                        
                        if let dict = try PropertyListSerialization.propertyList(from: infoPlistData, options: [], format: nil) as? [String: Any] {
                            config = dict
                        }
                    } catch {
                        print(error)
                    }
                }
                    
                settings._bcWrapper?.initialize(config?["BCServerUrl"] as? String,
                               secretKey: config?["BCSecretKey"] as? String,
                               appId: config?["BCAppId"] as? String,
                               appVersion: "2.0.0",
                               companyName: "brainCloud",
                               appName: "TestJ")
                settings._bcWrapper?.getBCClient().enableLogging(true)

                serviceOperationName = "INITIALIZE"
                jsonDataReturn = "App ID: " + (config?["BCAppId"] as! String)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Button("2 AuthenticateAnonymous"){
                settings._bcWrapper?.authenticateAnonymous(onServiceCallback, errorCompletionBlock: onServiceCallbackFailed, cbObject: nil, forceCreate: true)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Button("3 Logout"){
                settings._bcWrapper?.logout(true, withCompletionBlock: onServiceCallback, errorCompletionBlock: onServiceCallbackFailed, cbObject: nil)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            ScrollView {
                VStack {
                    Text(serviceOperationName)
                    TextEditor(text: $jsonDataReturn) // TextEditor allows copy contents
                }
            }
        }
    }
        
    
    
    func onServiceCallback(serviceName:String?, serviceOperation:String?, jsonData:String?, cbObject: NSObject?) {
        print("\(serviceOperation!) Success \(jsonData!)")
        serviceOperationName = serviceOperation ?? "no operation executed"
        jsonDataReturn = jsonData ?? "success with response returned"
    }
    
    func onServiceCallbackFailed(serviceName:String?, serviceOperation:String?, statusCode:Int?, reasonCode:Int?, jsonError:String?, cbObject: NSObject?) {
        print("\(serviceOperation!) Failure \(jsonError!)")
        serviceOperationName = serviceOperation ?? "no operation executed"
        jsonDataReturn = jsonError ?? "fail with error returned"
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


