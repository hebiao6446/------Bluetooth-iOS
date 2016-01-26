//
//  BaiduMapManager.h
//  FindMyBag
//
//  Created by hebiao on 15/8/28.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI/BMapKit.h>


@protocol BaiduMapManagerDelegate <NSObject>

@required

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser;
/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation;
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation;

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser;

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error;





-(BMKAnnotationView *)baiduMapView:(BMKMapView *)View viewForAnnotation:(id<BMKAnnotation>)annotation;





@end

@interface BaiduMapManager : NSObject<BMKMapViewDelegate,BMKLocationServiceDelegate>


@property (assign,nonatomic) id<BaiduMapManagerDelegate> delegate;

@end
