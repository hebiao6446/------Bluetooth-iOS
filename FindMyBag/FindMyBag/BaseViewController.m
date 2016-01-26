//
//  BaseViewController.m
//  FindMyBag
//
//  Created by hebiao on 15/7/15.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import "BaseViewController.h"
#import "HeadFile.h"


//透明层显示时间
#define HUDDuration 2

@interface BaseViewController ()
@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguagueAction:) name:NSNOTICE_CHANGE_SYSTEM_LANGUAGE object:nil];
        
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nagation10"] forBarMetrics:UIBarMetricsDefault];
    
    
//    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:UIFON_SIZE_NAGATION_TITLE_2],NSFontAttributeName,nil]];
    
    
    self.nagationLabel=[[UILabel alloc] init];
    self.nagationLabel.frame=CGRectMake(0, 0, 200, 44);
    self.nagationLabel.backgroundColor=[UIColor clearColor];
    self.nagationLabel.textAlignment=NSTextAlignmentCenter;
    self.nagationLabel.textColor=UICOLOR_SYSTEM_GREEN_COLOR_1;
    self.nagationLabel.font=[UIFont systemFontOfSize:UIFON_SIZE_NAGATION_TITLE_2];
    self.navigationItem.titleView=self.nagationLabel;
    
    
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    
    
    
 
    
    
    // Do any additional setup after loading the view.
}

-(void)changeLanguagueAction:(id)sender{
    
}
//************************HUD************************
//初始化提示框
- (void)initHUD
{
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    self.progressHUD.delegate = self;
    [self.view addSubview:self.progressHUD];
}

- (void)myShowHUD:(MBProgressHUDMode)type :(NSString *)text {
    self.progressHUD.labelText = text;
    self.progressHUD.mode = MBProgressHUDModeText;
    [self.progressHUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

- (void)myTask {
    sleep(HUDDuration);
}
//************************HUD************************


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
