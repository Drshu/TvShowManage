//
//  DataFromDataBase.h
//  TvShowManage
//
//  Created by shucheng on 16/4/4.
//  Copyright © 2016年 shucheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataFromDataBase : NSObject

@property(retain,nonatomic) NSString *nameFromClass;

@property(retain,nonatomic)NSString *introductionFromClass;

@property(retain,nonatomic)NSString *lastDateFromClass;

@property(retain,nonatomic)NSString *allDateFromClass;

@property(retain,nonatomic)NSMutableArray *nameArrayFromClass;

+(DataFromDataBase *)shareFromDataBase;
@end
