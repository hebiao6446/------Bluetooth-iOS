//
//  AppDelegate.m
//  FindMyBag
//
//  Created by hebiao on 15-7-15.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import "AppDelegate.h"

#import "ConstantPart.h"

#import "ViewController.h"

#import "StaticFunction.h"



BMKMapManager* _mapManager;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [StaticFunction createImagePath];
    
    
    
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"DD279b2a90afdf0ae7a3796787a0742e" generalDelegate:self];
    
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    
    
    
    application.applicationIconBadgeNumber = 0;
    // Handle launching from a notification
    UILocalNotification *localNotif =
    [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotif) {
        NSLog(@"Recieved Notification %@",localNotif);
    }
    
    
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)])
        
    {
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
        
        
        
        
    }
    
    
    
    NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
    if ([userDef objectForKey:NSUSERDEFAULTS_SYSTEM_MAP_2]==nil) {
        
        [userDef setInteger:MapTypeBaidu forKey:NSUSERDEFAULTS_SYSTEM_MAP_2];
        [userDef synchronize];
    
    }
    
    
    if ([userDef objectForKey:NSUSERDEFAULTS_SYSTEM_LANGUE_1]==nil) {
        
        NSString *currentLang =nil;
        
        if ([[NSLocale preferredLanguages] count]>0) {
            currentLang=[NSLocale preferredLanguages][0];
        }else{
            currentLang=@"en";
        }
        
        [userDef setObject:currentLang forKey:NSUSERDEFAULTS_SYSTEM_LANGUE_1];
        
        
        NSString *fielPath = [[NSBundle mainBundle] pathForResource:@"LanguageSupport" ofType:@"plist"];
        NSArray *langSupports = [NSArray arrayWithContentsOfFile:fielPath];
        
        for (NSDictionary *dic  in langSupports) {
            NSString *spoLan=dic[@"enname"];
            
            if ([spoLan isEqualToString:currentLang]||[currentLang containsString:spoLan]) {
                
                 [userDef setObject:spoLan forKey:NSUSERDEFAULTS_SYSTEM_LANGUE_1];
                break;
            }
            
        }
        
        [userDef synchronize];
        
        
    }
    
    
    if ([userDef objectForKey:NSUSERDEFAULTS_NOWARN_5]==nil) {
        [userDef setObject:NSUSERDEFAULTS_NOWARN_5 forKey:NSUSERDEFAULTS_NOWARN_5];
        [userDef synchronize];
        
    }
    
    
    
    NSError *error;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:&error];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playWarn:) name:NSNOTICE_PLAY_WRAN_VOICE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFind:) name:NSNOTICE_PLAY_FIND_VOICE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopPlay) name:NSNOTICE_STOP_VOICE object:nil];
    
    
    /*
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"alarm" ofType:@"mp3"];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:musicPath];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [player prepareToPlay];
    [player setVolume:1];
    player.numberOfLoops = -1;
    */
    
    
     self.viewController=[[ViewController alloc] init];
    
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    self.window.rootViewController= self.viewController;
    return YES;
    
 
}



-(void)postLocationNotice{
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    
    
    // Notification details
    localNotif.alertBody = CustomLocalizedString(@"cell_title_39", nil);
    // Set the action button
    localNotif.alertAction = CustomLocalizedString(@"actionsheet_txt_44", nil);
    
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.applicationIconBadgeNumber = 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}


-(void)playWarn:(NSNotification *)sender{
    
    NSLog(@"-----------%@",sender.userInfo);
    
    NSDictionary *d=sender.userInfo;
    
    if ([@"1" isEqualToString:d[@"warnStatus"]] ) {
         [self playSoud:d[@"warnVoice"] voiceNameLevel:[d[@"warnVoiceLevel"] floatValue]];
        
        [self postLocationNotice];
        
    }
    
   
}
-(void)playFind:(id)sender{
    
}
-(void)stopPlay{
    
    if(player!=nil){
        [player stop];
        player=nil;
    }
    
}


-(void)playSoud:(NSString *)nameString voiceNameLevel:(float)l{
    
    if ([player isPlaying]) {
        return;
    }
    
    
    if (player) {
        [player stop];
        player=nil;
    }
    
    
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:nameString ofType:@"mp3"];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:musicPath];
     player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [player  prepareToPlay];
    [player  setVolume:l];
    player.numberOfLoops=-1;
    [player play];
    
    
    
    
    
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
     [BMKMapView willBackGround];
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents]; // 让后台可以处理多媒体的事件
    }

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    
    if ([[NSUserDefaults standardUserDefaults ] boolForKey:NSUSERDEFAULTS_HAVE_PASSWORD_3]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNOTICE_SHOW_PASSWORD_VIEW object:nil];
        
    }
    [application beginBackgroundTaskWithExpirationHandler:nil];
    
//    [self playMusicWithName:@""];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [BMKMapView didForeGround];
    
     application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

-(void)playMusicWithName:(NSString *)name{
    
    [player play];
}

@end
