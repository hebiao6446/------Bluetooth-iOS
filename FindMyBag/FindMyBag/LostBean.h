//
//  LostBean.h
//  FindMyBag
//
//  Created by hebiao on 15-8-27.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LostBean : NSObject

@property (nonatomic,retain) NSString *UUIDString;
@property (nonatomic,retain) NSString *tagName;


//// 图片名称  default @""
@property (nonatomic,retain) NSString *imageName;

@property (nonatomic,retain) NSString *lostTime;

@property (nonatomic,retain) NSString *lostYear;
@property (nonatomic,retain) NSString *lostMonth;
@property (nonatomic,retain) NSString *lostDay;

@property (nonatomic,retain) NSString *lostLot;
@property (nonatomic,retain) NSString *lostLat;

@property (nonatomic,retain) NSString *lostAddress;
@property (nonatomic,retain) NSString *_id;

-(NSDictionary *)toDictionary;

+(BOOL)saveLostBean:(LostBean *)lostBean;
+(BOOL)updateLostBeanTagName:(NSString *)tagName with:(NSString *)UUIDString;
+(BOOL)updateLostBeanImageName:(NSString *)imageName with:(NSString *)UUIDString;
+(BOOL)deleteLostBean:(NSString *)_id;
+(BOOL)deleteLostBean:(NSString *)year month:(NSString *)month;
+(NSMutableArray *)getAllLostBean;


@end
