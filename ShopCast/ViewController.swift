//
//  ViewController.swift
//  ShopCast
//
//  Created by guma on 2016. 1. 25..
//  Copyright © 2016년 Guma. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet var swipeRight: UISwipeGestureRecognizer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let url = NSURL(string:"http://mobile.gmarket.co.kr")
        let req = NSURLRequest(URL:url!)
        self.webView!.loadRequest(req)
        
//        let imageView = UIImageView(image: UIImage(named: "title.png"))
//        
//        imageView.frame.origin.x = 30.0
//        imageView.frame.origin.y = 5.0
//        self.navBar.titleView = imageView
//        
    }
    @IBAction func onSwipe(sender: AnyObject) {
        if(sender as! NSObject == swipeRight){
            if(self.webView.canGoBack){
                NSLog("go back")
                self.webView.goBack()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

