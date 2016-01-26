//
//  DeviceBean.h
//  FindMyBag
//
//  Created by hebiao on 15/8/18.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceBean : NSObject

@property (nonatomic,retain) NSString *UUIDString;
@property (nonatomic,retain) NSString *tagName;


//// 图片名称  default @""
@property (nonatomic,retain) NSString *imageName;

//// 声音级别  default 0.5
@property (nonatomic,retain) NSString *warnVoiceLevel;
@property (nonatomic,retain) NSString *findVoiceLevel;


//// 设备灯光   default 1
@property (nonatomic,retain) NSString *warnLight;
@property (nonatomic,retain) NSString *findLight;


//// 声音  default alarm_bird
@property (nonatomic,retain) NSString *warnVoice;
@property (nonatomic,retain) NSString *findVoice;

//// 防丢 default 1
@property (nonatomic,retain) NSString *warnStatus;


+(DeviceBean *)allocWithDictionary:(NSDictionary *)d;
-(NSDictionary *)toDictionary;


+(DeviceBean *)getDeviceBeanByUUID:(NSString *)UUIDString;

+(BOOL)saveDeviceBean:(DeviceBean *)deviceBean;

+(BOOL)updateTagName:(NSString *)tagName uuid:(NSString *)UUIDString;
+(BOOL)updateImageName:(NSString *)imageName uuid:(NSString *)UUIDString;




+(BOOL)updateWarnStatus:(NSString *)warnStatus uuid:(NSString *)UUIDString;


+(BOOL)updateWarnVoiceLevel:(NSString *)warnVoiceLevel uuid:(NSString *)UUIDString;
+(BOOL)updateFindVoiceLevel:(NSString *)findVoiceLevel uuid:(NSString *)UUIDString;


+(BOOL)updateWarnLight:(NSString *)warnLight uuid:(NSString *)UUIDString;
+(BOOL)updateFindLight:(NSString *)findLight uuid:(NSString *)UUIDString;


+(BOOL)updateWarnVoice:(NSString *)warnVoice uuid:(NSString *)UUIDString;
+(BOOL)updateFindVoice:(NSString *)findVoice uuid:(NSString *)UUIDString;

@end
