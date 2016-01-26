//
//  ListViewController.m
//  FindMyBag
//
//  Created by hebiao on 15/7/15.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import "ListViewController.h"
#import "HeadFile.h"
#import "IntroductionViewController.h"
#import "BLEHelper.h"
#import "PerModel.h"
#import "ItagDetailViewController.h"
#import "DeviceBean.h"
#import "LostBean.h"

#import "DeviceListTableViewCell.h"

#import "PassWordViewController.h"
@interface ListViewController()

@end

@implementation ListViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)changeLanguagueAction:(id)sender{
    self.nagationLabel.text=CustomLocalizedString(@"nagation_title_5", nil);
    [table reloadData];
    
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.nagationLabel.text=CustomLocalizedString(@"nagation_title_5", nil);
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationWithMsg:) name:NSNOTICE_LOCATION_MSG object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startLocationAction:) name:NSNOTICE_LOCATION_START_ACTION object:nil];
    
    deviceBeanLoaction=[DeviceBeanLocation shareInstance];
    deviceBeanLoaction.delegate=self;
    
    
    arrList=[[NSMutableArray alloc] init];
    
    arrListConnetction=[[NSMutableArray alloc] init];
    
    
    
    addressString=[[NSMutableString alloc] initWithString:@""];
    lat=0;
    lot=0;
    latCopy=0;
    lotCopy=0;
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(passwordCheck) name:NSNOTICE_SHOW_PASSWORD_VIEW object:nil];
    
    [self createLeftBar];
    [self createRightBar];
    
    
    
    table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44-20-49)];
    table.delegate=self;
    table.dataSource=self;
    table.separatorColor=[UIColor lightGrayColor];
    [self.view addSubview:table];
   
    
    
    
    
    [self initHUD];
    
    
//     [self passwordCheck];
    
    
    ble = [[BLEHelper alloc]init];
    ble.mydelegate = self;
    [ble Start];

    
    
    
//     [ble ScanPeripherals];
    
    
    
    
    [self scanAction];
    
    
 
    
    
    
}





-(void)locationWithMsg:(NSNotification *)sender{
    
    NSLog(@"================ %@",sender.userInfo);
   
    
}

-(void)startLocationAction:(NSNotification *)sender{
    [deviceBeanLoaction startLocation];
    
}

-(void)getDeviceBeanLocationSuc:(CLLocationCoordinate2D)cc2d address:(NSString *)address{
    
    
    [addressString setString:address];
    lat=cc2d.latitude;
    lot=cc2d.longitude;
    
    
    
    NSDictionary *div=@{@"address":address,@"latitude":[NSNumber numberWithDouble:cc2d.latitude],@"longitude":[NSNumber numberWithDouble:cc2d.longitude]};
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNOTICE_LOCATION_MSG object:nil userInfo:div];
    
   
    
    
}
/*
-(BOOL) containConnectPeripherals:(CBPeripheral *)p
{
    for (PeripheralModel *_p in self.connectperipherals) {
        if([_p.peripheral.identifier isEqual:p.identifier])
            return NO;
    }
    return YES;
}
 
 */



-(void)GetBLE{
    
    
    
    
    NSLog(@"%@--------",[ble.peripheral description]);
    PeripheralModel *permodel=[[PeripheralModel alloc] init];
    permodel.switchNumber = 0;
    permodel.perName = [ble.peripheral name];
    permodel.UUID = [ble.peripheral identifier].UUIDString;
    permodel.bleName = @"aaaaaaa";
    permodel.peripheral = ble.peripheral;
    permodel.isOnOff = YES;
    permodel.characteristic1 = ble.characteristic1;
    permodel.characteristic2 = ble.characteristic2;
    permodel.characteristic3 = ble.characteristic3;
    
    [arrListConnetction addObject:permodel];
    
    [table reloadData];
//    [self.connectperipherals addObject:permodel];
    
}
-(void) GetPeripheral:(CBPeripheral *)p{
    
    
    DeviceBean *db=[[DeviceBean alloc] init];
    db.tagName=p.name;
    db.UUIDString=[p.identifier UUIDString];
    db.imageName=@"";
    db.warnVoiceLevel=@"0.5";
    db.findVoiceLevel=@"0.5";
    db.warnLight=@"1";
    db.findLight=@"1";
    db.warnVoice=@"alarm_bird";
    db.findVoice=@"alarm_bird";
    db.warnStatus=@"1";
    [DeviceBean saveDeviceBean:db];
    
    
    
    
    
    if ([arrList count]==0) {
        [arrList addObject:p];

    }else{
        for (CBPeripheral *_p in arrList) {
            if (p.identifier != _p.identifier) {
                
                [arrList addObject:p];
                
            }
        }
    }
    
  
    
    
    
    [table reloadData];
    
}
-(void)connetedPeripheral:(CBPeripheral *)p withRSSI:(NSNumber *)RSSI{
    
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:NSUSERDEFAULTS_NOWARN_5] isEqualToString:NSUSERDEFAULTS_NOWARN_5]) {
        return;
    }
    
    
    if ([arrListConnetction count]>0) {
        for (PeripheralModel *pm in arrListConnetction) {
            
            if ([pm.UUID isEqualToString:[p.identifier UUIDString]] ) {
                
                if (abs([RSSI intValue])>60) {
                    lostTimeCount++;
                }else{
                    lostTimeCount=0;
                }
                
                DeviceBean *db=[DeviceBean getDeviceBeanByUUID:[p.identifier UUIDString]];
                
                
                if (lostTimeCount>=3) {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:NSNOTICE_PLAY_WRAN_VOICE object:nil userInfo:@{@"warnVoiceLevel":db.warnVoiceLevel,@"warnVoice":db.warnVoice,@"warnStatus":db.warnStatus}];
                    
                    [self saveLostBeanData:db.UUIDString tagName:db.tagName imageName:db.imageName];
                    
                    [self writeStatusToBlueth:pm status:6];
                    
                }else{
                    [[NSNotificationCenter defaultCenter] postNotificationName:NSNOTICE_STOP_VOICE object:nil];
                    
                    [self writeStatusToBlueth:pm status:1];
                    
                }
                
                
            }
        }
    }
}


