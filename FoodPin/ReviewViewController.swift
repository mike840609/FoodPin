//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by 蔡鈞 on 2016/2/2.
//  Copyright © 2016年 mike840609. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet var backgroundImageView:UIImageView!
    @IBOutlet var ratingStackView:UIStackView!
    
    @IBOutlet var dislikeButton:UIButton!
    @IBOutlet var goodButton:UIButton!
    @IBOutlet var greatButton:UIButton!
    
    //儲存評價
    var rating:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UIVisualEffectView 加上模糊特效
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        //加入動畫起始
        //ratingStackView.transform = CGAffineTransformMakeScale(0.0, 0.0)
        
        //合併變換方法
        //let scale = CGAffineTransformMakeScale(0.0, 0.0)
        //let translate = CGAffineTransformMakeTranslation(0, 500)
        //ratingStackView.transform = CGAffineTransformConcat(scale, translate)
        
        let translate = CGAffineTransformMakeTranslation(0, 500)
        dislikeButton.transform = translate
        goodButton.transform = translate
        greatButton.transform = translate
        
        
        
    }
    
    //閉包中定義終止狀態
    override func viewDidAppear(animated: Bool) {
        
        // Spring animation
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            
            self.dislikeButton.transform = CGAffineTransformIdentity
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            
            self.goodButton.transform = CGAffineTransformIdentity
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.4, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            
            self.greatButton.transform = CGAffineTransformIdentity
            
            }, completion: nil)
        
        
        //漸變動畫
        //UIView.animateWithDuration(0.5, delay: 0.0, options: [], animations: {
        //self.ratingStackView.transform = CGAffineTransformIdentity
        //}, completion: nil)
        
        
        //彈性動畫
        //        UIView.animateWithDuration(0.5,delay: 0.0,usingSpringWithDamping: 0.3,initialSpringVelocity: 0.5,options: [],animations: {
        //            self.ratingStackView.transform = CGAffineTransformIdentity
        //        },completion: nil)
        
        
    }
    
    @IBAction func ratingSelected(sender:UIButton){
        switch(sender.tag){
        case 100: rating = "dislike"
        case 200: rating = "good"
        case 300: rating = "great"
        default:break
        }
        
        performSegueWithIdentifier("unwindToDetailView", sender: sender)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
