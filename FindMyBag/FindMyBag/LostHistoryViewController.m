
//
//  LostHistoryViewController.m
//  FindMyBag
//
//  Created by hebiao on 15-7-28.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import "LostHistoryViewController.h"
#import "HeadFile.h"
#import "LostBean.h"
#import "LocationTableViewCell.h"
#import "CellLongPressGestureRecognizer.h"


@interface LostHistoryViewController ()

@end

@implementation LostHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nagationLabel.text=CustomLocalizedString(@"nagation_title_20", nil);
    
    
    deleteSection=-1;
    
    
    arrList=[[NSMutableArray alloc] init];
    [arrList addObjectsFromArray:[LostBean getAllLostBean]];
    
    
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
        
        NSMutableArray *muarr=arrList[indexPath.section][@"arr"];
        
        NSDictionary *dic=[[NSDictionary alloc] initWithDictionary:muarr[indexPath.row]];
        [LostBean deleteLostBean:dic[@"_id"]];
        
        
        [muarr removeObjectAtIndex:indexPath.row];
        
        if ([muarr count]==0) {
            [arrList removeObjectAtIndex:indexPath.section];
            
             [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic] ;
            
            
        }else{
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationAutomatic];
        }
      
     
        
     
        
        
    }
    
    
}

-(void)longPressToDo:(CellLongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
 
        deleteSection=gesture.tag;
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:CustomLocalizedString(@"actionsheet_txt_43", nil)
                                      delegate:self
                                      cancelButtonTitle:CustomLocalizedString(@"actionsheet_txt_44", nil)
                                      destructiveButtonTitle:CustomLocalizedString(@"cell_text_22", nil)
                                      otherButtonTitles:nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [actionSheet showInView:self.view];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (deleteSection==-1) {
        return;
    }
    
    if (buttonIndex==0) {
        
        NSDictionary *dic=[[NSDictionary alloc] initWithDictionary:arrList[deleteSection]];
        
        
         [LostBean deleteLostBean:dic[@"lostYear"] month:dic[@"lostMonth"]];
        
        [arrList removeObjectAtIndex:deleteSection];
        [table deleteSections:[NSIndexSet indexSetWithIndex:deleteSection] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        
    }
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    
    
    UIView *v=[[UIView alloc] init];
    v.frame=CGRectMake(0, 0, self.view.frame.size.width, 40);
    v.backgroundColor=HEX(0xeeeeee);
    CellLongPressGestureRecognizer * longPressGr = [[CellLongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    longPressGr.minimumPressDuration = 1.0;
    longPressGr.tag=section;
    [v addGestureRecognizer:longPressGr];
    
    
    NSDictionary *dic=arrList[section];
    
    UILabel *txtLel=[[UILabel alloc] init];
    txtLel.frame=CGRectMake(20, 10, self.view.frame.size.width-20, 20);
    txtLel.text=[NSString stringWithFormat:@"%@-%@",dic[@"lostYear"],dic[@"lostMonth"]];
    txtLel.textColor=[UIColor grayColor];
    txtLel.font=[UIFont systemFontOfSize:15];
    [v addSubview:txtLel];
    
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [arrList count];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [arrList[section][@"arr"] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 120;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LocationTableViewCell *cell=(LocationTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"LocationTableViewCell" owner:self options:nil][0];
    
    
    NSDictionary *dic=arrList[indexPath.section][@"arr"][indexPath.row];
    
    
    
    if ([dic[@"imageName"] length]>0&&[StaticFunction localExistenceThisImage:dic[@"imageName"]]) {
        UIImage *imageFromDictionary = [UIImage imageWithContentsOfFile:[[StaticFunction imageFilePath] stringByAppendingPathComponent:dic[@"imageName"]]];
        [cell.tagImageView setImage:imageFromDictionary];
        
    }
 
    cell.tagNameLabel.text=dic[@"tagName"];
    cell.dateAndTimeLabel.text=dic[@"lostTime"];
    cell.latAndLotLabel.text=[NSString stringWithFormat:@"%@:%@,%@",CustomLocalizedString(@"tabbar_location_3", nil),dic[@"lostLat"],dic[@"lostLot"]];
    cell.locationLabel.text=dic[@"lostAddress"];
    
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
     NSDictionary *dic=arrList[indexPath.section][@"arr"][indexPath.row];
    
    [self.delegate lostHistoryDidLocation:dic];
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
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