-(void)writeStatusToBlueth:(PeripheralModel *)p status:(int)s{
    
    if (!(s==1||s==6)) {
        return;
    }
    
    
    ///丢失 6
    Byte _b1[] ={0x06};
    Byte _b2[] ={0x01};
    
    NSData *d =nil;
    
    if (s==6) {
        d=[[NSData alloc] initWithBytes:_b1 length:sizeof(_b1)];
    }else if(s==1){
        d=[[NSData alloc] initWithBytes:_b2 length:sizeof(_b2)];
    }
    
    
    [p.peripheral writeValue:d forCharacteristic:p.characteristic1 type:CBCharacteristicWriteWithResponse];
}

-(void)saveLostBeanData:(NSString *)UUIDString tagName:(NSString *)tagName imageName:(NSString *)imageName{
    if (lat==0||lot==0) {
        return;
    }
    if (fabs(lot-lotCopy)<0.001&&fabs(lat-latCopy)<0.001) {
         return;
    }
    
    
    if (UUIDString.length&&tagName.length&&imageName.length) {
        return;
    }
    
    LostBean *l1=[[LostBean alloc] init];
    l1.UUIDString=UUIDString;
    l1.tagName=tagName;
    l1.imageName=imageName;
    l1.lostTime=[StaticFunction getCurrentDateTime];
    l1.lostYear=[StaticFunction getCurrentDateYear];
    l1.lostMonth=[StaticFunction getCurrentDateMonth];
    l1.lostDay=[StaticFunction getCurrentDateDay];
    l1.lostLot=[NSString stringWithFormat:@"%f",lot];
    l1.lostLat=[NSString stringWithFormat:@"%f",lat];
    l1.lostAddress=addressString;
    [LostBean saveLostBean:l1];
    
    lotCopy=lot;
    latCopy=lat;
    
    
}
-(void)scanAction{
    
    
    
    
    [arrList removeAllObjects];
    [table reloadData];
    
    [ble ScanPeripherals];
    

    
    
}


-(void)passwordCheck{
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:NSUSERDEFAULTS_HAVE_PASSWORD_3]) {
        
        PassWordViewController *pwvc=[[PassWordViewController alloc] init];
        UINavigationController *na=[[UINavigationController alloc] initWithRootViewController:pwvc];
        [self presentViewController:na animated:YES completion:^{
            
        }];
        
    }
    
}

