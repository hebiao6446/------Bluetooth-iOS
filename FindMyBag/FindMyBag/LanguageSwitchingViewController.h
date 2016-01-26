//
//  LanguageSwitchingViewController.h
//  FindMyBag
//
//  Created by hebiao on 15-7-27.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import "BaseViewController.h"

@interface LanguageSwitchingViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *table;
    
    
    NSArray *arrList;
    
}


@end
