//
//  DeviceBean.m
//  FindMyBag
//
//  Created by hebiao on 15/8/18.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import "DeviceBean.h"
#import "FMDB.h"
#import "HeadFile.h"

#define DATABASE_PATH  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"/findmybag1.db"]




#define CREATE_DeviceBean_SQL  @"CREATE  TABLE  IF NOT EXISTS 'DeviceBean' ('UUIDString' TEXT PRIMARY KEY  NOT NULL  UNIQUE , 'tagName' TEXT, 'imageName' TEXT, 'warnVoiceLevel' TEXT, 'findVoiceLevel' TEXT,'warnLight' TEXT,'findLight' TEXT,'warnVoice' TEXT,'findVoice' TEXT,'warnStatus' TEXT)"


@implementation DeviceBean
@synthesize UUIDString,tagName,imageName,warnVoiceLevel,findVoiceLevel,warnLight,findLight,warnVoice,findVoice,warnStatus;





+(DeviceBean *)allocWithDictionary:(NSDictionary *)d{
    
    DeviceBean *db=[[DeviceBean alloc] init];
    db.UUIDString=d[@"UUIDString"];
    db.tagName=d[@"tagName"];
    db.imageName=@"";
    db.warnVoiceLevel=@"0.5";
    db.findVoiceLevel=@"0.5";
    db.warnLight=@"0";
    db.findLight=@"0";
    db.warnVoice=@"alarm_bird";
    db.findVoice=@"alarm_bird";
    db.warnStatus=@"0";
    return db;
    
}

-(NSDictionary *)toDictionary{
    
    return @{@"UUIDString":UUIDString,@"tagName":tagName,@"imageName":imageName,@"warnVoiceLevel":warnVoiceLevel,@"findVoiceLevel":findVoiceLevel,@"warnLight":warnLight,@"findLight":findLight,@"warnVoice":warnVoice,@"findVoice":findVoice,@"warnStatus":warnStatus};
    
}


+(DeviceBean *)getDeviceBeanByUUID:(NSString *)UUIDString{
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return [self getNullDeviceBean:UUIDString];
    };
    
    
     [self check:db];
    
    
    NSString *strSql=@"select * from DeviceBean where  UUIDString=?";
    
    
    
    
    
    FMResultSet *rs=rs=[db executeQuery:strSql,UUIDString];
    
    while ([rs next]) {
        DeviceBean *db=[[DeviceBean alloc]init];
        db.UUIDString=[rs stringForColumn:@"UUIDString"];
        db.tagName=[rs stringForColumn:@"tagName"];
        db.imageName=[rs stringForColumn:@"imageName"];
        db.warnVoiceLevel=[rs stringForColumn:@"warnVoiceLevel"];
        db.findVoiceLevel=[rs stringForColumn:@"findVoiceLevel"];
        db.warnLight=[rs stringForColumn:@"warnLight"];
        db.findLight=[rs stringForColumn:@"findLight"];
        db.warnVoice=[rs stringForColumn:@"warnVoice"];
        db.findVoice=[rs stringForColumn:@"findVoice"];
        db.warnStatus=[rs stringForColumn:@"warnStatus"];
        
        return db;
        
    }
    [rs close];
    [db close];
    
    
    
    
    return [self getNullDeviceBean:UUIDString];
    
}

+(BOOL)saveDeviceBean:(DeviceBean *)deviceBean{
    
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    
    BOOL worked = [db executeUpdate:CREATE_DeviceBean_SQL];
    FMDBQuickCheck(worked);
    
    
    
    


    
    NSString *insertStr=@"INSERT INTO 'DeviceBean' ('UUIDString','tagName','imageName','warnVoiceLevel','findVoiceLevel','warnLight','findLight','warnVoice','findVoice','warnStatus') VALUES (?,?,?,?,?,?,?,?,?,?)";
    
    worked = [db executeUpdate:insertStr,deviceBean.UUIDString,deviceBean.tagName,deviceBean.imageName,deviceBean.warnVoiceLevel,deviceBean.findVoiceLevel,deviceBean.warnLight,deviceBean.findLight,deviceBean.warnVoice,deviceBean.findVoice,deviceBean.warnStatus];
    
//    FMDBQuickCheck(worked);
    
    
    [db close];
    
    
    return worked;
    
 
}


