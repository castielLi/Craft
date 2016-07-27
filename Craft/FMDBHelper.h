//
//  FMDBHelper.h
//  NovaiOS
//
//  Created by castiel on 16/4/20.
//  Copyright © 2016年 hecq. All rights reserved.
//

#import <Foundation/Foundation.h>
@import FMDB;
#import "sqlite3.h"

@interface FMDBHelper : NSObject

@property (nonatomic,strong) FMDatabase * instance;

+(id)sharedData;

+(void)configDatabaseWithName:(NSString *)databaseName tableQueries:(NSArray<NSString*>*)queries;

-(bool)OpenDatabase;

-(NSDictionary *)DatabaseQueryWithParameters : (NSArray*) parameters query:(NSString*)query values:(NSArray *)values;

-(NSMutableArray *)DatabaseSearchValuesWithParameters : (NSArray*) parameters query:(NSString*)query values:(NSArray *)values;

-(BOOL)DatabaseExecuteWithQuery:(NSString*)query values:(NSArray*)values;

-(instancetype)init;

@end
