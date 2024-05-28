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
            Text("SwiftUI App Version " + ((Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!))
            Spacer()
            Button("1 Initialize") {
                settings._bcWrapper?.initialize(Bundle.main.infoDictionary?["BCServerUrl"] as? String,
                               secretKey: Bundle.main.infoDictionary?["BCSecretKey"] as? String,
                               appId: Bundle.main.infoDictionary?["BCAppId"] as? String,
                               appVersion: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
                               companyName: "brainCloud",
                               appName: "TestJ")
                settings._bcWrapper?.getBCClient().enableLogging(true)

                serviceOperationName = "INITIALIZE"
                jsonDataReturn = "App ID: " + (Bundle.main.infoDictionary?["BCAppId"] as! String)
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


