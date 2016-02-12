//
//  WebViewController.swift
//  FoodPin
//
//  Created by 蔡鈞 on 2016/2/10.
//  Copyright © 2016年 mike840609. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    @IBOutlet var webView:UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = NSURL(string:"http://www.appcoda.com.tw/CONTACT/"){
            let request = NSURLRequest(URL: url)
            webView.loadRequest(request)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
