//
//  LostHistoryViewController.h
//  FindMyBag
//
//  Created by hebiao on 15-7-28.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import "BaseViewController.h"
#import "LostHistoryLocationDelete.h"
@interface LostHistoryViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>{
    
    UITableView *table;
    
    NSMutableArray *arrList;
    
    
    
    NSInteger deleteSection;
    
    
}

@property(assign,nonatomic) id<LostHistoryLocationDelete>delegate;


@end
