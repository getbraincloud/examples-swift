//
//  brainCloudSwiftUIApp.swift
//  brainCloudSwiftUI
//
//  Created by Jason Liang on 2021-08-26.
//

import SwiftUI
import BrainCloud

class GameSettings: ObservableObject {
    @Published var _bcWrapper = BrainCloudWrapper()
}

@main
struct brainCloudSwiftUIApp: App {
    @StateObject var settings = GameSettings()
    @Environment(\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(settings)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .background {
                settings._bcWrapper?.logout(false, withCompletionBlock: nil, errorCompletionBlock: nil, cbObject: nil)
            }
        }
    }
}
