//
//  WeatherData.swift
//  weather
//
//  Created by 杨志远 on 16/7/4.
//  Copyright © 2016年 杨志远. All rights reserved.
//

import UIKit
import Alamofire
class WeatherData: NSObject {
    //城市
    var city : NSString?
    //国家
    var cnty : NSString?
    //数据更新时间
    var loc : NSString?
    //pm2.5
    var pm25 : NSString?
    //温度
    var temp : NSString?
    //最大温度
    var max : NSString?
    //最小温度
    var min : NSString?
    //风
    var wind : NSString?
    //风力等级
    var sc :NSString?
    //风向
    var dir : NSString?
    //日出时间
    var sr : NSString?
    //日落时间
    var ss : NSString?
    
    //白天天气描述
    var text_d : NSString?
    //夜间天气描述
    var text_n :NSString?
    //时间
    var date : NSString?
    //湿度
    var hum : NSString?
    //能见度
    var vis : NSString?
    
    //现在的天气描述
    var text : NSString?
    //白天天气代码
    var code_d : NSString?
    //夜间天气代码
    var code_n : NSString?
    //现在天气的描述
    var code : NSString?
    var txt : NSString?
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    
}
