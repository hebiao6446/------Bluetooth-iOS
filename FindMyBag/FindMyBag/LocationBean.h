//
//  LocationBean.h
//  FindMyBag
//
//  Created by hebiao on 15/8/28.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationBean : NSObject


@property (nonatomic,retain) NSString *UUIDString;
@property (nonatomic,retain) NSString *tagName;


//// 图片名称  default @""
@property (nonatomic,retain) NSString *imageName;

@property (nonatomic,retain) NSString *lostTime;


@property (nonatomic,retain) NSString *lostLot;
@property (nonatomic,retain) NSString *lostLat;

@property (nonatomic,retain) NSString *lostAddress;
@property (nonatomic,retain) NSString *_id;


-(NSDictionary *)toDictionary;

+(BOOL)saveLostBean:(LocationBean *)lostBean;
+(BOOL)deleteLostBean:(NSString *)_id;
+(NSMutableArray *)getAllLocationBean;

@end
