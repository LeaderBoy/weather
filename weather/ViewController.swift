//
//  ViewController.swift
//  weather
//
//  Created by 杨志远 on 16/6/2.
//  Copyright © 2016年 杨志远. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import BubbleTransition
import SwiftGifOrigin

enum Progress {
    case SUCCESS
    case FAILIED
    case LOADING
}

class ViewController: UIViewController,MapManagerDelegate,TYCircleMenuDelegate,UIViewControllerTransitioningDelegate {
    
    
    
    //地图管理者
    var mapManager : MapManager?

    //每天的天气数据
    var everyDayWeatherDataArray = NSMutableArray()
    
    
   //城市
    var city : NSString?
    //区
    var subCity : NSString?
    //城市id
    var cityId : NSString?
    
    var hud : JHUD?
    
    
    
    //圆形按钮
    var circleMenu : TYCircleMenu?
    var itemsArray : Array<AnyObject> = []
    var items : Array<AnyObject> = []
   
    
    //date
    let date = NSDate()
    
  
    
    //根据id得到天气数据
    lazy var change : ChangeNumberToWeather = {
        
        let cha = ChangeNumberToWeather()
        return cha
        
    }()
    //城市list
    lazy var countryListArray : NSMutableArray =
        {
        let array = NSMutableArray()
        return array
    }()

    
    //懒加载地理反编码
    lazy  var geoCode : CLGeocoder = {
        let geo = CLGeocoder()
        return geo
    }()
    //转场动画
    lazy var bubbleTransition : BubbleTransition = {
        let bubb = BubbleTransition()
        return bubb
    }()
    
    //天气model
    lazy var  weaModel : WeatherData = {
        let model = WeatherData()
        return model
    }()
    

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        hud = JHUD(frame: self.view.bounds)
        
        change.frame = self.view.bounds
        self.view.addSubview(change)
        

        hud?.backgroundColor = UIColor.brownColor()
        self.loadingAnimationWith(Progress.LOADING)
        self.createCountryList()
        self.judgeTheDate()
        
