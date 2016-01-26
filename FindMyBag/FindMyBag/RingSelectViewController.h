//
//  RingSelectViewController.h
//  FindMyBag
//
//  Created by hebiao on 15/7/31.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface RingSelectViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *table;
    
    
    NSArray *arrList;
    
    NSString *strVoiceName;
    
    float voiceNameLevel;
    
}


@property BOOL fromFlag;
@property (retain) NSString *UUIDString;

@property(strong,nonatomic) AVAudioPlayer *player;

@end
