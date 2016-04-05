//
//  FavoritesList.m
//  TvShowManage
//
//  Created by shucheng on 16/4/4.
//  Copyright © 2016年 shucheng. All rights reserved.
//

#import "FavoritesList.h"
#import "FMDB.h"

@interface FavoritesList()
@property (strong,nonatomic)NSMutableArray *favorite;
@property(nonatomic,strong)FMDatabase *db;
@end
@implementation FavoritesList


+(instancetype)shardFavoritesList{
    static FavoritesList *shared  = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken ,^{
        shared = [[self alloc]init];
    });
    return shared;
}

-(instancetype)init{
    self =[super init];
    if (self) {
        NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fileName=[doc stringByAppendingPathComponent:@"tvShow.sqlite"];
        FMDatabase *db=[FMDatabase databaseWithPath:fileName];
        if([db open]){
            // 1.执行查询语句
            FMResultSet *resultSet = [db executeQuery:@"SELECT * FROM t_show"];
            // 2.遍历结果
            while ([resultSet next]) {
                NSInteger favoriteFlag = [resultSet intForColumn:@"favoriteFlag"];
                NSLog(@"%ld", favoriteFlag);
                NSArray *storedFavorites = [[NSArray alloc]init];
                if (!favoriteFlag) {
                    self.favorite =[storedFavorites mutableCopy];
                }else{
                    self.favorite = [NSMutableArray array];
                }
            }

        }
    }
    return self;
}

-(void)saveFavorites{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:self.favorites forKey:@"favorite"];
    [defaults synchronize];
}

//下面的是添加和删除收藏，可以快速储存更改
- (void)addFavorite:(id)item {
    [_favorite insertObject:item atIndex:0];
    [self saveFavorites];
}
//使用_favorite的原因是若使用self.favorite，编译器会在头文件中发现这是一个NSArray（不可变的）


-(void)removeFavorite:(id)item{
    [_favorite removeObject:item];
    [self saveFavorites];
}


-(void)moveItemAtIndex:(NSInteger)from toIndex:(NSInteger)to{
    id item=_favorite[from];
    [_favorite removeObjectAtIndex:from];
    [_favorite insertObject:item atIndex:to];
    [self saveFavorites];
}
@end
