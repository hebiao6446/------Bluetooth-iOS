//
//  ConstantPart.h
//  FindMyBag
//
//  Created by hebiao on 15-7-16.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

//定义颜色
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define HEX(_0xhex)  [UIColor colorWithRed:((float)((_0xhex &0xFF0000) >> 16))/255.0 green:((float)((_0xhex & 0xFF00) >> 8))/255.0 blue:((float)(_0xhex & 0xFF))/255.0 alpha:1]

#define HEXA(_0xhex,a)  [UIColor colorWithRed:((float)((_0xhex &0xFF0000) >> 16))/255.0 green:((float)((_0xhex & 0xFF00) >> 8))/255.0 blue:((float)(_0xhex & 0xFF))/255.0 alpha:a]




typedef NS_ENUM(NSInteger, MapType) {
    MapTypeBaidu=1,
    MapTypeApple=2
};


typedef NS_ENUM(NSInteger, PasswordOperationType) {
    PasswordOperationTypeOpen=1,
    PasswordOperationTypeClose=2,
    PasswordOperationTypeChange=3
};


#define CustomLocalizedString(key, comment) \
[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"nsuserdefault_system_langue_1"]] ofType:@"lproj"]] localizedStringForKey:(key) value:@"" table:nil]






//FMDB
#define FMDBQuickCheck(SomeBool) { if (!(SomeBool)) { NSLog(@"Failure on line %d", __LINE__); abort(); } }






/// 保存系统语言
#define NSUSERDEFAULTS_SYSTEM_LANGUE_1 @"nsuserdefault_system_langue_1"

/// 保存系统 地图
#define NSUSERDEFAULTS_SYSTEM_MAP_2 @"nsuserdefault_system_map_2"

//// 保存是否有密码密码
#define NSUSERDEFAULTS_HAVE_PASSWORD_3 @"nsuserdefaults_have_pssword_3"

//// 保存密码
#define NSUSERDEFAULTS_PASSWORD_4 @"nsuserdefaults_pssword_4"



//// 是否开启勿扰
#define NSUSERDEFAULTS_NOWARN_5 @"nsuserdefaults_nowarn_5"
#define NSUSERDEFAULTS_NOWARN @"nsuserdefaults_nowarn"


/// 定义通知
#define NSNOTICE_CHANGE_TABBAT_TITLE_1 @"notice_change_tabbar_title_1"
#define NSNOTICE_CHANGE_SYSTEM_LANGUAGE @"nsnotice_change_system_language"
#define NSNOTICE_SHOW_PASSWORD_VIEW @"nsnotice_show_password_view"



#define NSNOTICE_PLAY_WRAN_VOICE @"nsnotice_play_warn_voice"
#define NSNOTICE_PLAY_FIND_VOICE @"nsnotice_play_find_voice"
#define NSNOTICE_STOP_VOICE @"nsnotice_stop_voice"


#define NSNOTICE_LOCATION_MSG @"nsnotice_location_msg"
#define NSNOTICE_LOCATION_START_ACTION @"notice_location_start_action"








///tabbar 字体大小
#define UIFON_SIZE_TABBER_TITLE_1 12

//导航条字号大小
#define UIFON_SIZE_NAGATION_TITLE_2 21

/// 定义系统色， 绿色 和灰色
#define UICOLOR_SYSTEM_GREEN_COLOR_1 RGB(42,152,62)
#define UICOLOR_SYSTEM_GRAY_COLOR_2 RGB(64,64,64)




