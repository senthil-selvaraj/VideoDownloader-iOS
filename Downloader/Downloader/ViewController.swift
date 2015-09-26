//
//  ViewController.swift
//  Downloader
//
//  Created by ndot on 9/26/15.
//  Copyright (c) 2015 iSolutionsApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet var webView:UIWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView?.delegate=self
        
        self.webView?.loadRequest(NSURLRequest(URL: NSURL(string: "http://www.shortfundly.com/")!))
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    // MARK: - WebView Delegate methods
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        print(request.URL?.path)
        
        print(navigationType)
        
        return true
        
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        print("Start")
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        print("Finished")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

