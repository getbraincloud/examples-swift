//
//  DetailView.swift
//  brainCloudSwiftUI
//
//  Created by Jason Liang on 2021-08-25.
//

import SwiftUI

struct DetailView: View {
    
    let url: String
    
    var body: some View {
//        Text(String(url ?? "no url"))
        WebView(urlString: url)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://getbraincloud.com")
    }
}
