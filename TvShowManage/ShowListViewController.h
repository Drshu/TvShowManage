//
//  ShowListViewController.h
//  TvShowManage
//
//  Created by shucheng on 16/4/4.
//  Copyright © 2016年 shucheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowListViewController : UITableViewController
@property(copy,nonatomic)NSArray *showName;
@property(assign,nonatomic)BOOL showsFavorite;

@end
