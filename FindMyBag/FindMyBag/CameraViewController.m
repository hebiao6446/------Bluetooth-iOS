//
//  CameraViewController.m
//  FindMyBag
//
//  Created by hebiao on 15/7/15.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import "CameraViewController.h"
#import "HeadFile.h"
#import "LostBean.h"

@interface CameraViewController()

@end

@implementation CameraViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)changeLanguagueAction:(id)sender{
    self.nagationLabel.text=CustomLocalizedString(@"nagation_title_6", nil);
}
-(void)viewDidLoad{
    [super viewDidLoad];
    
     self.nagationLabel.text=CustomLocalizedString(@"nagation_title_6", nil);
    
    
    
}


@end
