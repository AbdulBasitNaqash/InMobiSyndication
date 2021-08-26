//
//  GameWebViewController.swift
//  InMobiSyndication
//
//  Created by Abdul Basit on 26/08/21.
//

import Foundation
import UIKit
import WebKit

class GameWebViewController: UIViewController, WKUIDelegate {
    var gameURL: URL?
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
           let myURL = gameURL ?? URL(string: "https://www.apple.com")
           let myRequest = URLRequest(url: myURL!)
           webView.load(myRequest)
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
} 
