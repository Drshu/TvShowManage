//
//  DataFromDataBase.m
//  TvShowManage
//
//  Created by shucheng on 16/4/4.
//  Copyright © 2016年 shucheng. All rights reserved.
//

#import "DataFromDataBase.h"

@implementation DataFromDataBase

+ (DataFromDataBase *)shareFromDataBase
{
    static DataFromDataBase *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedInstance == nil) {
            sharedInstance = [[DataFromDataBase alloc] init];
        }
    });
    return sharedInstance;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        _nameFromClass = @"";
        _introductionFromClass = @"";
        _lastDateFromClass = @"";
        _allDateFromClass = @"";
        _nameArrayFromClass = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

@end
