//
//  ViewController.m
//  FindMyBag
//
//  Created by hebiao on 15-7-15.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import "ViewController.h"
#import "HeadFile.h"

#import "ListViewController.h"
#import "CameraViewController.h"
#import "LocationViewController.h"
#import "SettingViewController.h"


@interface ViewController()

@end

@implementation ViewController


-(void)changeTabBarTitle:(id)sender{
    t1.title=CustomLocalizedString(@"tabbar_list_1", nil);
    t2.title=CustomLocalizedString(@"tabbar_camera_2", nil);
    t3.title=CustomLocalizedString(@"tabbar_location_3", nil);
    t4.title=CustomLocalizedString(@"tabbar_settings_4", nil);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTabBarTitle:) name:NSNOTICE_CHANGE_SYSTEM_LANGUAGE object:nil];
    
    
    
    
    
    ListViewController *h1=[[ListViewController alloc ] init];
     t1=[self createTabBarItem:CustomLocalizedString(@"tabbar_list_1", nil) normalImage:@"tabbar1" selectedImage:@"tabbar5" itemTag:1];
    [h1 setTabBarItem:t1];
    
    
    
    CameraViewController *h2=[[CameraViewController alloc ] init];
     t2=[self createTabBarItem:CustomLocalizedString(@"tabbar_camera_2", nil) normalImage:@"tabbar2" selectedImage:@"tabbar6" itemTag:2];
    [h2 setTabBarItem:t2];
    
    

    LocationViewController *h3=[[LocationViewController alloc ] init];
    t3=[self createTabBarItem:CustomLocalizedString(@"tabbar_location_3", nil) normalImage:@"tabbar3" selectedImage:@"tabbar7" itemTag:3];
    [h3 setTabBarItem:t3];
    
    
    
    
    SettingViewController *h4=[[SettingViewController alloc ] init];
     t4=[self createTabBarItem:CustomLocalizedString(@"tabbar_settings_4", nil) normalImage:@"tabbar4" selectedImage:@"tabbar8" itemTag:4];
    [h4 setTabBarItem:t4];
    

    
    
    UINavigationController *h11=[[UINavigationController alloc] initWithRootViewController:h1];
    UINavigationController *h22=[[UINavigationController alloc] initWithRootViewController:h2];
    UINavigationController *h33=[[UINavigationController alloc] initWithRootViewController:h3];
    UINavigationController *h44=[[UINavigationController alloc] initWithRootViewController:h4];
    
    
    
    NSArray *viewControllers = [NSArray arrayWithObjects:h11,h22,h33,h44, nil];
    
    viewController=[[UITabBarController alloc] init];
    [[viewController tabBar] setBackgroundImage:[UIImage imageNamed:@"tabbar9"]];
    ////// 四个 整体的背景色
//    [[viewController tabBar] setSelectionIndicatorImage:[UIImage imageNamed:@"backimage2.png"]];  
    ///// 单个选中背景色
    viewController.viewControllers = viewControllers;
    viewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:viewController.view];
    
}



- (UITabBarItem *) createTabBarItem:(NSString *)strTitle normalImage:(NSString *)strNormalImg selectedImage:(NSString *)strSelectedImg itemTag:(NSInteger)intTag {
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:strTitle image:nil tag:intTag];
    
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UICOLOR_SYSTEM_GREEN_COLOR_1, NSForegroundColorAttributeName, [UIFont systemFontOfSize:UIFON_SIZE_TABBER_TITLE_1], NSFontAttributeName, nil] forState:UIControlStateSelected];
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UICOLOR_SYSTEM_GRAY_COLOR_2, NSForegroundColorAttributeName, [UIFont systemFontOfSize:UIFON_SIZE_TABBER_TITLE_1], NSFontAttributeName, nil] forState:UIControlStateNormal];
    [item setTitlePositionAdjustment:UIOffsetMake(item.titlePositionAdjustment.horizontal,item.titlePositionAdjustment.vertical/*-5.0*/)];
    
    
    
        [item setImage:[[UIImage imageNamed:strNormalImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item setSelectedImage:[[UIImage imageNamed:strSelectedImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    return  item  ;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
