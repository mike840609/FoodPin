//
//  MapViewController.swift
//  FoodPin
//
//  Created by 蔡鈞 on 2016/2/3.
//  Copyright © 2016年 mike840609. All rights reserved.
//

import MapKit
import UIKit

class MapViewController: UIViewController,MKMapViewDelegate {
    
    @IBOutlet var mapView:MKMapView!
    
    var restaurant:Restaurant!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //設定地圖代理
        mapView.delegate = self;
        
        //交通流量 顯示比例 指南針
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
        
        
        
    
        //將地址轉換成座標並標示在地圖上
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location, completionHandler: {
        placemarks , error in
            if error != nil{
            print(error)
                return
            }
            if let placemarks = placemarks{
                //取得第一個座標
                let placemark = placemarks[0]
                
                //加上標註
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant.name
                annotation.subtitle = self.restaurant.type
                
                if let location = placemark.location{
                    annotation.coordinate = location.coordinate
                    
                    //顯示標註
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                
                }
            }
        })
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        if annotation.isKindOfClass(MKUserLocation){
        return nil
        }
        
        // dequeueReusableAnnotationViewWithIdentifier 查看是否有沒有使用的視圖  可以的話回收使用這個標註
        var annotationView:MKPinAnnotationView? = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
        
        //若沒有可使用的 用MKPinAnnotationView　實體化一個新視圖
        if annotationView == nil{
        annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        let leftIconView = UIImageView(frame: CGRectMake(0, 0, 53, 53))
        leftIconView.image = UIImage(data: restaurant.image!)
        annotationView?.leftCalloutAccessoryView = leftIconView
        
        //顏色
        annotationView?.pinTintColor = UIColor.orangeColor()
        
        
        
        
        return annotationView
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
