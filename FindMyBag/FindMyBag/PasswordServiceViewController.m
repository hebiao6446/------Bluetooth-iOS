//
//  PasswordServiceViewController.m
//  FindMyBag
//
//  Created by hebiao on 15-7-27.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import "PasswordServiceViewController.h"
#import "HeadFile.h"

#import "SettingPasswordViewController.h"


@interface PasswordServiceViewController ()

@end

@implementation PasswordServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nagationLabel.text=CustomLocalizedString(@"cell_title_10", nil);
    
    table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44-20) style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
    table.separatorColor=[UIColor lightGrayColor];
    [self.view addSubview:table];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [table reloadData];
    
    
    
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
    
    
    
    return 2;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id"];
    
    
    
    
    
    UILabel *txt1=[[UILabel alloc] init];
    txt1.frame=CGRectMake(15, 7, 200, 30);
 
    if (indexPath.row==0) {
        txt1.textColor=[UIColor blackColor];
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:NSUSERDEFAULTS_HAVE_PASSWORD_3]) {
          txt1.text=CustomLocalizedString(@"cell_title_24", nil);
        }else{
          txt1.text=CustomLocalizedString(@"cell_title_23", nil);
        }
       
    }else{
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:NSUSERDEFAULTS_HAVE_PASSWORD_3]) {
            txt1.textColor=[UIColor blackColor];
            cell.selectionStyle=UITableViewCellSelectionStyleGray;
        }else{
            txt1.textColor=[UIColor grayColor];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        
       
        txt1.text=CustomLocalizedString(@"cell_title_25", nil);
    }
    
    txt1.backgroundColor=[UIColor clearColor];
    [cell addSubview:txt1];
    
    
    
    return cell;
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:NSUSERDEFAULTS_HAVE_PASSWORD_3]) {
        
        SettingPasswordViewController *spvc=[[SettingPasswordViewController alloc] init];
        
        
        if (indexPath.row==0) {
            spvc.operaType=PasswordOperationTypeClose;
        }else{
           spvc.operaType=PasswordOperationTypeChange;
        }
        
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        [self.navigationController pushViewController:spvc animated:YES];
        
    }else{
        
        if (indexPath.row==0) {
            SettingPasswordViewController *spvc=[[SettingPasswordViewController alloc] init];
            spvc.operaType=PasswordOperationTypeOpen;
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
            [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
            [self.navigationController pushViewController:spvc animated:YES];
        }
    }
    
  
    
   
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
