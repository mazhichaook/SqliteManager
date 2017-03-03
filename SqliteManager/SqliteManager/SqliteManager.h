//
//  SqliteManager.h
//  SqliteManager
//
//  Created by 马志超 on 2017/3/3.
//  Copyright © 2017年 ziqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SqliteManager : NSObject

+(instancetype) shareSqliteManage;

-(BOOL) openDB:(NSString *)dbName;
-(BOOL) exeSql:(NSString *)sql;
-(BOOL) createTableWithClass:(Class)className;
@end
