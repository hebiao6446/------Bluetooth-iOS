//
//  LocationBean.m
//  FindMyBag
//
//  Created by hebiao on 15/8/28.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import "LocationBean.h"

#import "FMDB.h"
#import "HeadFile.h"


#define DATABASE_PATH  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"/findmybag3.db"]


#define CREATE_LocationBean_SQL  @"CREATE  TABLE  IF NOT EXISTS 'LocationBean' ('_id' INTEGER PRIMARY KEY AUTOINCREMENT,'UUIDString' TEXT, 'tagName' TEXT, 'imageName' TEXT, 'lostTime' TEXT,  INTEGER,'lostLot' TEXT,'lostLat' TEXT,'lostAddress' TEXT)"

@implementation LocationBean
@synthesize UUIDString,tagName,imageName,lostTime,lostLot,lostLat,lostAddress,_id;

-(NSDictionary *)toDictionary{
    
    return @{@"UUIDString":UUIDString,@"tagName":tagName,@"imageName":imageName,@"lostTime":lostTime,@"lostLot":lostLot,@"lostLat":lostLat,@"lostAddress":lostAddress,@"_id":_id};
}

+(BOOL)saveLostBean:(LocationBean *)lostBean{
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    
    BOOL worked = [db executeUpdate:CREATE_LocationBean_SQL];
    FMDBQuickCheck(worked);
    
    NSString *insertStr=@"INSERT INTO 'LocationBean' ('UUIDString','tagName','imageName','lostTime','lostYear','lostMonth','lostDay','lostLot','lostLat','lostAddress') VALUES (?,?,?,?,?,?,?,?,?,?)";
    
    
    
    worked = [db executeUpdate:insertStr,lostBean.UUIDString,lostBean.tagName,lostBean.imageName,lostBean.lostTime,lostBean.lostLot,lostBean.lostLat,lostBean.lostAddress];
    
    FMDBQuickCheck(worked);
    
    
    [db close];
    
    
    return worked;
    
}
+(BOOL)deleteLostBean:(NSString *)_id{
    
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    
    [self check:db];
    NSString *str=@"DELETE  FROM LocationBean WHERE _id=?";
    
    
    
    BOOL worked = [db executeUpdate:str,_id];
    FMDBQuickCheck(worked);
    
    [db close];
    
    return worked;
}
+(NSMutableArray *)getAllLocationBean{
    
    NSMutableArray *resultArr=[[NSMutableArray alloc]init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return resultArr;
    };
    
    [self check:db];
    
    FMResultSet *rset=[db executeQuery:@"SELECT * FROM LocationBean "];
    
    
    while ([rset next]) {
        
        
        LocationBean *lostBean=[[LocationBean alloc] init];
        lostBean.UUIDString=[rset stringForColumn:@"UUIDString"];
        lostBean.tagName=[rset stringForColumn:@"tagName"];
        lostBean.imageName=[rset stringForColumn:@"imageName"];
        lostBean.lostTime=[rset stringForColumn:@"lostTime"];
        lostBean.lostLot=[rset stringForColumn:@"lostLot"];
        lostBean.lostLat=[rset stringForColumn:@"lostLat"];
        lostBean.lostAddress=[rset stringForColumn:@"lostAddress"];
        lostBean._id=[rset stringForColumn:@"_id"];
        
        
        [resultArr addObject:[lostBean toDictionary]];
        
    }
    
    
    
    
 
    
    
    [rset close];
    [db close];
    
    
    
    
    return resultArr;
    
}
+(BOOL)check:(FMDatabase *)db{
    
    
    
    BOOL worked = [db executeUpdate:CREATE_LocationBean_SQL];
    FMDBQuickCheck(worked);
    
    
    return worked;
}


@end
