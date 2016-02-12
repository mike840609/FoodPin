//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by 蔡鈞 on 2016/1/29.
//  Copyright © 2016年 mike840609. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate,UISearchResultsUpdating{
    
    
    //設定為空陣列 改用資料庫去抓取資
    var restaurants:[Restaurant] = []
    //core data
    var fetchResultController:NSFetchedResultsController!
    
    var searchController:UISearchController!
    var searchResults:[Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //將返回按鈕的標題清空
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        //設定cell自動高度
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //Core資料庫連接操作
        let fetchRequest = NSFetchRequest(entityName: "Restaurant")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                restaurants = fetchResultController.fetchedObjects as! [Restaurant]
            } catch {
                print(error)
            }
        }
        
        //搜尋列
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.placeholder = "輸入欲搜尋的餐廳相關資訊"
        searchController.searchBar.barTintColor = UIColor(red: 218/255, green: 223/255, blue: 225/255, alpha: 1.0)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //預設為１ 移除一樣可以run
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    //數量等於陣列長度 假使搜尋列狀態為active 則設定為 active 長度
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.active{
            return searchResults.count
        }
        else{
            return restaurants.count
        }
        
    }
    
    //設定cell內容
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cellIdentifier = "Cell"
        
        //利用 as! RestaurantTableViewCell 進行強迫轉型 傳回的cell 物件轉換為 RestaurantTableViewCell 自定義類別
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RestaurantTableViewCell
        
        //檢查搜尋列是否啟動 若啟動從搜尋列獲得餐廳
        let restaurant = (searchController.active) ? searchResults[indexPath.row]:restaurants[indexPath.row]
        
        
        
        //設定cell 自定義屬性 要用自定義類別內的屬性
        cell.nameLabel.text = restaurant.name
        cell.thumbnailImageView.image = UIImage(data: restaurant.image!)
        cell.typeLabel.text = restaurant.type
        cell.locationLabel.text = restaurant.location
        //設定圓角
        cell.thumbnailImageView.layer.cornerRadius = 10.0
        cell.thumbnailImageView.clipsToBounds = true
        
        //更新勾選補助視圖 三元條件式
        if let isVisted = restaurant.isVisited?.boolValue{
            cell.accessoryType = isVisted ? .Checkmark : .None
        }
        
        return cell
    }
    

    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            // Delete the row from the data source
            restaurants.removeAtIndex(indexPath.row)
        }
        
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
    
    //加入滑動自訂動作
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        //社群分享按鈕
        let shareAction = UITableViewRowAction(style: .Default, title: "Share", handler:{(action,indexPath) -> Void in
            let defaultText = "Just checking in at" + self.restaurants[indexPath.row].name
            if let imageToShare = UIImage(data: self.restaurants[indexPath.row].image!){
                let activityController = UIActivityViewController(activityItems: [defaultText,imageToShare], applicationActivities: nil)
                self.presentViewController(activityController, animated: true, completion: nil)
            }
        })
        
        //刪除按鈕
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete",handler: { (action, indexPath) -> Void in
            
            // Delete the row from the database
            if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
                
                let restaurantToDelete = self.fetchResultController.objectAtIndexPath(indexPath) as! Restaurant
                managedObjectContext.deleteObject(restaurantToDelete)
                
                do {
                    try managedObjectContext.save()
                } catch {
                    print(error)
                }
            }
        })
        
        //客製化按鈕顏色
        shareAction.backgroundColor = UIColor(red: 28.0/255.0, green: 165.0/255.0, blue: 253.0/255.0, alpha: 1.0)
        
        
        return[deleteAction,shareAction]
    }
    
    
    //利用segue傳值 使用prepareForSegue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //只針對segue識別碼為showRestaurantDetail執行動作
        if segue.identifier == "showRestaurantDetail"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationController = segue.destinationViewController as! RestaurantDetailViewController
                
                //依據是否用搜尋列來決定傳遞的陣列
                destinationController.restaurant = (searchController.active) ? searchResults[indexPath.row] : restaurants[indexPath.row]
                
            }
        }
    }
    
    //每次呼交視圖就會跑這方法  viewdidload 只有首次載入時執行
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
    }
    
    //Cancel按鈕 呼叫方法
    @IBAction  func unwindToHomeScreen(segue:UIStoryboardSegue){
        
    }
    
    
    //下面三個方法為 NSFetchedResultsControllerDelegate 方法  內容變更協定方法會被呼叫
    //方法一 controllerWillChangeContent 通知視圖
    //方法二 didChangeObject 託管物件有任何改變被呼叫 並在結尾處與陣列同步
    //方法三 controllerDidChangeContent 完成變更後呼叫 自動以相對應動畫進行變更============================================
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type{
        case .Insert:
            if let  _newIndexPath = newIndexPath{
                tableView.insertRowsAtIndexPaths([_newIndexPath], withRowAnimation: .Fade)
            }
        case .Delete:
            if let  _indexPath = indexPath{
                tableView.deleteRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
            }
        case .Update:
            if let  _indexPath = indexPath{
                tableView.reloadRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
            }
        default:
            tableView.reloadData()
        }
        
        restaurants = controller.fetchedObjects as! [Restaurant]
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    //搜尋欄======================================================================================================
    
    //搜尋欄過濾方法
    func filterContentForSearchText(searchText:String){
        
        searchResults = restaurants.filter({
            (restaurant:Restaurant)-> Bool in
            let nameMatch = restaurant.name.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            let infoMatch = restaurant.location.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return nameMatch != nil || infoMatch != nil
        })
    }
    //搜尋欄變更自動呼叫
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            filterContentForSearchText(searchText)
            tableView.reloadData()
        }
    }
    
    //搜尋後不可以編輯
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if searchController.active{
            return false
        }
        else{
            return true
        }
    }
    
}