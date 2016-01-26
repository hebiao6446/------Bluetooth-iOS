//
//  StaticFunction.m
//  FindMyBag
//
//  Created by hebiao on 15-7-16.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import "StaticFunction.h"


#define FILE_MAIN_PATH @"itraing_main_path"
#define IMAGE_PATH @"image_path"

@implementation StaticFunction


+(NSString *)dataFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    // 	NSString *libraryDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:FILE_MAIN_PATH];
    return [paths objectAtIndex:0];
}

+(NSString *)imageFilePath{
    return [[self dataFilePath] stringByAppendingPathComponent:IMAGE_PATH];
}

+(BOOL)localExistenceThisImage:(NSString*)imageName{
    NSString *path = [[self imageFilePath] stringByAppendingPathComponent:imageName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path])return YES;
    return NO;
}
+(void)createImagePath{
    if(![[NSFileManager defaultManager] fileExistsAtPath:[self imageFilePath]]){
        [[NSFileManager defaultManager] createDirectoryAtPath:[self imageFilePath] withIntermediateDirectories:YES attributes:nil error:nil];
    }
}
+(double)getImageFileMB{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSArray *fileList =[fileManager contentsOfDirectoryAtPath:[self imageFilePath] error:nil];
    
    long fileSize=0;
    
    
    for (NSString *fileName in fileList) {
        NSString *path = [[self imageFilePath] stringByAppendingPathComponent:fileName];
        
        NSError *error=nil;//局部变量必须赋值，并不是默认的nil
        NSDictionary * fileAttributes = [fileManager attributesOfItemAtPath:path error:&error];
        if (fileAttributes == nil || error!=nil){
            
        }else{
            NSNumber *fileSizeNum = [fileAttributes objectForKey:NSFileSize];
            fileSize += [fileSizeNum longValue];
        }
        
        
    }
    
    
    
    
    
    return fileSize/1024.0;
}
+(void)deleteImagePath{
    //    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self imageFilePath] error:NULL];
    //    if ([files count] == 0) {
    //        NSLog(@"Not file in  photos directory");
    //        return;
    //    }
    //    for (int i=0; i<[files count]; i++) {
    //        NSString *filePath = [[self imageFilePath] stringByAppendingPathComponent:[files objectAtIndex:i]];
    //        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    //    }
    
    [[NSFileManager defaultManager] removeItemAtPath:[self imageFilePath]error:nil];
    
    [self createImagePath];
    
    
}


+(NSString *)getCurrentDateTime{
    
    
    
    return [self formatDateToString:@"yyyy-MM-dd HH:mm:ss"];
    
    
}
+(NSString *)getCurrentDateYear{
    
    
    
   return [self formatDateToString:@"yyyy"];
    
}
+(NSString *)getCurrentDateMonth{
    
    
    
    return [self formatDateToString:@"MM"];
    
}
+(NSString *)getCurrentDateDay{
    
    
    
    return [self formatDateToString:@"dd"];
    
}
+(NSString *)formatDateToString:(NSString *)formatStr{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatStr];
    NSString *destDateString = [dateFormatter stringFromDate:[NSDate date]];
    
    return destDateString;
}
@end
