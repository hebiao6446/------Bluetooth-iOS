//
//  LocationViewController.m
//  FindMyBag
//
//  Created by hebiao on 15/7/15.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import "LocationViewController.h"
#import "HeadFile.h"
#import "LostHistoryViewController.h"
#import "LocationListViewController.h"

@interface LocationViewController()

@end

@implementation LocationViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)changeLanguagueAction:(id)sender{
    self.nagationLabel.text=CustomLocalizedString(@"nagation_title_7", nil);
}
-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    self.nagationLabel.text=CustomLocalizedString(@"nagation_title_7", nil);
    isNeedLocation=NO;
    
    lostBeanDic=[[NSMutableDictionary alloc] init];
    baiduMapManager=[[BaiduMapManager alloc] init];
    baiduMapManager.delegate=self;
    
    
    
    [self createAppleMapView];
    [self createBaiduMapView];
    
   
    [self allocBaiduLocation];
    
    
    [self createLeftBar];
    [self createRightBar];
    
    
    
    
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationWithMsg:) name:NSNOTICE_LOCATION_MSG object:nil];
}
-(void)locationWithMsg:(NSNotification *)sender{
    
//    NSLog(@"================ %@",sender.userInfo);
    
//     NSDictionary *div=@{@"address":address,@"latitude":[NSNumber numberWithDouble:cc2d.latitude],@"longitude":[NSNumber numberWithDouble:cc2d.longitude]};
    
    
    if (isFromDelegate) {
        return;
    }
    
    
    
    if (!isNeedLocation) {
        
        return;
    }
    
    NSDictionary *div=sender.userInfo;
    
    
    CLLocationDegrees lat=[div[@"latitude"] doubleValue];
    CLLocationDegrees lot=[div[@"latitude"] doubleValue];
    
    CLLocation  *currLocation=[[CLLocation alloc] initWithLatitude:lat longitude:lot];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(currLocation.coordinate,2000, 2000);
    MKCoordinateRegion adjustedRegion = [appleMapView regionThatFits:viewRegion];
    [appleMapView setRegion:adjustedRegion animated:YES];
    
    isNeedLocation=NO;
    
}


-(void)createAppleMapView{
    appleMapView=[[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44-49)];
    appleMapView.userTrackingMode=MKUserTrackingModeFollow;
    appleMapView.mapType=MKMapTypeStandard;
    appleMapView.showsUserLocation=YES;
    [self.view addSubview:appleMapView];
    appleMapView.hidden=[[NSUserDefaults standardUserDefaults] integerForKey:NSUSERDEFAULTS_SYSTEM_MAP_2]==MapTypeBaidu;
    
}
-(void)createBaiduMapView{
    
    baiduMapView=[[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44-49)];
    baiduMapView.userTrackingMode=BMKUserTrackingModeFollow;
    baiduMapView.mapType=BMKMapTypeStandard;
    baiduMapView.showsUserLocation=YES;
    [self.view addSubview:baiduMapView];
    baiduMapView.hidden=[[NSUserDefaults standardUserDefaults] integerForKey:NSUSERDEFAULTS_SYSTEM_MAP_2]==MapTypeApple;
    
    
}

-(void)createLeftBar{
    
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(clickLeftAction:)];
    left.tintColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = left;
    
    
}
-(void)clickLeftAction:(id)sender{
    
    
    LostHistoryViewController *lhvc=[[LostHistoryViewController alloc] init];
    lhvc.delegate=self;
    lhvc.hidesBottomBarWhenPushed = YES;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController pushViewController:lhvc animated:YES];
    
}
-(void)createRightBar{
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(clickRightAction:)];
    right.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = right;
}
-(void)clickRightAction:(id)sender{
    LocationListViewController *llvc=[[LocationListViewController alloc] init];
    llvc.hidesBottomBarWhenPushed = YES;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController pushViewController:llvc animated:YES];
}

-(void)lostHistoryDidLocation:(NSDictionary *)lostBean{
    
    
//    NSLog(@"++++++++++++++++++++++++++++++++++++");
    
    
    isFromDelegate=YES;
    
    [lostBeanDic setDictionary:lostBean];
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    NSLog(@"+++++++++++viewDidAppear+++++++");
    MapType t= [[NSUserDefaults standardUserDefaults] integerForKey:NSUSERDEFAULTS_SYSTEM_MAP_2];
    
    
    if (t==MapTypeApple) {
        
        isNeedLocation=YES;
        
        if (isFromDelegate) {
            [self addApplePoint];
        }else{
             [[NSNotificationCenter defaultCenter]postNotificationName:NSNOTICE_LOCATION_START_ACTION object:nil];
        }
        
       
        
      
        
        appleMapView.hidden=NO;
        baiduMapView.hidden=YES;
        
    }
    
    if (t==MapTypeBaidu) {
        
        baiduMapGetLocationFlag=NO;
        baiduMapView.delegate=baiduMapManager;
        baiduLocService.delegate=baiduMapManager;
        
        if (isFromDelegate) {
            [self addBaiduPoint];
            
        }else{
           [baiduLocService startUserLocationService];
        }
        
        
        appleMapView.hidden=YES;
        baiduMapView.hidden=NO;
        
    }
    
    
    
   
    
    
    
        
   
}


