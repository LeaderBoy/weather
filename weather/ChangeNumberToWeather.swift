//
//  ChangeNumberToWeather.swift
//  weather
//
//  Created by 杨志远 on 16/7/8.
//  Copyright © 2016年 杨志远. All rights reserved.
//

import UIKit
import SwiftDate

class ChangeNumberToWeather: UIView {
    
    var label : UILabel?

    var isNight : Bool?

    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func with(dataArray:NSMutableArray,weatherData:WeatherData)
    {
        
        
        
        //MARK:判断当前时间是白天还是晚上
        
      let model = dataArray[0] as! WeatherData
        
        let nowDate = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "YYYY-MM-ddHH:mm"
        formatter.locale = NSLocale(localeIdentifier: "zh_CN")

        let str = model.date?.stringByAppendingString(model.ss as!String)
        
        
       let ssDate = formatter.dateFromString(str!)
        
        
        
        let zone = NSTimeZone.systemTimeZone()
        
        
        let nowInterval = NSTimeInterval(zone.secondsFromGMTForDate(nowDate))
        
        let now = nowDate.dateByAddingTimeInterval(nowInterval)
        
        let ss = ssDate?.dateByAddingTimeInterval(nowInterval);

        
        
        isNight = now > ss ? true : false
        
        
        //MARK:显示星星的VIEW
        let star =  StarView(frame: CGRect(x: 10, y: 100, width: 40, height: 40))
        
        self.addSubview(star)
        
        
        
        //MARK:显示下雪的VIEW
        let snow = SnowView(frame: CGRectMake(0,0,self.bounds.size.width,400))
        
        self.addSubview(snow)
        
        
        //MARK : 显示雾的View
        let fog = FogView(frame: CGRectMake(0,150,self.bounds.size.width,400))
        
        self.addSubview(fog)
        
        //MARK:显示沙尘的View
        let dust = DustView(frame: CGRectMake(0,150,self.bounds.size.width,400))
        
        self.addSubview(dust)
        
        
        //MARK:显示下雨VIEW
        let rain = RainView(frame: CGRectMake(0,0,self.bounds.size.width,400))
        
        self.addSubview(rain)
        
        
        
        
        //MARK:显示晚间月亮的VIEW
        let mnView = UIView(frame: CGRectMake(self.bounds.size.width-120,20,100,100))
        
        let moon = MoonView(frame: CGRect(x: 0, y:0, width: 100, height: 100))
        
        mnView.addSubview(moon)
        
        self.addSubview(mnView)
        

        
        //MARK:显示白天晴天的VIEW
        let sun = SunView(frame:CGRectMake(self.bounds.size.width-120,20,100,100))
        self.addSubview(sun)
        
        
        
        //MARK:显示冰雹的View
        
        let hail = HailView(frame: CGRectMake(0,0,self.bounds.size.width,400))
        
        self.addSubview(hail)
        
        
        //MARK:显示风的View
        
        let wind = WindView(frame: CGRect(x: self.bounds.size.width-160, y: self.bounds.size.height-120, width: 75, height: 75+75/2))
        self.addSubview(wind)

        
        
        //MARK:显示云彩
        let cloud1 = CloudView(frame: CGRect(x: 100, y: 0, width: 90, height: 40))
        cloud1.cloudImageName = ("bg-sunny-cloud-1")
        
        let cloudView1 = UIView(frame: CGRect(x: 0, y: 20, width: 90, height: 30))
        cloudView1.addSubview(cloud1)
        self.addSubview(cloudView1)
        self.animateCloud(cloudView1,animation: true)
        
        
        let cloud2 = CloudView(frame: CGRect(x: 0, y: 0, width: 90, height: 30))
        cloud2.cloudImageName = ("bg-sunny-cloud-2")
        let cloudView2 = UIView(frame: CGRect(x: 0, y: 100, width: 90, height: 30))
        
        cloudView2.addSubview(cloud2)
        self.addSubview(cloudView2)
        self.animateCloud(cloudView2,animation: true)

        
        
        let cloud3 = CloudView(frame: CGRect(x: 0, y: 0, width: 90, height: 45))
        cloud3.cloudImageName = ("bg-sunny-cloud-3")
        let cloudView3 = UIView(frame: CGRect(x: 200, y: 50, width: 90, height: 30))
        
        cloudView3.addSubview(cloud3)
        self.addSubview(cloudView3)
        self.animateCloud(cloudView3,animation: true)

        
        let cloud4 = CloudView(frame: CGRect(x: 0, y: 0, width: 90, height: 45))
        cloud4.cloudImageName = ("bg-sunny-cloud-4")
        let cloudView4 = UIView(frame: CGRect(x: 300, y: 150, width: 90, height: 30))
        
        cloudView4.addSubview(cloud4)
        self.addSubview(cloudView4)
        self.animateCloud(cloudView4,animation: true)
        
        
        let cloud5 = CloudView(frame:CGRect(x: self.bounds.size.width-130, y: 45, width: 140, height: 70))
        
        let cloudView5 = UIView(frame: CGRect(x: self.bounds.size.width-130, y: 45, width: 140, height: 70))
        cloud5.frame = CGRect(x: 0, y: 0, width: 140, height: 70)
        cloud5.cloudImageName = "bg-sunny-cloud-3"
        cloudView5.addSubview(cloud5)
        self.addSubview(cloudView5)
        self.animateCloud(cloudView3, animation: false)
        

        
        
        switch weatherData.code!.intValue {
        case 100:
            //MARK:晴

            sun.show(true)
            wind.show(.NONE)
            self.configueBackgroundImageWith(isNight!, lightImageName: "day", nightImageName: "light1")
      
        case 101,103:
            //MARK:晴间多云
            //MARK:多云
            sun.show(false)
            cloud1.show()

            cloud2.show()

            cloud3.show()

            cloud4.show()
            wind.show(.SMALLWIND)
            self.configueBackgroundImageWith(isNight!, lightImageName: "day", nightImageName: "light1")

            
           case 102:
            //MARK:少云,微风
            sun.show(true)
            cloud3.show()
            wind.show(.SMALLWIND)
            self.configueBackgroundImageWith(isNight!, lightImageName: "day", nightImageName: "light1")

            
            
        case 104:
            //MARK:阴
            
            sun.show(false)
           
            
            cloud5.show()
            self.configueBackgroundImageWith(isNight!, lightImageName: "day", nightImageName: "light1")


            
            
            case 200,201,202,203,204:
            //MARK:有风
                //MARK:平静
                
                //MARK:微风
                
                //MARK:和风
                //MARK:清风
            sun.show(true)
            wind.show(.SMALLWIND)
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "day", nightImageName: "light1")

            
     
           

            
            case 205,206:
            //MARK:强风
            //MARK:疾风
            wind.show(.MIDWIND)
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "day", nightImageName: "light1")

            
            case 207,208:
            //MARK:大风
            //MARK:烈风

