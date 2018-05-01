//
//  DetailViewController.swift
//  assessment1
//
//  Created by Admin on 2018-04-30.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit
import WebKit
import MBProgressHUD

class TopicDetailViewController: UIViewController, WKNavigationDelegate {

    var link:URL!
    var webView:WKWebView?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        webView = WKWebView(frame: view.frame)
        view.addSubview(webView!)
        webView!.navigationDelegate = self
        load()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func load() {
        MBProgressHUD.showAdded(to: view, animated: true)
        webView?.load(URLRequest(url: link))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        MBProgressHUD.hide(for: view, animated: true)
    }
}