+(DeviceBean *)getNullDeviceBean:(NSString *)UUIDString{
    
    DeviceBean *db=[[DeviceBean alloc] init];
    db.UUIDString=UUIDString;
    db.tagName=@"iTag";
    db.imageName=@"";
    db.warnVoiceLevel=@"0.5";
    db.findVoiceLevel=@"0.5";
    db.warnLight=@"0";
    db.findLight=@"0";
    db.warnVoice=@"alarm_bird";
    db.findVoice=@"alarm_bird";
    db.warnStatus=@"0";
    return db;
    
}
+(BOOL)updateTagName:(NSString *)tagName uuid:(NSString *)UUIDString{
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    
    [self check:db];
    NSString *str=@"UPDATE DeviceBean  SET tagName=? where UUIDString=?";
    
    
    
    BOOL worked = [db executeUpdate:str,tagName,UUIDString];
    FMDBQuickCheck(worked);
    
    [db close];
    
    return worked;
    
}

+(BOOL)updateImageName:(NSString *)imageName uuid:(NSString *)UUIDString{
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    
    [self check:db];
    NSString *str=@"UPDATE DeviceBean  SET imageName=? where UUIDString=?";
    
    
    
    BOOL worked = [db executeUpdate:str,imageName,UUIDString];
    FMDBQuickCheck(worked);
    
    [db close];
    
    return worked;

    
}
+(BOOL)updateWarnStatus:(NSString *)warnStatus uuid:(NSString *)UUIDString{
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    
    [self check:db];
    NSString *str=@"UPDATE DeviceBean  SET warnStatus=? where UUIDString=?";
    
    
    
    BOOL worked = [db executeUpdate:str,warnStatus,UUIDString];
    FMDBQuickCheck(worked);
    
    [db close];
    
    return worked;
    
    
}
+(BOOL)updateWarnVoiceLevel:(NSString *)warnVoiceLevel uuid:(NSString *)UUIDString{
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    
    [self check:db];
    NSString *str=@"UPDATE DeviceBean  SET warnVoiceLevel=? where UUIDString=?";
    
    
    
    BOOL worked = [db executeUpdate:str,warnVoiceLevel,UUIDString];
    FMDBQuickCheck(worked);
    
    [db close];
    
    return worked;
    
}
+(BOOL)updateFindVoiceLevel:(NSString *)findVoiceLevel uuid:(NSString *)UUIDString{
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    
    [self check:db];
    NSString *str=@"UPDATE DeviceBean  SET findVoiceLevel=? where UUIDString=?";
    
    
    
    BOOL worked = [db executeUpdate:str,findVoiceLevel,UUIDString];
    FMDBQuickCheck(worked);
    
    [db close];
    
    return worked;
}


+(BOOL)updateWarnLight:(NSString *)warnLight uuid:(NSString *)UUIDString{
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    
    [self check:db];
    NSString *str=@"UPDATE DeviceBean  SET warnLight=? where UUIDString=?";
    
    
    
    BOOL worked = [db executeUpdate:str,warnLight,UUIDString];
    FMDBQuickCheck(worked);
    
    [db close];
    
    return worked;
}
+(BOOL)updateFindLight:(NSString *)findLight uuid:(NSString *)UUIDString{
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    
    [self check:db];
    NSString *str=@"UPDATE DeviceBean  SET findLight=? where UUIDString=?";
    
    
    
    BOOL worked = [db executeUpdate:str,findLight,UUIDString];
    FMDBQuickCheck(worked);
    
    [db close];
    
    return worked;
}


+(BOOL)updateWarnVoice:(NSString *)warnVoice uuid:(NSString *)UUIDString{
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    
    [self check:db];
    NSString *str=@"UPDATE DeviceBean  SET warnVoice=? where UUIDString=?";
    
    
    
    BOOL worked = [db executeUpdate:str,warnVoice,UUIDString];
    FMDBQuickCheck(worked);
    
    [db close];
    
    return worked;
}
+(BOOL)updateFindVoice:(NSString *)findVoice uuid:(NSString *)UUIDString{
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    
    [self check:db];
    NSString *str=@"UPDATE DeviceBean  SET findVoice=? where UUIDString=?";
    
    
    
    BOOL worked = [db executeUpdate:str,findVoice,UUIDString];
    FMDBQuickCheck(worked);
    
    [db close];
    
    return worked;
}



+(BOOL)check:(FMDatabase *)db{
    
    
    
    BOOL worked = [db executeUpdate:CREATE_DeviceBean_SQL];
    FMDBQuickCheck(worked);
    
    
    return worked;
}
@end