        hud?.JHUDReloadButtonClickedBlock = {
            self.loadingAnimationWith(.LOADING)
            self.createCountryList()
        }
  
    }
    //MARK:加载动画
    func loadingAnimationWith(progress:Progress)
    {
        switch progress {
        case .FAILIED:
            hud?.indicatorViewSize = CGSize(width: 150, height: 150)
            hud?.messageLabel.text = "Get data failed, please check the network Settings";

            hud?.customImage = UIImage(named: "failed")
            hud?.refreshButton
            hud?.showAtView(self.view, hudType: JHUDLoadingType.Failure)

        case .SUCCESS:
            hud?.hide()
        case .LOADING:
            let path = NSBundle.mainBundle().pathForResource("Loading", ofType: "gif")
            
            let data = NSData(contentsOfFile: path!)
            hud?.indicatorViewSize = CGSize(width: 336, height: 252)
            hud?.messageLabel.text = "Loading";
            hud?.gifImageData = data
            hud?.showAtView(self.view, hudType: JHUDLoadingType.GifImage)
       
        }
       

        

    }
    
    
    //展示UI
    func showUI()
    {
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "light")!)
        change.with(self.everyDayWeatherDataArray,weatherData:self.weaModel)
        
        
        let transition = CATransition()
        transition.type = "rippleEffect";
        transition.delegate = self
        transition.duration = 0.5
        
        let load = self.view.subviews.indexOf(hud!)
        let chan = self.view.subviews.indexOf(change)
        self.view.exchangeSubviewAtIndex(load!, withSubviewAtIndex: chan!)
        self.loadingAnimationWith(.SUCCESS)

        self.view.layer.addAnimation(transition, forKey: "transition")



        //self.weaModel.code!
        
        
        self.setUpCircleButtonImageWith(self.everyDayWeatherDataArray)

    }
    
    //MARK:判断时间,进而给每个button显示不同的日期
    func judgeTheDate()
    {
        if itemsArray.count != 0
        {
            itemsArray.removeAll()
        }
        
        let today =  date.getNowWeekday().hashValue
        
        itemsArray = ["今天"]
        
        for i in 1..<7
        {
            let dateString = NSString(format: "%d", today+i)
            itemsArray.append(dateString)
        }
    }
    
    //MARK:组成城市字典
    func createCountryList()
    {

        
            Alamofire.request(.GET, COUNTRY_API, parameters: nil)
                .responseJSON
                { response in
                    
                    NSLog("开始请求")
                    if response.result.value != nil
                    {
                        
                        let JSON = response.result.value as! NSMutableDictionary
                        
                        let cityInfo = JSON.objectForKey("city_info") as! NSMutableArray
                        
                        for dic  in cityInfo
                        {
                            let cotModel = CountryModel()
                            
                            
                            
                            cotModel.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                            
                            self.countryListArray.addObject(cotModel)
                            

                        }
                        
                        
                        dispatch_async(dispatch_get_main_queue(), { 
                            self.startLocation()

                        })
                        
                        
                    }else
                    {
                        self.loadingAnimationWith(.FAILIED)
                    }
                    
            }
            
        
    }

    
    
    
   
    
    //MARK:开始地图定位
    func startLocation()
    {
        mapManager = MapManager()
        
        mapManager!.delegate = self
        
        mapManager!.startLocate()
        print("2")

    }
    
    //MARK:配置圆形按钮的图案,根据天气的不同
    func setUpCircleButtonImageWith(array : NSMutableArray)
    {
 //判断当前时间是夜间还是白天
   
        print(array.count)
        for  data in array
        {
            
            let model = data as! WeatherData
            //获取日落的时间
            let ssDateString = model.ss
            
            let format = NSDateFormatter()
        format.setLocalizedDateFormatFromTemplate("HH:mm")
            format.locale = NSLocale(localeIdentifier: "zh_CN")

            
            let nowDateString = format.stringFromDate(date)
            
            let nowDate = format.dateFromString(nowDateString)
            
            let ssDate = format.dateFromString(ssDateString as! String)
            
            //转换成当前的时区
            let zone = NSTimeZone.systemTimeZone()
            
            
            let nowInterval = NSTimeInterval(zone.secondsFromGMTForDate(nowDate!))
            
            let now = nowDate?.dateByAddingTimeInterval(nowInterval)
            
           
            
            let ssInterval = NSTimeInterval(zone.secondsFromGMTForDate(ssDate!))
            
            let ss = ssDate?.dateByAddingTimeInterval(ssInterval)
            
            
            //比较
            let  time =  now!.timeIntervalSinceDate(ss!)
            let code =  (time.hashValue > 0 ? model.code_n : model.code_d) as! String
            
            items.append(code)
     
        }
     
        circleMenu = TYCircleMenu(radious: 200, itemOffset: 0, imageArray: items, titleArray: itemsArray, menuDelegate: self)
        
        circleMenu!.isDismissWhenSelected = true
        
        change.addSubview(circleMenu!)
        

    }
    
   
   
    
    
    
   
    //MARK:根据城市id查找天气状况
    func getWeatherDataWith(cityId : NSString)
        {
            
          let urlString = NSString(format: WEATHER_API,cityId)
            
            let url = NSURL(string: urlString as String)
        
            Alamofire.request(.GET, url!, parameters: nil)
                .responseJSON
                { response in
                    
                    if response.result.value != nil
                    {
                        
                        let JSON = response.result.value as! NSMutableDictionary
                        
                        let weatherInfo = JSON.objectForKey("HeWeather data service 3.0") as! NSMutableArray
                        
                        
                        
                        let dic = weatherInfo[0]
                        //现在的天气的字典(now)
                        let dicNow = dic.objectForKey("now")
                        //描述天气的字典(cond)
                        let detailDic = dicNow?.objectForKey("cond")
                        //风的具体信息的字典(wind)
                        let windDic = dicNow?.objectForKey("wind")
                        //显示城市信息的字典(basic)
                        let cityInfo = dic.objectForKey("basic")
                        //daily_forecast的数组
                        let daily_forecast = dic.objectForKey("daily_forecast") as! NSMutableArray
                        
            
                        for dic in daily_forecast
                        {
                        
                            let everyDayDataModel = WeatherData()
                            everyDayDataModel.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                        
                            let astroDic = dic.objectForKey("astro")
                            
                            everyDayDataModel.setValuesForKeysWithDictionary(astroDic as! [String : AnyObject])
                            
                            
                            let condDic = dic.objectForKey("cond")
                            
                            everyDayDataModel.setValuesForKeysWithDictionary(condDic as! [String : AnyObject])
                            
                            let tmpDic = dic.objectForKey("tmp")
                            
                            everyDayDataModel.setValuesForKeysWithDictionary(tmpDic as! [String : AnyObject])
                            
                            let windDic = dic.objectForKey("wind")
                            
                            everyDayDataModel.setValuesForKeysWithDictionary(windDic as! [String : AnyObject])
                            
                            self.everyDayWeatherDataArray.addObject(everyDayDataModel)
                            
                        }
                        

                        
                        
                        self.weaModel.setValuesForKeysWithDictionary(cityInfo as! [String : AnyObject])
                        
                        self.weaModel.setValuesForKeysWithDictionary(dicNow as! [String : AnyObject])
                        
                        self.weaModel.setValuesForKeysWithDictionary(detailDic as! [String : AnyObject])
                        
                        self.weaModel.setValuesForKeysWithDictionary(windDic as! [String : AnyObject])
                        

                        //MARK:成功后加载UI界面
                           dispatch_async(dispatch_get_main_queue(), { 
                            self.showUI()
                            
                           })

                        NSLog("加载数据")
                        
                        
                        
                    }else
                    {
                        self.loadingAnimationWith(.FAILIED)
                    }
                    
            }
            
            
  
            
        }

    
    //MARK: 检测网络状态
    
    func checkTneNetWorkStatus()
    {
    
                let alert = UIAlertController(title: "定位失败", message: "无网络链接,去打开网络?", preferredStyle: .Alert)
                
                let okButton = UIAlertAction(title: "OK", style: .Default,handler: {(action) in
                    
                    UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
                    
                })
                
                alert.addAction(okButton)
                
                
                self.presentViewController(alert, animated: true, completion: {
                    
                })
                
           
            
        
    }
    
    
    
    
 //MARK:定位相关
    //MARK:定位成功
    
    func mapManagerSucceedUpdateLocationWith(manager: MapManager, Andlocations: CLLocation) {
        
        geoCode.reverseGeocodeLocation(Andlocations
            , completionHandler: { (placeMark, error) in
                if placeMark?.count == 0 && error != nil
                {
                    print("没有找到该地址")
                }else if let place = placeMark?.first
                {
                    NSLog("定位成功")
            
                    
                    let subLocality = place.subLocality!
                    
                    let locality = place.locality!
                    
                    self.city = locality
                    self.subCity = subLocality

                    
                    if self.countryListArray.count != 0
                {
                    
                    for model in self.countryListArray
                    {
                        
                        let mo = model as! CountryModel
                        
                        
                        if subLocality.hasPrefix(mo.city as! String) && (locality.hasPrefix(mo.prov as! String) || ("直辖市".hasPrefix(mo.prov as! String)))
                        {
                            self.cityId = mo.id
                            
                            self.getWeatherDataWith(self.cityId!)
                        }
                    }
                       

                    
                    
                    
                        
                    
                }
                    
                }else
                {
                    print(error)
                }
        })
        
        
        
    }
    //MARK:定位失败
    
    func mapManagerFailedUpdateLocationWith(manager: MapManager, error: NSError) {
        print("定位失败")

        if CLLocationManager.locationServicesEnabled() == false
        {
            let alert = UIAlertController(title: "定位失败", message: "不具有定位功能", preferredStyle: .Alert)
            
            let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alert.addAction(okButton)
            
            self.presentViewController(alert, animated: true, completion: {
                
            })
            
            
            
            
        }else if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Denied
        {
            
            
                let alert = UIAlertController(title: "定位失败", message: "定位功能已关闭,是否去打开定位功能", preferredStyle: .Alert)
                
                let okButton = UIAlertAction(title: "OK", style: .Default,handler: {(action) in
                    
                    UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
                    
                })
                
                
                let cancleButton = UIAlertAction(title: "cancel", style: .Cancel, handler: { (action) in
                 
            
                })
                
                alert.addAction(okButton)
                
                alert.addAction(cancleButton)
                
                self.presentViewController(alert, animated: true, completion: {
                    
                })
            
            
            
        }else
        {
            self.loadingAnimationWith(.FAILIED)
        }
    }
    //MARK:定位关闭
    
    func locationServiceIsOffWith(manager: MapManager) {
        print("定位关闭")
    }
    
    
    func selectMenuAtIndex(index: Int, andView collectView: UICollectionView!) {
        
        let otherDayVC = OtherDaysViewController()
        otherDayVC.transitioningDelegate = self
        otherDayVC.modalPresentationStyle = .Custom
        
        self.presentViewController(otherDayVC, animated: true, completion: {
            
        })
        
       
    }
    
    
    override func viewDidAppear(animated: Bool) {
        NSLog("显示")
    }
    
   
    
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        bubbleTransition.transitionMode = .Present
        bubbleTransition.startingPoint = CGPoint(x: 45, y: self.view.bounds.size.height-45)
        bubbleTransition.bubbleColor = UIColor.blueColor()
                
        return bubbleTransition
    }
    
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        bubbleTransition.transitionMode = .Dismiss
        bubbleTransition.startingPoint = CGPoint(x: 45, y: self.view.bounds.size.height-45)
        bubbleTransition.bubbleColor = UIColor.redColor()
        return bubbleTransition
    }
    
    
  
    
    
 
   

}

