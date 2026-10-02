//
//  AboutView.swift
//  Lions Prey
//
//  Created by Edward Bender on 9/6/21.
//

import SwiftUI
import WebKit

struct AboutView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView()
        webview.loadHTMLString(privacy, baseURL: Bundle.main.bundleURL)
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
//        uiView.load(request)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
