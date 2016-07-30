//
//  playSoundEffect.swift
//  weather
//
//  Created by 杨志远 on 16/6/4.
//  Copyright © 2016年 杨志远. All rights reserved.
//

import UIKit
//MARK:导入播放音乐的框架
import AVFoundation


public class playSoundEffect {
//MARK:实现单例
   public static let shareinstance = playSoundEffect()
    private init() {}
    
    

    //播放下雨的声音
    lazy var audioRainPlayer : AVAudioPlayer! = {
        
        let player = AVAudioPlayer()
        return player
    }()
    //雨声的url
    var rainUrl : NSURL?
    //播放打雷的声音
    lazy var audioThunderPlayer : AVAudioPlayer! = {
        
        let player = AVAudioPlayer()
        return player
    }()
    //雷声的url
    var thunderUrl : NSURL?
    //播放雪地的声音
    lazy var audioSnowPlayer : AVAudioPlayer! = {
        
        let player = AVAudioPlayer()
        return player
    }()
    //雪地声音的url
    var snowUrl : NSURL?
    //播放夜间蛐蛐的叫声
    lazy var audioMoonPlayer : AVAudioPlayer! = {
        
        let player = AVAudioPlayer()
        return player
    }()
    var moonUrl : NSURL?
    
    //播放晴天的鸟叫声
    lazy var audioSunPlayer : AVAudioPlayer! = {
        
        let player = AVAudioPlayer()
        return player
    }()
    var sunUrl : NSURL?
    
    
    
    //MARK:播放下雨时的音效调用的方法
    func playRainSoundEffect(rainType:RainType,withSound:Bool)
    {
        switch rainType {
        case .SMALLRAIN:
            rainUrl =  NSBundle.mainBundle().URLForResource("midRain", withExtension: "mp3")
        case .MIDRAIN:
            rainUrl =  NSBundle.mainBundle().URLForResource("midRain", withExtension: "mp3")
        case .BIGRAIN:
            rainUrl =  NSBundle.mainBundle().URLForResource("bigRain", withExtension: "mp3")
        case .HEAVYRAIN:
            rainUrl =  NSBundle.mainBundle().URLForResource("bigRain", withExtension: "mp3")
        case .STORMRAIN:
            rainUrl =  NSBundle.mainBundle().URLForResource("bigRain", withExtension: "mp3")

            
        default:
            rainUrl =  NSBundle.mainBundle().URLForResource("smallRain", withExtension: "mp3")
        }
        
        //醉了
        //解决call to throw的错误
        do
        {
            
            audioRainPlayer = try AVAudioPlayer(contentsOfURL: rainUrl!)
            
        }catch{
        
        
            print(error)
        }
        
        
      
        
        //开始播放
        if withSound
        {
            //设置重复播放音效
            audioRainPlayer?.numberOfLoops = -1
            audioRainPlayer?.play()

        }else
        {
            audioRainPlayer.stop()

        }
        
  
        
    }
    //MARK:播放打雷时的音效调用的方法
    
    func playThunderSoundEffect(thunderType:ThunderType,withSound : Bool)
    {
        
        switch thunderType {
        case .SMALLTHUNER:
             thunderUrl = NSBundle.mainBundle().URLForResource("thunder", withExtension: "mp3")
        case .MIDTHUNDER:
            thunderUrl = NSBundle.mainBundle().URLForResource("bigThunder", withExtension: "mp3")
        case .BIGTHUNDER:
            thunderUrl = NSBundle.mainBundle().URLForResource("bigThunder", withExtension: "mp3")
            
        default:
            thunderUrl = NSBundle.mainBundle().URLForResource("thunder", withExtension: "mp3")
        }
        
       
        do{
            audioThunderPlayer = try AVAudioPlayer(contentsOfURL: thunderUrl!)
            
        }catch{}
        
        
        
        if withSound
        {
            audioThunderPlayer?.numberOfLoops = -1
            audioThunderPlayer?.play()

        }else
        {
            audioThunderPlayer.stop()
        }
        
        

    }
    //MARK:播放晴天时候鸟叫的音效
    func playSunSoundEffect()
    {
        sunUrl = NSBundle.mainBundle().URLForResource("bird", withExtension: "mp3")
        do{
            audioSunPlayer = try AVAudioPlayer(contentsOfURL: sunUrl!)
            
        }catch{}
        
        
        audioSunPlayer?.numberOfLoops = -1
        audioSunPlayer?.play()
        
        
        
    }
    
    
    
    
    //MARK:播放雪地音效时调用的方法
    func playSnowfieldSoundEffect()
    {
        snowUrl = NSBundle.mainBundle().URLForResource("snowField", withExtension: "mp3")
        do{
            audioSnowPlayer = try AVAudioPlayer(contentsOfURL: snowUrl!)
            
        }catch{}
        
        
        audioSnowPlayer?.numberOfLoops = -1
        audioSnowPlayer?.play()
        

    }
    
    //MARK:播放月夜时的音效
    func playMoonSoundEffect()
    {
        moonUrl = NSBundle.mainBundle().URLForResource("ququ", withExtension: "mp3")
        do{
            audioMoonPlayer = try AVAudioPlayer(contentsOfURL: moonUrl!)
            
        }catch{}
        
        
        audioMoonPlayer?.numberOfLoops = -1
        audioMoonPlayer?.play()
        
    }
    
   //MARK:停止所有的声音
    func stopAllSound()
    {
        if audioThunderPlayer != nil
        {
            audioThunderPlayer.stop()

        }
        
        if audioSunPlayer != nil
        {
            audioSunPlayer.stop()

        }
        
        if audioMoonPlayer != nil
        {
            audioMoonPlayer.stop()

        }
        
        if audioRainPlayer != nil
        {
            audioRainPlayer.stop()

        }
        
        if audioSnowPlayer != nil
        {
            audioSnowPlayer.stop()

        }
    
    }
    
    
    
    
}
