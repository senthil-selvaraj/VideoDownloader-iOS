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
        
        var avplayerItem=notification.object as? AVPlayerItem
        
        if let playItem = avplayerItem{
            
            var asset=playItem.asset as AVAsset
            
            print(asset.valueForKey("URL")!)
            
//            var lableIndicator:UILabel = UILabel(frame: CGRectMake(0, self.view.frame.size.height-100, 100, 25));
//            
//            lableIndicator.backgroundColor=UIColor.whiteColor()
//            
//            lableIndicator.text="Download the file"
//            
//            UIApplication.sharedApplication().delegate?.window!!.rootViewController?.view.addSubview(lableIndicator)
            // 1
            let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
            
            // 2
            let deleteAction = UIAlertAction(title: "Delete", style: .Default, handler: {
                (alert: UIAlertAction!) -> Void in
                println("File Deleted")
            })
            let saveAction = UIAlertAction(title: "Save", style: .Default, handler: {
                (alert: UIAlertAction!) -> Void in
                println("File Saved")
            })
            
            //
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
                (alert: UIAlertAction!) -> Void in
                println("Cancelled")
            })
            
            
            // 4
            optionMenu.addAction(deleteAction)
            optionMenu.addAction(saveAction)
            optionMenu.addAction(cancelAction)
            
            // 5
            self.presentViewController(optionMenu, animated: true, completion: nil)
            
            
        }
    
        
    }
    
    
    func selectView()
    {
                //var window=notification.object as! UIWindow
        
                print(UIApplication.sharedApplication().delegate?.window!!.rootViewController?.childViewControllers)
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

