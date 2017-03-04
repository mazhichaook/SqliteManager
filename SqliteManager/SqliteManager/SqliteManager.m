//
//  SqliteManager.m
//  SqliteManager
//
//  Created by 马志超 on 2017/3/3.
//  Copyright © 2017年 ziqiang. All rights reserved.
//

#import "SqliteManager.h"
#import <objc/runtime.h>
#import <sqlite3.h>

SqliteManager *instance;

@interface SqliteManager ()
{
    sqlite3 *db;
}
@end

@implementation SqliteManager
// db: COpaquePointer = nil
+(instancetype) shareSqliteManage{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SqliteManager alloc]init];
    });
    
    return instance;
}
// 打开数据库
-(BOOL) openDB:(NSString *)dbName{
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true).firstObject;
    
    path =[path stringByAppendingPathComponent:dbName];
    
    NSLog(@"%@",path);
    
    if (sqlite3_open(path.UTF8String, &db) != SQLITE_OK) {
        NSLog(@"打开数据库失败");
        return NO;
    }

    return YES;
}
-(BOOL)exeSql:(NSString *)sql{

    return (sqlite3_exec(db, sql.UTF8String, nil, nil, nil) == SQLITE_OK);
}
-(BOOL)createTableWithClass:(Class)className{
    unsigned int count;
    
    NSMutableString *sql = [NSMutableString stringWithFormat:@"CREATE TABLE IF NOT EXISTS T_Person ('id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,"];
    objc_property_t *properties = class_copyPropertyList(className, &count);
    
    for (int i = 0; i < count; i++) {
        
        objc_property_t pro = properties[i];
        
        const char *name = property_getName(pro);
        
        NSString *proName = [[NSString alloc]initWithUTF8String:name];
        
        if (count == 1 || (i == count - 1)) {
            [sql appendFormat:@" '%@' TEXT );", proName];
        }else{
            [sql appendFormat:@" '%@' TEXT, ", proName];
        }
    }
    NSLog(@"%@",sql);
    
    return [self exeSql:sql.copy];
}
@end