-(void)reloadListViewAction{
    
    [table reloadData];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [arrList count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DeviceListTableViewCell *cell=(DeviceListTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"DeviceListTableViewCell" owner:self options:nil][0];
 
    
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    
    CBPeripheral *p=arrList[indexPath.row];
    
    
    DeviceBean *db=[DeviceBean getDeviceBeanByUUID:[p.identifier UUIDString]];
    if (db!=nil) {
          cell.iTagLabel.text=db.tagName;
        if (db.imageName.length>0&&[StaticFunction localExistenceThisImage:db.imageName]) {
            UIImage *imageFromDictionary = [UIImage imageWithContentsOfFile:[[StaticFunction imageFilePath] stringByAppendingPathComponent:db.imageName]];
            [cell.iTagImageView setImage:imageFromDictionary];
            
        }
    }
    
    
//     NSLog(@"%@------------  ", p.RSSI);
  
    
    
    if ([self connetCurrentUUID:[p.identifier UUIDString]]) {
        cell.connectedStatusLabel.textColor=UICOLOR_SYSTEM_GREEN_COLOR_1;
    cell.connectedStatusLabel.text=CustomLocalizedString(@"text_string_33", nil);
    }else{
        cell.connectedStatusLabel.textColor=UICOLOR_SYSTEM_GRAY_COLOR_2;
     cell.connectedStatusLabel.text=CustomLocalizedString(@"text_string_34", nil);
    }
    
   
    
    
    NSString *conTxt=nil;
    
    if ([self connetCurrentUUID:[p.identifier UUIDString]]) {
        conTxt=CustomLocalizedString(@"cell_title_38", nil);
    }else{
          conTxt=CustomLocalizedString(@"text_string_32", nil);
    }
  
    
    
    UIImage *im=[UIImage imageNamed:@"connectButton0"];
    
    
    CGFloat w = [conTxt sizeWithFont:[UIFont systemFontOfSize:15] forWidth:2000000 lineBreakMode:NSLineBreakByWordWrapping].width;
    
    
    UIButton *but=[[UIButton alloc] init];
    but.frame=CGRectMake(self.view.frame.size.width-w-20-30-20, 15, w+20, 30);
    [but setBackgroundImage:[im stretchableImageWithLeftCapWidth:20 topCapHeight:11] forState:UIControlStateNormal];
    but.tag=indexPath.row+100;
    [but addTarget:self action:@selector(cellButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:but];
    
    
    UILabel *leltxt=[[UILabel alloc]init];
    leltxt.frame=CGRectMake(10, 5, w, 20);
    leltxt.backgroundColor=[UIColor clearColor];
    leltxt.text=conTxt;
    leltxt.font=[UIFont systemFontOfSize:15];
    [but addSubview:leltxt];
    
    
    
    
    
    
    
    
   
    
    return cell;
    
}

-(void)cellButton:(UIButton *)sender{
    
    CBPeripheral *p=arrList[sender.tag-100];
    
    if ([self connetCurrentUUID:[p.identifier UUIDString]]) {
        [ble disconnect:p];
        
        
        for (PeripheralModel *pm in arrListConnetction) {
            if ([pm.UUID isEqualToString:[p.identifier UUIDString]]) {
                
                [arrListConnetction removeObject:pm];
                break;
            }
        }
        
 
        
    }else{
        [ble connect:p];
        
       
        
        
    }
    
    [table reloadData];
    
    
    
    
}

-(BOOL)connetCurrentUUID:(NSString *)UUIDString{
    
    if ([arrListConnetction count]==0) {
        return NO;
    }
    
    for (PeripheralModel *p in arrListConnetction) {
        if ([p.UUID isEqualToString:UUIDString]) {
            return YES;
        }
    }
    
    return NO;
}



-(void)disconnectBluethAction:(NSString *)UUIDString{
    
    
    
    for (CBPeripheral *p in arrListConnetction) {
        
        if ([[p.identifier UUIDString] isEqualToString:UUIDString]) {
             [ble disconnect:p];
            break;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
//    pccccccc=arrList[indexPath.row];
    
    
    
//    [centralManager connectPeripheral:pccccccc options:nil];
    
  /*
    Byte _b[] ={0x02
        };
    
    NSData *d = [[NSData alloc] initWithBytes:_b length:sizeof(_b)];
    

    
    PeripheralModel *p=arrListConnetction[indexPath.row];

   
    
     [p.peripheral writeValue:d forCharacteristic:p.characteristic1 type:CBCharacteristicWriteWithResponse];
//    [p.peripheral writeValue:d forCharacteristic:p.characteristic2 type:CBCharacteristicWriteWithResponse];
//    [p.peripheral writeValue:d forCharacteristic:p.characteristic3 type:CBCharacteristicWriteWithResponse];
 */
    
    
     CBPeripheral *p=arrList[indexPath.row];
    
    if (![self connetCurrentUUID:[p.identifier UUIDString]]) {
        
        return;
    }
    
    ItagDetailViewController *tdvc=[[ItagDetailViewController alloc] init];
    tdvc.hidesBottomBarWhenPushed = YES;
    tdvc.delegate=self;
    tdvc.UUIDString=[p.identifier UUIDString];
    tdvc.disConnectdelegate=self;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController pushViewController:tdvc animated:YES];
}

-(void)createLeftBar{
    
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clickLeftAction:)];
    left.tintColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = left;
    
    
}
-(void)clickLeftAction:(id)sender{
    
//    [centralManager stopScan];
    
      [self scanAction];
    
    
    
    
}
-(void)createRightBar{
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(clickRightAction:)];
    right.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = right;
}
-(void)clickRightAction:(id)sender{
   /*
    
     [ble ScanPeripherals];
    
        return;
    
    
    Byte _b[] ={0x06
        ,0x11
        ,0x10
        ,0x00
        ,0x64};
    
    NSData *d = [[NSData alloc] initWithBytes:_b length:sizeof(_b)];
    
    */
    
    
//    [pccccccc writeValue:d forCharacteristic:charetisss type:CBCharacteristicWriteWithResponse];
    
    
//  [pccccccc writeValue:d forCharacteristic:pccccccc.CBCharacteristic type:CBCharacteristicWriteWithResponse];
    
    

    
    
    IntroductionViewController *tdvc=[[IntroductionViewController alloc] init];
    tdvc.hidesBottomBarWhenPushed = YES;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController pushViewController:tdvc animated:YES];

   
}




//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:NSNOTICE_CHANGE_TABBAT_TITLE_1 object:nil];
//    
//}
@end