            wind.show(.BIGWIND)
            dust.show(DustType.SMALLDUST)
            fog.show(FogType.SMALLFOG, colorType: ColorType.DUSTCOLOR)
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "day", nightImageName: "light1")

            
            case 209,210,211,212,213:
            //MARK:风暴
                //MARK:狂风暴
                //MARK:飓风
                //MARK:龙卷风
                //MARK:热带风暴
            wind.show(.STORMWIND)
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "day", nightImageName: "light1")

        
            //MARK:阵雨
            case 300:
            
            rain.show(true, rainType: .SMALLRAIN, thunderSound: false, thunderType: .NONE)
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "day", nightImageName: "light1")


            //MARK:强阵雨

            case 301:
            
            rain.show(true, rainType: .MIDRAIN, thunderSound: false, thunderType: .NONE)
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "day", nightImageName: "light1")

            
            case 302:
            rain.show(true, rainType: .BIGRAIN, thunderSound: false, thunderType: .NONE)
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "day", nightImageName: "light1")


            
            //MARK:雷阵雨
            case 303:
            rain.show(true, rainType: .MIDRAIN, thunderSound: true, thunderType: .MIDTHUNDER)
            
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "day", nightImageName: "light1")


            
            
            //MARK:强雷阵雨
            case 304:
            rain.show(true, rainType: .BIGRAIN, thunderSound: true, thunderType: .BIGTHUNDER)
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "day", nightImageName: "light1")


            //MARK:雷阵雨伴有冰雹
            case 305:
                
            hail.show()

            rain.show(true, rainType: .MIDRAIN, thunderSound: true, thunderType: .MIDTHUNDER)
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "day", nightImageName: "light1")

    
            //MARK:小雨
            case 306:
            rain.show(true, rainType: .SMALLRAIN, thunderSound: true, thunderType: .SMALLTHUNER)
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "day", nightImageName: "light1")


            
            //MARK:中雨
            case 307:
            rain.show(true, rainType: .MIDRAIN, thunderSound: true, thunderType: .MIDTHUNDER)
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "day", nightImageName: "light1")


            //MARK:大雨
            case 308:
            rain.show(true, rainType: .BIGRAIN, thunderSound: true, thunderType: .BIGTHUNDER)

            //MARK:极端降雨
            case 309:
            
            rain.show(true, rainType: .BIGRAIN, thunderSound: false, thunderType: .BIGTHUNDER)
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "day", nightImageName: "light1")


            
            
            //MARK:毛毛雨
            case 310:
            rain.show(true, rainType: .SMALLRAIN, thunderSound: false, thunderType: .NONE)
            
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "day", nightImageName: "light1")


            //MARK:暴雨
            case 311:
            rain.show(true, rainType: .BIGRAIN, thunderSound: true, thunderType: .BIGTHUNDER)
            
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "day", nightImageName: "light1")


            
            //MARK:大暴雨
            case 312:
            
            rain.show(true, rainType: .HEAVYRAIN, thunderSound: true, thunderType: .BIGTHUNDER)
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "day", nightImageName: "light1")


            //MARK:特大暴雨
            case 313:
            rain.show(true, rainType: .STORMRAIN, thunderSound: true, thunderType: .BIGTHUNDER)
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "day", nightImageName: "light1")


            //MARK:冻雨
            case 400:
                rain.show(true, rainType: .SMALLRAIN, thunderSound: false, thunderType: .NONE)
            
                self.configueBackgroundImageWith(isNight!, lightImageName: "day", nightImageName: "light1")


            
            
            //MARK:小雪
            case 401:
            
            snow.show(true, snowType: .SMALLSNOW)
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "dayCold", nightImageName: "lightCold")

            //MARK:中雪
            case 402:
            snow.show(true, snowType: .MIDSNOW)
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "dayCold", nightImageName: "lightCold")

            
            //MARK:大雪
            case 403:
            snow.show(true, snowType: .BIGSNOW)
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "dayCold", nightImageName: "lightCold")

            //MARK:暴雪
            case 404:
            snow.show(true, snowType: .HEAVYSNOW)
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "dayCold", nightImageName: "lightCold")

            //MARK:雨夹雪
            //MARK:雨雪天气
            //MARK:阵雨夹雪
            case 405,406,407:
            rain.show(true, rainType: .MIDRAIN, thunderSound: false, thunderType: .NONE)
            
            snow.show(false, snowType: .SMALLSNOW)
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "dayCold", nightImageName: "lightCold")

            
            //MARK:阵雪
            case 500:
                snow.show(false, snowType: .MIDSNOW)

                self.configueBackgroundImageWith(isNight!, lightImageName: "dayCold", nightImageName: "lightCold")

            
            //MARK:薄雾
            case 501:
            
            fog.show(FogType.SMALLFOG, colorType: ColorType.FOGCOLOR)
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "day", nightImageName: "light1")

            
            //MARK:雾
            //MARK:霾

            case 502,503:
                
            fog.show(.SMALLFOG, colorType: .FOGCOLOR)
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "day", nightImageName: "light1")


            //MARK:扬沙
            //MARK:浮沉
            //MARK:火山灰

            case 504,506:
                
            fog.show(.SMALLFOG, colorType: ColorType.DUSTCOLOR)

            dust.show(.SMALLDUST)
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "day", nightImageName: "light1")


            //MARK:沙尘暴
            //MARK:强沙尘暴


            case 507,508:
            fog.show(FogType.NORMALFOG, colorType: ColorType.DUSTCOLOR)
                
            dust.show(DustType.BIGDUST)
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "day", nightImageName: "light1")

            
            //MARK:热
            //MARK:冷
            //MARK:未知

            case 900:
            
            sun.show(true)
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "hotDay", nightImageName: "hotLight")
            
        case 901:
            
            sun.show(true)
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "dayCold", nightImageName: "lightCold")

        
            
        default:
            sun.show(true)
            
            self.configueBackgroundImageWith(isNight!, lightImageName: "day", nightImageName: "light1")

            


        }
    }
    
    
    //MARK:云彩移动的动画
    func animateCloud(cloudView: UIView, animation: Bool)
    {
        if animation
        {
            let cloudViewSpeed = 60.0/self.frame.size.width
            
            let duration = (self.frame.size.width - cloudView.frame
                .origin.x) * cloudViewSpeed * 1.5
            
            
            UIView.animateWithDuration(NSTimeInterval(duration), delay: 0.0, options: .CurveLinear, animations: { () -> Void in
                cloudView.frame.origin.x  = self.frame.size.width
                }, completion:{_ in
                    
                    cloudView.frame.origin.x = -cloudView.frame.size.width
                    
                    self.animateCloud(cloudView,animation: true)
                    
                }
            )
        }
        
        
        }
    
    
    //MARK:根据时间判断显示的背景图
    func configueBackgroundImageWith(isNight:Bool,lightImageName:String,nightImageName:String)
    {
        if isNight
        {
            self.backgroundColor = UIColor(patternImage: UIImage(named: nightImageName)!)
        }else
        {
            self.backgroundColor = UIColor(patternImage: UIImage(named: lightImageName)!)

        }
    }
    
    
    
    
}
