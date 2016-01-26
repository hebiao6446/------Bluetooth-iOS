//
//  LostBean.m
//  FindMyBag
//
//  Created by hebiao on 15-8-27.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import "LostBean.h"
#import "FMDB.h"
#import "HeadFile.h"

#define DATABASE_PATH  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"/findmybag2.db"]


#define CREATE_LostBean_SQL  @"CREATE  TABLE  IF NOT EXISTS 'LostBean' ('_id' INTEGER PRIMARY KEY AUTOINCREMENT,'UUIDString' TEXT, 'tagName' TEXT, 'imageName' TEXT, 'lostTime' TEXT, 'lostYear' INTEGER,'lostMonth' INTEGER,'lostDay' INTEGER,'lostLot' TEXT,'lostLat' TEXT,'lostAddress' TEXT)"

@implementation LostBean

@synthesize UUIDString,tagName,imageName,lostTime,lostYear,lostMonth,lostDay,lostLot,lostLat,lostAddress,_id;

-(NSDictionary *)toDictionary{
    
      return @{@"UUIDString":UUIDString,@"tagName":tagName,@"imageName":imageName,@"lostTime":lostTime,@"lostYear":lostYear,@"lostMonth":lostMonth,@"lostDay":lostDay,@"lostLot":lostLot,@"lostLat":lostLat,@"lostAddress":lostAddress,@"_id":_id};
}

+(BOOL)saveLostBean:(LostBean *)lostBean{
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    
    BOOL worked = [db executeUpdate:CREATE_LostBean_SQL];
//    FMDBQuickCheck(worked);
    
    NSString *insertStr=@"INSERT INTO 'LostBean' ('UUIDString','tagName','imageName','lostTime','lostYear','lostMonth','lostDay','lostLot','lostLat','lostAddress') VALUES (?,?,?,?,?,?,?,?,?,?)";
    

    
    worked = [db executeUpdate:insertStr,lostBean.UUIDString,lostBean.tagName,lostBean.imageName,lostBean.lostTime,lostBean.lostYear,lostBean.lostMonth,lostBean.lostDay,lostBean.lostLot,lostBean.lostLat,lostBean.lostAddress];
    
//    FMDBQuickCheck(worked);
    
    
    [db close];
    
    
    return worked;
}
+(BOOL)updateLostBeanTagName:(NSString *)tagName with:(NSString *)UUIDString{
    
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    
    [self check:db];
    NSString *str=@"UPDATE LostBean  SET tagName=? where UUIDString=?";
    
    
    
    BOOL worked = [db executeUpdate:str,tagName,UUIDString];
    FMDBQuickCheck(worked);
    
    [db close];
    
    return worked;
    
 
}
+(BOOL)updateLostBeanImageName:(NSString *)imageName with:(NSString *)UUIDString{
    
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    
    [self check:db];
    NSString *str=@"UPDATE LostBean  SET imageName=? where UUIDString=?";
    
    
    
    BOOL worked = [db executeUpdate:str,imageName,UUIDString];
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
    NSString *str=@"DELETE  FROM LostBean WHERE _id=?";
    
    
    
    BOOL worked = [db executeUpdate:str,_id];
    FMDBQuickCheck(worked);
    
    [db close];
    
    return worked;
}

+(BOOL)deleteLostBean:(NSString *)year month:(NSString *)month{
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    
    [self check:db];
    NSString *str=@"DELETE  FROM LostBean WHERE lostYear=? AND lostMonth=?";
    
    
    
    BOOL worked = [db executeUpdate:str,year,month];
    FMDBQuickCheck(worked);
    
    [db close];
    
    return worked;
}
+(NSMutableArray *)getAllLostBean{
    
    NSMutableArray *resultArr=[[NSMutableArray alloc]init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return resultArr;
    };
    
    [self check:db];
    
    FMResultSet *rs=[db executeQuery:@"SELECT lostYear,lostMonth FROM LostBean GROUP BY lostMonth ORDER BY lostYear desc,lostMonth desc"];
    
    NSMutableArray *ymList=[[NSMutableArray alloc] init];
    while ([rs next]) {
        [ymList addObject:@{@"lostYear":@([rs intForColumn:@"lostYear"]),@"lostMonth":@([rs intForColumn:@"lostMonth"])}];
    }
    
    
    
    
    for (NSDictionary *div in ymList) {
        
        NSString *ymString=@"SELECT * FROM LostBean WHERE lostYear=? AND lostMonth=?  ORDER BY lostDay desc";
        
        
        NSString *lostYear=[NSString stringWithFormat:@"%@",div[@"lostYear"]];
        NSString *lostMonth=[NSString stringWithFormat:@"%@",div[@"lostMonth"]];
        
        NSMutableArray *arr=[[NSMutableArray alloc] init];
        
         FMResultSet *rset=[db executeQuery:ymString,[NSString stringWithFormat:@"%@",div[@"lostYear"]],[NSString stringWithFormat:@"%@",div[@"lostMonth"]]];
        
        while ([rset next]) {
            LostBean *lostBean=[[LostBean alloc] init];
            lostBean.UUIDString=[rset stringForColumn:@"UUIDString"];
            lostBean.tagName=[rset stringForColumn:@"tagName"];
            lostBean.imageName=[rset stringForColumn:@"imageName"];
            lostBean.lostTime=[rset stringForColumn:@"lostTime"];
            lostBean.lostYear=[rset stringForColumn:@"lostYear"];
            lostBean.lostMonth=[rset stringForColumn:@"lostMonth"];
            lostBean.lostDay=[rset stringForColumn:@"lostDay"];
            lostBean.lostLot=[rset stringForColumn:@"lostLot"];
            lostBean.lostLat=[rset stringForColumn:@"lostLat"];
            lostBean.lostAddress=[rset stringForColumn:@"lostAddress"];
              lostBean._id=[rset stringForColumn:@"_id"];
         
            
            [arr addObject:[lostBean toDictionary]];
            
        }
        
        
        NSMutableDictionary *mutableDic=[[NSMutableDictionary alloc] init];
        [mutableDic setObject:arr forKey:@"arr"];
         [mutableDic setObject:lostYear forKey:@"lostYear"];
         [mutableDic setObject:lostMonth forKey:@"lostMonth"];
        
        [resultArr addObject:mutableDic];
//        [resultArr addObject:@{@"arr":arr,@"lostYear":lostYear,@"lostMonth":lostMonth}];
        
    }
    
    
    [rs close];
    [db close];
    
    
    
    
    return resultArr;
    
    
 
}

