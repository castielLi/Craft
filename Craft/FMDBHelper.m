//
//  FMDBHelper.m
//  NovaiOS
//
//  Created by castiel on 16/4/20.
//  Copyright © 2016年 hecq. All rights reserved.
//

#import "FMDBHelper.h"

@implementation FMDBHelper

static NSArray<NSString*>* tableQueries;

static NSString* tableName;

+ (id)sharedData
{
    static FMDBHelper *sharedData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedData = [[self alloc] init];
    });
    
    [sharedData OpenDatabase];
    
    return sharedData;
}

+(void)configDatabaseWithName:(NSString *)databaseName tableQueries:(NSArray<NSString*>*)queries{

    tableName = databaseName;
    tableQueries = queries;
}

-(bool)OpenDatabase{

    NSString * documentsFolder = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0];
    
    NSString * path = [documentsFolder stringByAppendingString: [@"/" stringByAppendingString:tableName]];
    self.instance = [[FMDatabase alloc]initWithPath:path];
    
    if (![self.instance open]){
        NSLog(@"open datasource failed");
        return false;
    }
    
    for( int i = 0; i<tableQueries.count; i++){
         [self.instance executeUpdate:tableQueries[i]];
    }
    
    return true;
}

-(NSDictionary *)DatabaseQueryWithParameters : (NSArray*) parameters query:(NSString*)query values:(NSArray *)values{
    
    FMResultSet* result = [self.instance executeQuery:query withArgumentsInArray:values];
    
    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc]init];
    
    while ([result next]) {
        
        for(NSString* para in parameters){
            [dictionary addEntriesFromDictionary: @{para : [result stringForColumn:para]}];
        }
    }
    
    return dictionary;
}


-(BOOL)DatabaseExecuteWithQuery:(NSString*)query values:(NSArray*)values{
    return [self.instance executeUpdate:query withArgumentsInArray:values];
}


@end
