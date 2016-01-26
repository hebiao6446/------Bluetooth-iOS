//
//  BaseViewController.h
//  FindMyBag
//
//  Created by hebiao on 15/7/15.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface BaseViewController : UIViewController<MBProgressHUDDelegate>



@property(strong,nonatomic) UILabel *nagationLabel;
@property(strong,nonatomic) MBProgressHUD *progressHUD;
- (void)initHUD;

-(void)changeLanguagueAction:(id)sender;

@end
