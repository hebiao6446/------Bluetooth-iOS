//
//  LanguageSwitchingViewController.m
//  FindMyBag
//
//  Created by hebiao on 15-7-27.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import "LanguageSwitchingViewController.h"
#import "HeadFile.h"

@interface LanguageSwitchingViewController ()

@end

@implementation LanguageSwitchingViewController



-(void)changeLanguagueAction:(id)sender{
    self.nagationLabel.text=CustomLocalizedString(@"nagation_title_16", nil);
    [table reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
  self.nagationLabel.text=CustomLocalizedString(@"nagation_title_16", nil);
    
   
    
    arrList=[[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LanguageSupport" ofType:@"plist"]];
    
    // Do any additional setup after loading the view.
    table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44-20) style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
    table.separatorColor=[UIColor lightGrayColor];
    [self.view addSubview:table];
}
/*
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0;
}
 */


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    return [arrList count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id"];
    
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    
//    if (indexPath.row==1) {
//
//        
//    }
    
    
    NSDictionary *dic = arrList[indexPath.row];
    
    NSString *spoLan=dic[@"enname"];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:NSUSERDEFAULTS_SYSTEM_LANGUE_1] isEqualToString:spoLan]) {
        
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    }
    
    UILabel *txt1=[[UILabel alloc] init];
    txt1.frame=CGRectMake(15, 7, 200, 30);
    txt1.text=dic[@"name"];
    txt1.backgroundColor=[UIColor clearColor];
    [cell addSubview:txt1];
    
    
    
    return cell;
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
 
    
    NSString *spoLan=arrList[indexPath.row][@"enname"];
    [[NSUserDefaults standardUserDefaults] setObject:spoLan forKey:NSUSERDEFAULTS_SYSTEM_LANGUE_1];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNOTICE_CHANGE_SYSTEM_LANGUAGE object:nil];
    
    
    
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
