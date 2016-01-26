//
//  LocationListViewController.m
//  FindMyBag
//
//  Created by hebiao on 15-7-28.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import "LocationListViewController.h"
#import "HeadFile.h"
#import "LocationTableViewCell.h"
#import "LocationBean.h"

@interface LocationListViewController ()

@end

@implementation LocationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    arrList=[[NSMutableArray alloc] init];
    [arrList addObjectsFromArray:[LocationBean getAllLocationBean]];
    
    self.nagationLabel.text=CustomLocalizedString(@"nagation_title_21", nil);
    table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44-20)];
    table.delegate=self;
    table.dataSource=self;
    table.showsVerticalScrollIndicator=NO;
    table.separatorColor=[UIColor lightGrayColor];
    [self.view addSubview:table];
    
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CustomLocalizedString(@"cell_text_22", nil);
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSDictionary *dic=arrList[indexPath.row];
        
        [LocationBean deleteLostBean:dic[@"_id"]];
        
        [arrList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [arrList count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 120;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LocationTableViewCell *cell=(LocationTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"LocationTableViewCell" owner:self options:nil][0];
 
    
    
    NSDictionary *dic=arrList[indexPath.row];
    
    
    
    if ([dic[@"imageName"] length]>0&&[StaticFunction localExistenceThisImage:dic[@"imageName"]]) {
        UIImage *imageFromDictionary = [UIImage imageWithContentsOfFile:[[StaticFunction imageFilePath] stringByAppendingPathComponent:dic[@"imageName"]]];
        [cell.tagImageView setImage:imageFromDictionary];
        
    }
    
    cell.tagNameLabel.text=dic[@"tagName"];
    cell.dateAndTimeLabel.text=dic[@"lostTime"];
    cell.latAndLotLabel.text=[NSString stringWithFormat:@"%@:%@,%@",CustomLocalizedString(@"tabbar_location_3", nil),dic[@"lostLat"],dic[@"lostLot"]];
    cell.locationLabel.text=dic[@"lostAddress"];
    
    
    
    return cell;
    
  
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
