//
//  FirstViewController.m
//  TvShowManage
//
//  Created by shucheng on 16/3/29.
//  Copyright © 2016年 shucheng. All rights reserved.
//

#import "FirstViewController.h"
#import "Entity.h"
#import "AppDelegate.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize context;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];//这里需要引进自己项目的委托，是让全局managedObjectContext起作用。
    self.context = delegate.managedObjectContext;
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
