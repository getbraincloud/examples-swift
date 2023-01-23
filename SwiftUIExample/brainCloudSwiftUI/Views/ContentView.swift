//
//  ContentView.swift
//  brainCloudSwiftUI
//
//  Created by Jason Liang on 2021-08-25.
//

import SwiftUI
import BrainCloud

struct ContentView: View {
    @ObservedObject var moudle = OperationMoudle()
    @State var serviceOperationName = "operation"
    @State var jsonDataReturn = "response"
    
    var body: some View {
        let _bc: BrainCloudWrapper = BrainCloudWrapper()
        VStack {
            Image("textLogo")
            NavigationView{
                List(moudle.bcOperations){ item in
                    NavigationLink(
                        destination: DetailView(url: item.url),
                        label: {
                            /*@START_MENU_TOKEN@*/HStack {
                                Text(item.id)
                                Text(item.operation)
                            }/*@END_MENU_TOKEN@*/
                        }).simultaneousGesture(TapGesture().onEnded{
                            switch item.id {
                            case "1":
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
                                _bc.initialize(config?["BCServerUrl"] as? String,
                                               secretKey: config?["BCSecretKey"] as? String,
                                               appId: config?["BCAppId"] as? String,
                                               appVersion: "2.0.0",
                                               companyName: "brainCloud",
                                               appName: "TestJ")
                            case "2":
                                _bc.authenticateAnonymous(onAuthenticate, errorCompletionBlock: onAuthenticateFailed, cbObject: nil)
                            case "3":
                                _bc.playerStateService.logout(onAuthenticate, errorCompletionBlock: onAuthenticateFailed, cbObject: nil)
                            default:
                                print("No operation selected!")
                            }
                            
                        })
                }
                .navigationTitle("Menu")
            }
            .onAppear(perform: {
                DispatchQueue.main.async {
                    _bc.getBCClient().enableLogging(true)
                }
            })
            ScrollView {
                VStack {
                    TextField(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/, text: $serviceOperationName)
                    TextEditor(text: $jsonDataReturn)
                }
            }
        }
    }
    
    
    func onAuthenticate(serviceName:String?, serviceOperation:String?, jsonData:String?, cbObject: NSObject?) {
        print("\(serviceOperation!) Success \(jsonData!)")
        serviceOperationName = serviceOperation ?? "no operation executed"
        jsonDataReturn = jsonData ?? "success with response returned"
    }
    
    func onAuthenticateFailed(serviceName:String?, serviceOperation:String?, statusCode:Int?, reasonCode:Int?, jsonError:String?, cbObject: NSObject?) {
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


