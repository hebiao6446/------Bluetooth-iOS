//
//  AntiLostViewController.h
//  FindMyBag
//
//  Created by hebiao on 15/7/31.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import "BaseViewController.h"

@interface AntiLostViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *table;
    
    
    
    UISwitch *switch1, *switch2;
    
    UISlider *slider;
    
    
}

@property (retain) NSString *UUIDString;


@end
