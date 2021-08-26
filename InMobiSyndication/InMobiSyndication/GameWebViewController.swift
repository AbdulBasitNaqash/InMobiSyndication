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
    var name: String = ""
    var gameId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = name
        let myURL = gameURL ?? URL(string: "https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        self.edgesForExtendedLayout = []
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
        
    }
    
    deinit {
        if let gameId = gameId {
            recordGameEndEvent(publisherId: 13, gameId: gameId)
        }
    }
    
    func recordGameEndEvent(publisherId: Int, gameId: Int) {
        let timeStamp = UInt64((Date().timeIntervalSince1970) * 1000)
        
        APIManager.shared.recordGameEvent(eventURL: EVENT_END_URL, publisherId: publisherId, gameId: gameId, timeStamp: timeStamp)
    }
} 
