//
//  MapSwitchingViewController.m
//  FindMyBag
//
//  Created by hebiao on 15-7-27.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import "MapSwitchingViewController.h"
#import "HeadFile.h"
@interface MapSwitchingViewController ()

@end

@implementation MapSwitchingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nagationLabel.text=CustomLocalizedString(@"nagation_title_17", nil);

    // Do any additional setup after loading the view.
    table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
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
    
    
    
    return 2;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id"];
    
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    
    
    
    MapType t = [[NSUserDefaults standardUserDefaults] integerForKey:NSUSERDEFAULTS_SYSTEM_MAP_2];
    
    if ((t==MapTypeBaidu&&indexPath.row==0)||(t==MapTypeApple&&indexPath.row==1)) {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    }
    
    
    UILabel *txt1=[[UILabel alloc] init];
    txt1.frame=CGRectMake(15, 7, 200, 30);
    txt1.text=CustomLocalizedString(indexPath.row==0?@"cell_title_18":@"cell_title_19", nil);
    txt1.backgroundColor=[UIColor clearColor];
    [cell addSubview:txt1];
    
    
    
    return cell;
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MapType t=indexPath.row==0?MapTypeBaidu:MapTypeApple;
     NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
    [userDef setInteger:t forKey:NSUSERDEFAULTS_SYSTEM_MAP_2];
    [userDef synchronize];
    
    [table reloadData];
    
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
