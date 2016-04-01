//
//  Entity+information.m
//  TvShowManage
//
//  Created by shucheng on 16/3/30.
//  Copyright © 2016年 shucheng. All rights reserved.
//

#import "Entity+information.h"

@implementation Entity (information)


//+(Entity*)tvShowWithInfo:(NSDictionary *)tvShowDictionary inManagedObjectContext:(NSManagedObjectContext *)context{
//    
//    Entity *tvShow = nil;
//    NSFetchRequest *request  = [NSFetchRequest fetchRequestWithEntityName:@"tvShow"];
//    
//    NSError *error;
//    NSArray *match = [context executeFetchRequest:request error:&error];
//    
//    if(!match || error || [match count]>1){
//        
//    }else if([match count]){
//        tvShow = [match firstObject];
//    }else{
//        tvShow = [NSEntityDescription insertNewObjectForEntityForName:@"showName"
//                                               inManagedObjectContext:context];
//
//    }
//    return tvShow;
//}
@end
