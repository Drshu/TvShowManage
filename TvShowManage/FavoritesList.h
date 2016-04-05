//
//  FavoritesList.h
//  TvShowManage
//
//  Created by shucheng on 16/4/4.
//  Copyright © 2016年 shucheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoritesList : NSObject
+(instancetype)shardFavoritesList;//声明类属性，返回一个实例

-(NSArray *)favorites;

-(void)addFavorite:(id)item;

-(void)removeFavorite:(id)item;

@end
