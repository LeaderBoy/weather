//
//  MapManager.swift
//  weather
//
//  Created by 杨志远 on 16/6/13.
//  Copyright © 2016年 杨志远. All rights reserved.
//

import UIKit
import CoreLocation

protocol MapManagerDelegate {
    
    //地图定位成功后调用的协议方法
    func mapManagerSucceedUpdateLocationWith(manager:MapManager,Andlocations:CLLocation)
    //地图定位失败后调用的协议方法
    func mapManagerFailedUpdateLocationWith(manager:MapManager,error:NSError)
    
    //地图定位关闭授权调用的协议方法
    func locationServiceIsOffWith(manager:MapManager)
    
    
}


class MapManager: NSObject,CLLocationManagerDelegate {
    
    var locaionManager : CLLocationManager?
    var delegate : MapManagerDelegate?
    

    
    //开始定位时调用的方法
    func startLocate()
    {
        locaionManager = CLLocationManager()
        locaionManager?.delegate = self
        
        
            if ((locaionManager?.respondsToSelector(#selector(CLLocationManager.requestWhenInUseAuthorization))) != nil)
            {
                locaionManager?.requestWhenInUseAuthorization()
            }
        
        
        locaionManager?.startUpdatingLocation()
    }
    
    //MARK:定位成功调用的方法
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
       manager.stopUpdatingLocation()
        
       //MARK:获取最新的位置信息
      let  location = locations.last
        
        if delegate != nil && location?.horizontalAccuracy > 0
        {
            delegate?.mapManagerSucceedUpdateLocationWith(self, Andlocations: location!)
          
            
        }
        
        
    }
    
    //定位失败调用的方法
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
       delegate?.mapManagerFailedUpdateLocationWith(self, error: error)
    }
    
 

}