/*
+(NSMutableArray *)getAllLostBean{
    
    NSMutableArray *resultArr=[[NSMutableArray alloc]init];
    
//    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
//    if (![db open]) {
//        NSLog(@"数据库打开失败");
//        return resultArr;
//    };
    
    
    
    
     NSMutableArray *ymList=[[NSMutableArray alloc] init];
    
    FMDatabaseQueue *queue=[FMDatabaseQueue databaseQueueWithPath:DATABASE_PATH];
    [queue inDatabase:^(FMDatabase *db) {
        
        
        
        [self check:db];
        
        [db open];
        
        FMResultSet *rs=[db executeQuery:@"SELECT lostYear,lostMonth FROM LostBean GROUP BY lostMonth ORDER BY lostYear desc,lostMonth desc"];
        
        while ([rs next]) {
            [ymList addObject:@{@"lostYear":@([rs intForColumn:@"lostYear"]),@"lostMonth":@([rs intForColumn:@"lostMonth"])}];
        }

        [db close];
        
    }];
    
    
    [queue inDatabase:^(FMDatabase *db) {
        
        [db open];
        
        for(NSDictionary *div in ymList){
        
            NSString *ymString=@"SELECT * FROM LostBean WHERE lostYear=? AND lostMonth=?  ORDER BY lostDay desc";
            
            
            NSString *title=[NSString stringWithFormat:@"%@-%@",div[@"lostYear"],div[@"lostMonth"]];
            
            NSMutableArray *arr=[[NSMutableArray alloc] init];
            
            FMResultSet *rset=[db executeQuery:ymString,[NSString stringWithFormat:@"%@",div[@"lostYear"]],[NSString stringWithFormat:@"%@",div[@"lostMonth"]]];
            
            while ([rset next]) {
                LostBean *lostBean=[[LostBean alloc] init];
                lostBean.UUIDString=[rset stringForColumn:@"UUIDString"];
                lostBean.tagName=[rset stringForColumn:@"tagName"];
                lostBean.imageName=[rset stringForColumn:@"imageName"];
                lostBean.lostTime=[rset stringForColumn:@"lostTime"];
                lostBean.lostYear=[rset stringForColumn:@"lostYear"];
                lostBean.lostMonth=[rset stringForColumn:@"lostMonth"];
                lostBean.lostDay=[rset stringForColumn:@"lostDay"];
                lostBean.lostLot=[rset stringForColumn:@"lostLot"];
                lostBean.lostLat=[rset stringForColumn:@"lostLat"];
                lostBean.lostAddress=[rset stringForColumn:@"lostAddress"];
                lostBean._id=[rset stringForColumn:@"_id"];
                
                
                [arr addObject:[lostBean toDictionary]];
                
            }
            
            
            [resultArr addObject:@{@"arr":arr,@"title":title}];
            
       
        
        }
         [db close];
    }];
    
   
    
   
    
    
//    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:DATABASE_PATH];
    
    
   
    
    
  
    
    
    
    
    return resultArr;
    
    
  
}
*/


+(BOOL)check:(FMDatabase *)db{
    
    
    
    BOOL worked = [db executeUpdate:CREATE_LostBean_SQL];
    FMDBQuickCheck(worked);
    
    
    return worked;
}
@end
