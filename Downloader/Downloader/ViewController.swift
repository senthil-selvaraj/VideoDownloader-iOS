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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "movieLoaded:", name: "AVPlayerItemBecameCurrentNotification" , object:nil);
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "moviePlayerLoaded:", name: UIWindowDidBecomeKeyNotification, object: nil);
      
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "movieClosed:", name: UIWindowDidBecomeHiddenNotification, object: nil);
        
        self.webView?.delegate=self
        
        self.webView?.loadRequest(NSURLRequest(URL: NSURL(string: "https://in.news.yahoo.com/watch--this-boy-can-solved-the-rubik-s-cube--blindfolded--in-under-20-seconds-084236723.html?vp=1")!))
        
       // self.webView?.addObserver(observer: NSObject, forKeyPath: <#String#>, options: <#NSKeyValueObservingOptions#>, context: <#UnsafeMutablePointer<Void>#>)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    // MARK: - WebView Delegate methods
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if(navigationType==UIWebViewNavigationType.LinkClicked)
        {
           print(request.URL)
            
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
    
    func moviePlayerLoaded(notification:NSNotification)
    {
        var window = notification.object as! UIWindow
        
        if (window != self.view.window)
        {
            var lableDownloadButton:UIButton=UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
            
            lableDownloadButton.frame=CGRectMake(15, self.view.frame.size.height-60, 100, 35)
            
            lableDownloadButton.layer.cornerRadius=5
            
            lableDownloadButton.clipsToBounds=true
            
            lableDownloadButton.backgroundColor=UIColor.whiteColor()
            
            lableDownloadButton.setTitle("Download", forState: UIControlState.Normal)
            
            lableDownloadButton.backgroundColor=UIColor.orangeColor()
            
            window .addSubview(lableDownloadButton)
            

        }
        
    }
    
    
    func movieLoaded(notification:NSNotification)
    {
        
        var avplayerItem=notification.object as? AVPlayerItem
        
        if let playItem = avplayerItem{
            
            var asset=playItem.asset as AVAsset
            
            print(asset.valueForKey("URL")!)
            
        }
    
        
    }
    
    
    func movieClosed(notification:NSNotification)
    {
        var window=notification.object as! UIWindow
        
        print(window.rootViewController?.childViewControllers)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

