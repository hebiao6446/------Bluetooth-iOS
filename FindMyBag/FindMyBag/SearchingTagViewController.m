//
//  SearchingTagViewController.m
//  FindMyBag
//
//  Created by hebiao on 15/7/31.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import "SearchingTagViewController.h"
#import "HeadFile.h"
#import "RingSelectViewController.h"

#import "DeviceBean.h"


@interface SearchingTagViewController ()

@end

@implementation SearchingTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nagationLabel.text=CustomLocalizedString(@"cell_title_37", nil);
    
    
    table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44-20) style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
    table.separatorColor=[UIColor lightGrayColor];
    [self.view addSubview:table];
    
    
    switch1=[[UISwitch alloc] init];
    switch1.frame=CGRectMake(self.view.frame.size.width-60, 22+10+20, 60, 40);
     [switch1 addTarget:self action:@selector(switch1Action:) forControlEvents:UIControlEventValueChanged];
    [table addSubview:switch1];
    
    
    slider=[[UISlider alloc] init];
    slider.frame=CGRectMake(15+30+10, 98+20+10+14, self.view.frame.size.width-(15+30+10)*2, 20);
    slider.minimumValue = 0;
    slider.maximumValue = 10;
    slider.value = 5;
    [slider addTarget:self action:@selector(updateValue:) forControlEvents:UIControlEventValueChanged];
    [table addSubview:slider];
    [self allocData];
}

-(void)allocData{
    
    DeviceBean *db=[DeviceBean getDeviceBeanByUUID:self.UUIDString];
    slider.value =[db.findVoiceLevel floatValue];
    
    if ([db.findLight isEqualToString:@"0"]) {
        switch1.on=NO;
        
    }else{
        switch1.on=YES;
    }
    
    
    
    
}

-(void)updateValue:(UISlider *)sender{
    //    NSLog(@"%f ",sender.value);
    
    [DeviceBean updateFindVoiceLevel:[NSString stringWithFormat:@"%.2f",sender.value] uuid:self.UUIDString];
    
    
}
-(void)switch1Action:(UISwitch *)sender{
    
    
    [DeviceBean updateFindLight:sender.isOn?@"1":@"0" uuid:self.UUIDString];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==1) {
        return 2;
    }
    
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0){
        return CustomLocalizedString(@"cell_title_39", nil);
    }else if (section==1){
        return CustomLocalizedString(@"cell_title_41", nil);
    }
    
    return @"";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 45;
    }
    return 25;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id"];
    
    if (indexPath.section==1&&indexPath.row==1) {
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    
    
    UILabel *txt1=[[UILabel alloc] init];
    txt1.frame=CGRectMake(15, 7, 200, 30);
   if (indexPath.section==0){
        txt1.text=CustomLocalizedString(@"cell_title_40", nil);
    }else if (indexPath.section==1&&indexPath.row==1){
        txt1.text=CustomLocalizedString(@"cell_title_42", nil);
    }
    txt1.backgroundColor=[UIColor clearColor];
    [cell addSubview:txt1];
    
    
    if (indexPath.section==1&&indexPath.row==0) {
        
        UIImageView *image1=[[UIImageView alloc] init];
        image1.frame=CGRectMake(15, 7, 30, 30);
        [image1 setImage:[UIImage imageNamed:@"smallVoice"]];
        [cell addSubview:image1];
        
        
        
        UIImageView *image2=[[UIImageView alloc] init];
        image2.frame=CGRectMake(self.view.frame.size.width-15-30, 7, 30, 30);
        [image2 setImage:[UIImage imageNamed:@"bigVoice"]];
        [cell addSubview:image2];
        
    }
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==1&&indexPath.row==1){
        
        RingSelectViewController *rsvc=[[RingSelectViewController alloc] init];
        rsvc.UUIDString=self.UUIDString;
        rsvc.fromFlag=NO;
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        [self.navigationController pushViewController:rsvc animated:YES];
        
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
