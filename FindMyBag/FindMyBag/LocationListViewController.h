//
//  LocationListViewController.h
//  FindMyBag
//
//  Created by hebiao on 15-7-28.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import "BaseViewController.h"

@interface LocationListViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *table;
    
    
    NSMutableArray *arrList;
    
}



@end
