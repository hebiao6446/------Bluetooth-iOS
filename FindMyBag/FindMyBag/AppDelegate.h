//
//  AppDelegate.h
//  FindMyBag
//
//  Created by hebiao on 15-7-15.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <BaiduMapAPI/BMapKit.h>
#import <AVFoundation/AVFoundation.h>
 

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>{
    
    AVAudioPlayer *player;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;

@end

