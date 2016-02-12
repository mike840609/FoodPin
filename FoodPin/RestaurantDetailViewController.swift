//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by 蔡鈞 on 2016/1/31.
//  Copyright © 2016年 mike840609. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet var tableview: UITableView!
    @IBOutlet var ratingButton:UIButton!
    
    
    
    
    //建立物件,必須使用驚嘆號
    var restaurant:Restaurant!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //載入視圖後做其他設定
        restaurantImageView.image = UIImage(data: restaurant.image!)
        
        //美化背景顏色
        tableview.backgroundColor = UIColor(red: 197/255.0, green: 239/255.0, blue: 247/255.0, alpha: 0.2)
        
        //移除空項目隔線
        tableview.tableFooterView = UIView(frame: CGRectZero)
        
        //變更分隔線顏色
        tableview.separatorColor = UIColor(red: 189/255.0, green: 195/255.0, blue: 199/255.0, alpha: 0.8)
        
        //標題自訂
        title = restaurant.name
        
        //啟動 Cell Sizing Cells 自動調整cell value內容的高度
        tableview.estimatedRowHeight = 36.0
        tableview.rowHeight = UITableViewAutomaticDimension
        
        //Set the rating of the restaurant
        if let rating = restaurant.rating where rating != ""{
            ratingButton.setImage(UIImage(named: restaurant.rating!), forState: UIControlState.Normal)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // tableView 中的行數
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! RestaurantDetailTableViewCell
        
        //設定Cell
        switch indexPath.row{
            
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = restaurant.name
            
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = restaurant.type
            
        case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = restaurant.location
            
        case 3:
            cell.fieldLabel.text = "Phone"
            cell.valueLabel.text = restaurant.phoneNumber
            
        case 4:
            cell.fieldLabel.text = "Been here"
            if let isVisted = restaurant.isVisited?.boolValue{
                cell.valueLabel.text = isVisted ? "yes i've been here before" : "No"
            }
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        
        //清除背景色 因為才能使用客製化顏色
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
    //標題欄控制 每次載入頁面執行
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //segue 返回 unwind seque
    @IBAction func close(segue:UIStoryboardSegue){
        if let reviewViewController = segue.sourceViewController as? ReviewViewController {
            if let rating = reviewViewController.rating {
                restaurant.rating = rating
                ratingButton.setImage(UIImage(named: rating), forState: UIControlState.Normal)
                
                //Coredata 更新託管物件
                if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext{
                    do{
                        try managedObjectContext.save()
                    }catch{
                        print(error)
                    }
                }
            }
        }
    }
    
    
    //利用segue傳值倒地圖 使用prepareForSegue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMap"{
            let destinationController = segue.destinationViewController as! MapViewController
            destinationController.restaurant = restaurant
        }
        
    }
}