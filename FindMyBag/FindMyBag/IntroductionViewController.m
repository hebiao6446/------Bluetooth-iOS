//
//  IntroductionViewController.m
//  FindMyBag
//
//  Created by hebiao on 15/7/31.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import "IntroductionViewController.h"
#import "HeadFile.h"

@interface IntroductionViewController ()

@end

@implementation IntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.nagationLabel.text=CustomLocalizedString(@"nagation_title_35", nil);
    
    NSString *lanStr=[[NSUserDefaults standardUserDefaults] objectForKey:NSUSERDEFAULTS_SYSTEM_LANGUE_1];
    
    NSString *imgName=nil;
    
    if ([lanStr containsString:@"zh"]) {
        imgName=@"Introduction_ch";
    }else if ([lanStr containsString:@"ko"]){
        imgName=@"Introduction_ko";
    }else{
        imgName=@"Introduction_en";
    }
    
    
    
    UIImage *img=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imgName ofType:@"png"]];
    
    
    float xyRay= img.size.width/self.view.frame.size.width;
    
    
    UIScrollView *scroll=[[UIScrollView alloc] init];
    scroll.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44-20);
    scroll.backgroundColor=[UIColor clearColor];
    scroll.contentSize=CGSizeMake(self.view.frame.size.width, img.size.height/xyRay);
    
    
    
    
    UIImageView *imgView=[[UIImageView alloc] init];
    imgView.frame=CGRectMake(0, 0, self.view.frame.size.width, img.size.height/xyRay);
    [imgView setImage:img];
    [scroll addSubview:imgView];
    
    
    
    
    
    [self.view addSubview:scroll];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
