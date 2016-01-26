//
//  SearchingTagViewController.h
//  FindMyBag
//
//  Created by hebiao on 15/7/31.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import "BaseViewController.h"

@interface SearchingTagViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *table;
    
    
    UISwitch *switch1;
    
    
    UISlider *slider;
    
    
}

@property (retain) NSString *UUIDString;



@end
