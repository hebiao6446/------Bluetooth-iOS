//
//  LocationViewController.h
//  FindMyBag
//
//  Created by hebiao on 15/7/15.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import "BaseViewController.h"
#import <MapKit/MapKit.h>

#import <BaiduMapAPI/BMapKit.h>
#import "LostHistoryLocationDelete.h"
#import "BaiduMapManager.h"
@interface LocationViewController : BaseViewController<MKMapViewDelegate,LostHistoryLocationDelete,BaiduMapManagerDelegate>{
    
    
    
    BaiduMapManager *baiduMapManager;
   
    
    
    CLLocationCoordinate2D         curLocation;
    
    
    NSMutableDictionary *lostBeanDic;
    
    
     
    
    MKMapView  *appleMapView;
    
    
    BMKMapView* baiduMapView;
    
    BMKLocationService* baiduLocService;
    
    
    BOOL baiduMapGetLocationFlag;
    
    
    BOOL isNeedLocation;
    
    
    BOOL isFromDelegate;
    
    
    
    
}

@end
