//
//  AboutTableViewController.swift
//  FoodPin
//
//  Created by 蔡鈞 on 2016/2/9.
//  Copyright © 2016年 mike840609. All rights reserved.
//

import UIKit
import SafariServices

class AboutTableViewController: UITableViewController {
    
    var sectionTitles = ["Leave Feedback", "Follow Us"]
    var sectionContent = [["Rate us on App Store", "Tell us your feedback"],["Twitter", "Facebook", "Pinterest"]]
    var links = ["https://twitter.com/appcodamobile", "https://facebook.com/appcodamobile", "https://www.pinterest.com/appcoda/"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //移除第二個區塊的空白列
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //Section
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    //Row
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return 2
        }else{
            return 3
        }
    }
    
    //    回傳標題給指定區塊
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    //    設定文字並回傳Cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        //        設定cell
        cell.textLabel?.text = sectionContent[indexPath.section][indexPath.row]
        
        return cell
        
    }
    //    選取後執行得動作
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.section{
            
        //Leave Feedback 區塊
        case 0:
            if indexPath.row == 0{
                if let url = NSURL(string: "http://www.apple.com/itunes/charts/paid-apps/"){
                    UIApplication.sharedApplication().openURL(url)
                }
            }
            else if indexPath.row == 1{          //tell us your feedback 被選中
                performSegueWithIdentifier("showWebView", sender: self)
            }
        //Follow Us 區塊
        case 1:
            if let url = NSURL(string:links[indexPath.row]){
            
                let safariController = SFSafariViewController(URL:url, entersReaderIfAvailable: true)
                presentViewController(safariController, animated: true, completion: nil)
            }
            
        default:
            break
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
}
