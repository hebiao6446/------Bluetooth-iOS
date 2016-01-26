//
//  DeviceBeanLocation.h
//  DoubleCoinTires
//
//  Created by hebiao on 15/8/27.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@protocol DeviceBeanLocationDelegate <NSObject>


-(void)getDeviceBeanLocationSuc:(CLLocationCoordinate2D )cc2d address:(NSString *)address;

@end

@interface DeviceBeanLocation : NSObject<CLLocationManagerDelegate> 
+(instancetype)shareInstance;
 
@property(strong,nonatomic) CLLocationManager *locationManager;
@property (nonatomic, assign) id<DeviceBeanLocationDelegate> delegate;

-(void)startLocation;



@end
