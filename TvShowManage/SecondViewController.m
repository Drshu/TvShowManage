//
//  SecondViewController.m
//  TvShowManage
//
//  Created by shucheng on 16/3/29.
//  Copyright © 2016年 shucheng. All rights reserved.
//

#import "SecondViewController.h"
#import "Entity.h"
#import "FMDB.h"
#import "DataFromDataBase.h"
#import "FavoritesList.h"
#import "ShowListViewController.h"
static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";
int count=0;

@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(copy,nonatomic)NSMutableDictionary *names;
@property(copy,nonatomic)NSArray *keys;
@property(nonatomic,strong)FMDatabase *db;
@property (nonatomic, strong) NSMutableArray *nameArray;
@property(copy,nonatomic)NSString *familyName;
@property(strong,nonatomic)FavoritesList *favoriteList;
@property(strong,nonatomic)NSString *date;
@property(strong,nonatomic)UITableView *tableView;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//
//    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Entity"];
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"showName" ascending:NO];
//    request.sortDescriptors = @[sort];
//    
//    request.fetchLimit = 100;
//    request.fetchOffset= 0;
//    
//    NSError *error = nil;
//    NSArray *array = [self.context executeFetchRequest:request error:&error];
//    NSMutableDictionary *names = [NSMutableDictionary dictionaryWithCapacity:1];
//    if(!error){
//        for (Entity *emp in array ) {
//            NSLog(@"output：%@",emp.showName);
//            names =[NSMutableDictionary dictionaryWithObjectsAndKeys:emp.showName, nil];
//            self.keys =[[self.names allKeys]sortedArrayUsingSelector:@selector(compare:)];
//        }
//    }
//    else{
//        NSLog(@"%@",error);
//    }

   
    UITableView *tableView = (id)[self.view viewWithTag:1];
    UIEdgeInsets contentInset = tableView.contentInset;
    contentInset.top = 20;//调整表视图顶部边缘值
    [tableView setContentInset:contentInset];
      //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem  alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(modifyDatabase)];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self query];
}

-(void)query{
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName=[doc stringByAppendingPathComponent:@"tvShow.sqlite"];
    FMDatabase *db=[FMDatabase databaseWithPath:fileName];
    self.nameArray = [[NSMutableArray alloc]init];
    if([db open]){
    // 1.执行查询语句
    FMResultSet *resultSet = [db executeQuery:@"SELECT * FROM t_show"];
    // 2.遍历结果
    while ([resultSet next]) {
        int ID = [resultSet intForColumn:@"id"];
        NSString *name = [resultSet stringForColumn:@"name"];
        NSString *introduction = [resultSet stringForColumn:@"introduction"];
        NSString *lastDate = [resultSet stringForColumn:@"lastDate"];
        NSLog(@"%d %@ %@ %@", ID, name, introduction,lastDate);
        [self.nameArray addObject:name];
    }
    [[DataFromDataBase shareFromDataBase].nameArrayFromClass arrayByAddingObjectsFromArray:self.nameArray];
    NSLog(@"self.nameArray == %@",self.nameArray);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -
#pragma UITableView
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return nil;
    }else
    {
        return indexPath;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.nameArray.count+1;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SectionsTableIdentifier];
 
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:SectionsTableIdentifier];
    }
    cell.textLabel.text = [self.nameArray objectAtIndex:indexPath.row-1];
    return cell;
}
-(NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return nil;//第一行的时候返回nil
    }else{
        return indexPath;//传递即将选中的行对应的索引
    }
}

#pragma -
#pragma Info Viewcontroller


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    ShowListViewController *listVC = segue.destinationViewController;
    NSString *familyName = self.nameArray[indexPath.row];
    listVC.navigationItem.title = familyName;
    
}


@end
