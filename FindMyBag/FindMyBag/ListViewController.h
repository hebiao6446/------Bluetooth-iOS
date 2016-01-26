//
//  ListViewController.h
//  FindMyBag
//
//  Created by hebiao on 15/7/15.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import "BaseViewController.h"
#import "BLEHelper.h"
#import "DeviceBeanLocation.h"
#import "ReloadListViewDelegate.h"
#import "DisconnectBluethDelegate.h"





@interface ListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,MyDelegate,DeviceBeanLocationDelegate,ReloadListViewDelegate,DisconnectBluethDelegate>{
    
    UITableView *table;
    
 
    
    NSMutableArray *arrListConnetction;
    
    
    NSMutableArray *arrList;
    BLEHelper *ble;
   
    int lostTimeCount;
    
    
    
    DeviceBeanLocation *deviceBeanLoaction;
    
    
    NSMutableString *addressString;
    CLLocationDegrees lat,latCopy;
    CLLocationDegrees lot,lotCopy;
    
    
 
    
    
}


@end
