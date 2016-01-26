//
//  BaiduMapManager.m
//  FindMyBag
//
//  Created by hebiao on 15/8/28.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import "BaiduMapManager.h"

@implementation BaiduMapManager


- (void)willStartLocatingUser{
    [self.delegate willStartLocatingUser];
}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
    [self.delegate didUpdateUserHeading:userLocation];
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    [self.delegate didUpdateBMKUserLocation:userLocation];
}


- (void)didStopLocatingUser{
    [self.delegate didStopLocatingUser];
}


- (void)didFailToLocateUserWithError:(NSError *)error{
    [self.delegate didFailToLocateUserWithError:error];
}

-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    
    return [self.delegate baiduMapView:mapView viewForAnnotation:annotation];
}

@end
