//
//  SettingViewController.m
//  FindMyBag
//
//  Created by hebiao on 15/7/15.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import "SettingViewController.h"
#import "HeadFile.h"

#import "LanguageSwitchingViewController.h"
#import "MapSwitchingViewController.h"
#import "PasswordServiceViewController.h"

@interface SettingViewController()

@end

@implementation SettingViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)changeLanguagueAction:(id)sender{
   self.nagationLabel.text = CustomLocalizedString(@"nagation_title_8", nil);
    [table reloadData];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
   self.nagationLabel.text=CustomLocalizedString(@"nagation_title_8", nil);
    
    table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49-44-20) style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
    table.separatorColor=[UIColor lightGrayColor];
    [self.view addSubview:table];
    
    
    
    swit=[[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width-70, 23.0f, 60.0f, 28.0f)];
    [swit addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [swit setOn:![[[NSUserDefaults standardUserDefaults] objectForKey:NSUSERDEFAULTS_NOWARN_5] isEqualToString:NSUSERDEFAULTS_NOWARN_5]];
    [table addSubview:swit];

    
    
}
-(void)switchAction:(UISwitch *)sender{
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    [def setObject:sender.isOn?NSUSERDEFAULTS_NOWARN:NSUSERDEFAULTS_NOWARN_5 forKey:NSUSERDEFAULTS_NOWARN_5];
    [def synchronize];
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==2) {
        return 1;
    }
    
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 15;
    }
    
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id"];
    
    
    
    if ((indexPath.section==0&&indexPath.row==1)||indexPath.section==1) {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
    }else{
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    
    UILabel *txt1=[[UILabel alloc] init];
    txt1.frame=CGRectMake(15, 7, 200, 30);
    txt1.text=[self cellTitle1:indexPath];
    txt1.backgroundColor=[UIColor clearColor];
    [cell addSubview:txt1];
    
    UILabel *txt2=[[UILabel alloc] init];
    txt2.frame=CGRectMake(self.view.frame.size.width-100, 7, 70, 30);
    txt2.font=[UIFont systemFontOfSize:11];
    txt2.textAlignment=NSTextAlignmentRight;
    txt2.text=[self cellTitle2:indexPath];
    txt2.backgroundColor=[UIColor clearColor];
    txt2.textColor=[UIColor lightGrayColor];
    [cell addSubview:txt2];
    
    return cell;
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==1) {
        
        if (indexPath.row==0) {
            LanguageSwitchingViewController *lsvc=[[LanguageSwitchingViewController alloc] init];
            lsvc.hidesBottomBarWhenPushed = YES;
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
            [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
            [self.navigationController pushViewController:lsvc animated:YES];
            
        }else if (indexPath.row==1){
            MapSwitchingViewController *msvc=[[MapSwitchingViewController alloc] init];
            msvc.hidesBottomBarWhenPushed = YES;
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
            [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
            [self.navigationController pushViewController:msvc animated:YES];
            
        }
    }else if (indexPath.section==0&&indexPath.row==1){
        
        PasswordServiceViewController *psvc=[[PasswordServiceViewController alloc] init];
        psvc.hidesBottomBarWhenPushed = YES;
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        [self.navigationController pushViewController:psvc animated:YES];
    }
    
}
-(NSString *)cellTitle1:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            
            return CustomLocalizedString(@"cell_title_9", nil);
        }else if (indexPath.row==1){
            return  CustomLocalizedString(@"cell_title_10", nil);;
            
        }
        
    }else if (indexPath.section==1){
        
        if (indexPath.row==0) {
            
            return  CustomLocalizedString(@"cell_title_11", nil);;
        }else if (indexPath.row==1){
            return  CustomLocalizedString(@"cell_title_12", nil);;
            
        }
        
    }else if (indexPath.section==2){
        if (indexPath.row==0) {
            
            return  CustomLocalizedString(@"cell_title_13", nil);;
        }
    }
    
    return @"";
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:
                                   [NSIndexPath indexPathForRow:1 inSection:0],
                                   nil] withRowAnimation:UITableViewRowAnimationNone];
}

-(NSString *)cellTitle2:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        if (indexPath.row==1) {
            
            if ([[NSUserDefaults standardUserDefaults] boolForKey:NSUSERDEFAULTS_HAVE_PASSWORD_3]) {
                  return  CustomLocalizedString(@"cell_title_14_a", nil);
            }else{
                 return  CustomLocalizedString(@"cell_title_14", nil);
            }
            
          
        }
        
    }else if (indexPath.section==2){
        return  CustomLocalizedString(@"cell_title_15", nil);;
    }
    
    return @"";
}



@end
