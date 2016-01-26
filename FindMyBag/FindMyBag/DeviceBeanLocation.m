//
//  DeviceBeanLocation.m
//  DoubleCoinTires
//
//  Created by hebiao on 15/8/27.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import "DeviceBeanLocation.h"

@implementation DeviceBeanLocation


+(instancetype)shareInstance{
    
    static DeviceBeanLocation *shareIns=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareIns=[[DeviceBeanLocation alloc] init];
    });
    
    
    return shareIns;
}




-(id)init{
    if (self=[super init]) {
        [self allocLoaction];
        
        
    }
    
    
    return self;
    
}

-(void)allocLoaction{
    
    
    
  
    [self.delegate getDeviceBeanLocationSuc:CLLocationCoordinate2DMake(0, 0) address:@""];
    
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    //发生事件的最小距离间隔
    self.locationManager.distanceFilter = 1;
    if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    self.locationManager.delegate=self;
    [self.locationManager startUpdatingLocation];
    
}
-(void)startLocation{
     [self.locationManager startUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
  
    
    
    
    
    
    
    
}



- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    
  
}

 

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    
    if ([locations count]==0) {
        return;
    }
    
    CLLocation  *currLocation=[locations lastObject];
    
    
    CLGeocoder *geo=[[CLGeocoder alloc] init];
    
    [geo reverseGeocodeLocation:currLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (!error && [placemarks count] > 0)
        {
            
            for (CLPlacemark *placemark in placemarks) {
                
                
                
                    
                  
                    [self.delegate getDeviceBeanLocationSuc:currLocation.coordinate address:placemark.name];
                    
            
                
             
            }
            
        }
        else
        {
            NSLog(@"ERROR: %@", error); }
        
    }];
    
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
    NSLog(@"###########################");
    
}



@end
