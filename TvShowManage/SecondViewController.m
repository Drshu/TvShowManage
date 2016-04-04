//
//  SecondViewController.m
//  TvShowManage
//
//  Created by shucheng on 16/3/29.
//  Copyright © 2016年 shucheng. All rights reserved.
//

#import "SecondViewController.h"
#import "Entity.h"
static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";

@interface SecondViewController ()
@property(copy,nonatomic)NSMutableDictionary *names;
@property (nonatomic,strong) NSManagedObjectContext* context;
@property(copy,nonatomic)NSArray *keys;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SectionsTableIdentifier];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Entity"];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"showName" ascending:NO];
    request.sortDescriptors = @[sort];
    
    request.fetchLimit = 100;
    request.fetchOffset= 0;
    
    NSError *error = nil;
    NSArray *array = [self.context executeFetchRequest:request error:&error];
    NSMutableDictionary *names = [NSMutableDictionary dictionaryWithCapacity:1];
    if(!error){
        for (Entity *emp in array ) {
            NSLog(@"output：%@",emp.showName);
            names =[NSMutableDictionary dictionaryWithObjectsAndKeys:emp.showName, nil];
            self.keys =[[self.names allKeys]sortedArrayUsingSelector:@selector(compare:)];
        }
    }
    else{
        NSLog(@"%@",error);
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.keys count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *key = self.keys[section];
    NSArray *nameSection =self.names[key];
    return [nameSection count];
}

-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return self.keys[section];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SectionsTableIdentifier
                                                            forIndexPath:indexPath];
    NSString *key = self.keys[indexPath.section];
    NSArray *nameSection = self.names[key];
    
    cell.textLabel.text = nameSection[indexPath.row];
    return cell;
}
@end
