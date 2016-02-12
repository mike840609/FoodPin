//
//  Restaurant.swift
//  FoodPin
//
//  Created by 蔡鈞 on 2016/1/31.
//  Copyright © 2016年 mike840609. All rights reserved.
//建立託管物件

import Foundation
import CoreData

class Restaurant:NSManagedObject{
    
    //必須有值
    @NSManaged var name:String
    @NSManaged var type:String
    @NSManaged var location:String
    
    //因為託管模型中設定optional 所以不一定會有值
    @NSManaged var phoneNumber:String?
    @NSManaged var image:NSData?
    @NSManaged var isVisited:NSNumber?
    @NSManaged var rating:String?
    
    
//    init(name:String,type:String,location:String,phoneNumber:String,image:NSData,isVisited:Bool){
//        
//        self.name = name
//        self.type = type
//        self.location = location
//        self.image = image
//        self.isVisited = isVisited
//        self.phoneNumber = phoneNumber
//    }
    
}