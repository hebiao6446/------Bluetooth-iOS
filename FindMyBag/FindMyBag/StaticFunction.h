//
//  StaticFunction.h
//  FindMyBag
//
//  Created by hebiao on 15-7-16.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StaticFunction : NSObject

+(NSString *)dataFilePath;
+(NSString *)imageFilePath;
+(BOOL)localExistenceThisImage:(NSString*)imageName;
+(void)createImagePath;
+(double)getImageFileMB;
+(void)deleteImagePath;

+(NSString *)getCurrentDateTime;
+(NSString *)getCurrentDateYear;
+(NSString *)getCurrentDateMonth;
+(NSString *)getCurrentDateDay;

@end
