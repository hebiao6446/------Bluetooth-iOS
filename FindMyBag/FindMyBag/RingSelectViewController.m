//
//  RingSelectViewController.m
//  FindMyBag
//
//  Created by hebiao on 15/7/31.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import "RingSelectViewController.h"
#import "HeadFile.h"
#import <AVFoundation/AVFoundation.h>

#import "DeviceBean.h"


@interface RingSelectViewController ()

@end

@implementation RingSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nagationLabel.text=CustomLocalizedString(@"cell_title_42", nil);
    
    
    [self allocData];
    
    
    arrList=[[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"rawlist" ofType:@"plist"]];
    
    // Do any additional setup after loading the view.
    table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44-20) style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
    table.separatorColor=[UIColor lightGrayColor];
    [self.view addSubview:table];
    
    
}



-(void)allocData{
    
    DeviceBean *db=[DeviceBean getDeviceBeanByUUID:self.UUIDString];
    
    if (self.fromFlag) {
        strVoiceName=db.warnVoice;
        voiceNameLevel=[db.warnVoiceLevel floatValue];
    }else{
        
        strVoiceName=db.findVoice;
        voiceNameLevel=[db.findVoiceLevel floatValue];
        
    }
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
    
    
  
    
    
    
    NSDictionary *d=arrList[indexPath.row];
    
    if ([d[@"resname"] isEqualToString:strVoiceName] ) {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType=UITableViewCellAccessoryNone;
    }

    
    UILabel *txt1=[[UILabel alloc] init];
    txt1.frame=CGRectMake(15, 7, 200, 30);
    NSString *txtStr= CustomLocalizedString(d[@"enname"], nil);
    txt1.text=txtStr;
    txt1.backgroundColor=[UIColor clearColor];
    [cell addSubview:txt1];
    
    
    
    return cell;
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    NSDictionary *d=arrList[indexPath.row];
    
 
    strVoiceName=d[@"resname"];
    
    if (self.fromFlag) {
 
        
        [DeviceBean updateWarnVoice:strVoiceName uuid:self.UUIDString];
        
    }else{
        
       
         [DeviceBean updateFindVoice:strVoiceName uuid:self.UUIDString];
        
    }

    
    [tableView reloadData];
    
    [self playSoud:strVoiceName];
    
    
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    if (self.player) {
        [self.player stop];
        self.player=nil;
    }
}

-(void)playSoud:(NSString *)nameString{
    
    if (self.player) {
        [self.player stop];
        self.player=nil;
    }

    
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:nameString ofType:@"mp3"];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:musicPath];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [self.player  prepareToPlay];
    [self.player  setVolume:voiceNameLevel];
    self.player.numberOfLoops=1;
    [self.player play];
    
    
    
   
    
    
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
