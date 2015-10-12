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

class ViewController: UIViewController,UIWebViewDelegate,UISearchBarDelegate {

    @IBOutlet var webView:UIWebView!
    
    var searchBar:UISearchBar!
    
    var searchURL:NSURL!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        self.searchBar=UISearchBar(frame: CGRectMake(0, 0, 250, 40))
        
        self.searchBar.tintColor=UIColor.whiteColor()
        
        self.searchBar.placeholder="Search or enter web address"
        
        self.searchBar.showsScopeBar=true
        
        self.searchBar.tintColor=UIColor.blackColor()
        
        self.searchBar.delegate=self;
        
        self.searchBar.searchBarStyle=UISearchBarStyle.Minimal
        
        self.navigationItem.titleView=self.searchBar;
        
        
        self.webView=UIWebView()
        
        self.webView?.delegate=self
        
        self.webView!.translatesAutoresizingMaskIntoConstraints = false;
        
        self.view .addSubview(self.webView)
        
        let webviewConsWidth=NSLayoutConstraint.constraintsWithVisualFormat("H:|[webView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views:["webView":self.webView!])
        
        let webviewConsHeight=NSLayoutConstraint.constraintsWithVisualFormat("V:|[webView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views:["webView":self.webView!])
        
        self.view?.addConstraints(webviewConsWidth)
        
        self.view?.addConstraints(webviewConsHeight)
        
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "movieLoaded:", name: "AVPlayerItemBecameCurrentNotification" , object:nil);
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "moviePlayerLoaded:", name: UIWindowDidBecomeKeyNotification, object: nil);
      
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "movieClosed:", name: UIWindowDidBecomeHiddenNotification, object: nil);
        
        print("This is the version 1.0 ")
        
        
    }
    
    
    // MARK: - WebView Delegate methods
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if(navigationType==UIWebViewNavigationType.LinkClicked)
        {
           print(request.URL, terminator: "")
            
           // print(navigationType)
        }
        
        return true
        
    }
    
    override func  observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>)
    {
        print("KeyPath : "+keyPath!, terminator: "")
    
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
       // print("Start")
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        //print("Finished")
    }
    
    // MARK: - Searchbar Delegate methods
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {


    }
    
    func searchBarBookmarkButtonClicked(searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        // Hide the keypad
        searchBar .resignFirstResponder()
        
        // Hide the cancel button
        searchBar.showsCancelButton=false
        
    }
    
    func searchBarResultsListButtonClicked(searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        // Check whether the search bar text empty or not
        
        if let _=searchBar.text
        {
            searchURL=NSURL(string: searchBar.text!)
        }
        
        // Hide the Searchbar keypad
        searchBar .resignFirstResponder()
        
        // Hide the cancel button
        searchBar.showsCancelButton=false
        
        searchBar.text=""
        
        searchBar.placeholder=searchURL.host
        
        // Load the url into webview
        self.webView?.loadRequest(NSURLRequest(URL:searchURL))
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
        // Show the search bar cancel buutton
        self.searchBar.showsCancelButton=true
        
        //
        self.searchBar.placeholder="Search or enter web address"
        
        if let URL=searchURL
        {
             self.searchBar.text=searchURL.absoluteString
            
        }
        
    }
    
     // MARK: - General methods
    
    func moviePlayerLoaded(notification:NSNotification)
    {
        let window = notification.object as! UIWindow
        
        if (window != self.view.window)
        {
            let lableDownloadButton:UIButton=UIButton(type: UIButtonType.Custom)
            
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
        
        let avplayerItem=notification.object as? AVPlayerItem
        
        if let playItem = avplayerItem{
            
            let asset=playItem.asset as AVAsset
            
            print(asset.valueForKey("URL")!, terminator: "")
            
        }
    
        
    }
    
    
    func movieClosed(notification:NSNotification)
    {
        let window=notification.object as! UIWindow
        
        print(window.rootViewController?.childViewControllers, terminator: "")
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

