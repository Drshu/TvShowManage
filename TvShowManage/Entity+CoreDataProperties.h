//
//  Entity+CoreDataProperties.h
//  TvShowManage
//
//  Created by shucheng on 16/3/29.
//  Copyright © 2016年 shucheng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Entity.h"

NS_ASSUME_NONNULL_BEGIN

@interface Entity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *showName;
@property (nullable, nonatomic, retain) NSString *showIntroduction;
@property (nullable, nonatomic, retain) NSString *showAllData;
@property (nullable, nonatomic, retain) NSString *showLastedData;



@end

NS_ASSUME_NONNULL_END
