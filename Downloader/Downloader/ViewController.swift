//
//  ViewController.swift
//  Downloader
//
//  Created by ndot on 9/26/15.
//  Copyright (c) 2015 iSolutionsApps. All rights reserved.
//

//http://stackoverflow.com/questions/8518719/how-to-receive-nsnotifications-from-uiwebview-embedded-youtube-video-playback

import UIKit

import MediaPlayer

import AVFoundation

import AVKit

class ViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet var webView:UIWebView?
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "movieLoaded:", name: UIWindowDidBecomeVisibleNotification , object:nil);
      
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "movieClosed:", name: UIWindowDidBecomeHiddenNotification, object: nil);
        
        self.webView?.delegate=self
        
        self.webView?.loadRequest(NSURLRequest(URL: NSURL(string: "http://www.youtube.com/")!))
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    // MARK: - WebView Delegate methods
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if(navigationType==UIWebViewNavigationType.Other)
        {
           // print(request.URL)
            
           // print(navigationType)
        }
        
        return true
        
    }
    
    override func  observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>)
    {
        print("KeyPath : "+keyPath)
    
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
       // print("Start")
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        //print("Finished")
    }
    
    func movieLoaded(notification:NSNotification)
    {
//        var window=notification.object as! UIWindow
//        
//        print(UIApplication.sharedApplication().delegate?.window!!.rootViewController?.childViewControllers)
        
        print("movieLoaded")
        
        var timer:NSTimer=NSTimer(timeInterval: 0.3, target: self, selector: "selectView", userInfo: nil, repeats: false)
        
        timer .fire()
        
    }
    
    
    func selectView()
    {
                //var window=notification.object as! UIWindow
        
                print(UIApplication.sharedApplication().delegate?.window!!.rootViewController?.childViewControllers)
    }
    
    
    func movieClosed(notification:NSNotification)
    {
        var window=notification.object as! UIWindow
        
       // print(window.rootViewController?.childViewControllers)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