-(void)addBaiduPoint{
    BMKPointAnnotation *pointAnnotation= [[BMKPointAnnotation alloc]init];
    CLLocationDegrees lat=[lostBeanDic[@"lostLat"] doubleValue];
    CLLocationDegrees lot=[lostBeanDic[@"lostLot"] doubleValue];
    
    
    CLLocationCoordinate2D cc2d=CLLocationCoordinate2DMake(lat, lot);
    
    pointAnnotation.coordinate = cc2d;
    pointAnnotation.title=lostBeanDic[@"tagName"];
    pointAnnotation.subtitle=lostBeanDic[@"lostAddress"];
    [baiduMapView addAnnotation:pointAnnotation];
    
    
    
    BMKCoordinateRegion viewRegion=BMKCoordinateRegionMake(cc2d, BMKCoordinateSpanMake(0.015, 0.015));
    BMKCoordinateRegion adjustedRegion=[baiduMapView regionThatFits:viewRegion];
    [baiduMapView setRegion:adjustedRegion animated:YES];
    
    

}




-(BMKAnnotationView *)baiduMapView:(BMKMapView *)View viewForAnnotation:(id<BMKAnnotation>)annotation{
    NSString *AnnotationViewID = @"xidanMark";
    
    // 检查是否有重用的缓存
    BMKAnnotationView *annotationView = [View dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        //((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
        ((BMKPinAnnotationView*)annotationView).image = [UIImage imageNamed:@"location_cell2"];
        // 设置重天上掉下的效果(annotation)
        ((BMKPinAnnotationView*)annotationView).animatesDrop = NO;
    }
    
    // 设置位置
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
    annotationView.canShowCallout = YES;
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    
    return annotationView;
    
    
}

-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *pinView = nil;
    
    static NSString *defaultPinID = @"com.invasivecode.pin";
    pinView = (MKPinAnnotationView *)[appleMapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    if ( pinView == nil ) {
        pinView =[[MKPinAnnotationView alloc]
                  initWithAnnotation:annotation reuseIdentifier:defaultPinID];
    }
    pinView.pinColor = MKPinAnnotationColorRed;
    pinView.canShowCallout = YES;
    pinView.animatesDrop = YES;
    return pinView;
}







-(void)addApplePoint{
    
    
    CLLocationDegrees lat=[lostBeanDic[@"lostLat"] doubleValue];
    CLLocationDegrees lot=[lostBeanDic[@"lostLot"] doubleValue];
    
    
    CLLocationCoordinate2D cc2d=CLLocationCoordinate2DMake(lat, lot);
    MKPointAnnotation *ann = [[MKPointAnnotation alloc] init];
    ann.coordinate = cc2d;
    [ann setTitle:lostBeanDic[@"tagName"]];
    [ann setSubtitle:lostBeanDic[@"lostAddress"]];
    [appleMapView addAnnotation:ann];
    
    
    
    CLLocation  *currLocation=[[CLLocation alloc] initWithLatitude:lat longitude:lot];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(currLocation.coordinate,2000, 2000);
    MKCoordinateRegion adjustedRegion = [appleMapView regionThatFits:viewRegion];
    [appleMapView setRegion:adjustedRegion animated:YES];
    
    
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    
    
    isFromDelegate=NO;
    
    
    
    MapType t= [[NSUserDefaults standardUserDefaults] integerForKey:NSUSERDEFAULTS_SYSTEM_MAP_2];
    
    
    if (t==MapTypeApple) {
        
        if ([appleMapView.annotations count]>0) {
            [appleMapView removeAnnotations:appleMapView.annotations];
        }
        
        
        isNeedLocation=NO;
        appleMapView.delegate=nil;
        
    }
    
    if (t==MapTypeBaidu) {
        
        
        if ([baiduMapView.annotations count]>0) {
            [baiduMapView removeAnnotations:baiduMapView.annotations];
        }
        
          baiduMapGetLocationFlag=NO;
        [baiduLocService stopUserLocationService];
        baiduMapView.delegate=nil;
        baiduLocService.delegate=nil;
        
    }

    
    
}


-(void)allocBaiduLocation{
    baiduLocService=[[BMKLocationService alloc] init];
    
}



/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
//    [baiduMapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    if (isFromDelegate) {
        return;
    }
    
    if (  !baiduMapGetLocationFlag) {
        baiduMapGetLocationFlag=YES;
        
        [baiduMapView updateLocationData:userLocation];
        
        
        BMKCoordinateRegion viewRegion=BMKCoordinateRegionMake(userLocation.location.coordinate, BMKCoordinateSpanMake(0.015, 0.015));
        BMKCoordinateRegion adjustedRegion=[baiduMapView regionThatFits:viewRegion];
        [baiduMapView setRegion:adjustedRegion animated:YES];
    }
  
    
    
   
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}






@end
