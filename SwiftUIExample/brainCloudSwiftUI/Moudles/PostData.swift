//
//  PostData.swift
//  brainCloudSwiftUI
//
//  Created by Jason Liang on 2021-08-25.
//

import Foundation

class OperationMoudle: ObservableObject {
    @Published var bcOperations = [
        Post(id: "1", operation: "Initialize", url: "https://getbraincloud.com/apidocs/apiref/?objective_c#wrapper-initialize"),
        Post(id: "2", operation: "AuthenticateAnonymous", url: "https://getbraincloud.com/apidocs/apiref/?objective_c#wrapper-authenticateanonymous"),
        Post(id: "3", operation: "Logout", url: "https://getbraincloud.com/apidocs/apiref/?objective_c#capi-playerstate-logout")
    ]
}

struct Post: Identifiable {
    let id: String
    let operation: String
    let url: String
}
