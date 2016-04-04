//
//  Entity+information.h
//  TvShowManage
//
//  Created by shucheng on 16/3/30.
//  Copyright © 2016年 shucheng. All rights reserved.
//

#import "Entity.h"

@interface Entity (information)

+(Entity *)tvShowWithInfo:(NSDictionary*)tvShowDictionary
  inManagedObjectContext:(NSManagedObjectContext*)context;


@end
