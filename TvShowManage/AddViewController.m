//
//  AddViewController.m
//  TvShowManage
//
//  Created by shucheng on 16/3/29.
//  Copyright © 2016年 shucheng. All rights reserved.
//

#import "AddViewController.h"
#import "AppDelegate.h"
#import "Entity.h"
#import "FMDB.h"

#define kSeason 0
#define kEpisode 1


static NSString* const kShowENtityName = @"Entity";
static NSString* const kTvShowNameKey = @"showName";
static NSString* const kTvShowAllDateKey = @"showAllDate";
static NSString* const kTvShowLastedDateKey = @"showLastedDate";
static NSString* const kTvShowIntroductionKey = @"showIntroduction";


@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *dataPicker;
@property(strong,nonatomic) NSArray *seasonNumber;
@property(strong,nonatomic) NSArray *episodeNumber;
@property(strong,nonatomic) NSDictionary *seasonEpisode;
@property (nonatomic,strong) NSManagedObjectContext* contenxt;
@property(nonatomic,strong)FMDatabase *db;



@property(strong,nonatomic)IBOutletCollection(UITextField)NSArray *showInformation;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *introductionField;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//获取时间选择器的属性列表，并初始化时间选择器
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *plistURl = [bundle URLForResource:@"DataList" withExtension:@"plist"];
    
    self.seasonEpisode = [NSDictionary
                          dictionaryWithContentsOfURL:plistURl];
    NSArray *allSeason = [self.seasonEpisode allKeys];
    NSArray *sortedSeason = [allSeason sortedArrayUsingSelector:@selector(compare:)];
    self.seasonNumber = sortedSeason;
    NSString *selectedSeason = self.seasonNumber[0];
    self.episodeNumber = self.seasonEpisode[selectedSeason];
    
    //1.获得数据库文件的路径
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName=[doc stringByAppendingPathComponent:@"tvShow.sqlite"];
    
    //2.获得数据库
    FMDatabase *db=[FMDatabase databaseWithPath:fileName];
    
    //3.打开数据库
    if ([db open]) {
        //4.创表
        BOOL result=[db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_show (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, introduction text NOT NULL, lastDate text NOT NULL, allDate text NOT NULL);"];
        if (result) {
            NSLog(@"创表成功");
        }else
        {
            NSLog(@"创表失败");
        }
    }
    self.db=db;
}

    



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



-(IBAction)addButton:(id)sender{
    NSInteger seasonRow = [self.dataPicker selectedRowInComponent:kSeason];
    NSInteger episodeRow = [self.dataPicker selectedRowInComponent:kEpisode];

    
    NSString *name = [NSString stringWithFormat:@"%@",self.nameField.text];
    NSString *introduction =[NSString stringWithFormat:@"%@",self.introductionField.text];
    NSString *seasonNumber = [NSString stringWithFormat:@"%@",self.seasonNumber[seasonRow]];
    NSString *episodeNumber = [NSString stringWithFormat:@"E%@",self.episodeNumber[episodeRow]];
    NSString *lastDate;
    lastDate =[seasonNumber stringByAppendingString:episodeNumber];
    NSString *allDate = [NSString stringWithFormat:@"S20E20"];
    [self.db executeUpdate:@"INSERT INTO t_show (name,introduction,lastDate,allDate) VALUES (?,?,?,?)",name,introduction,lastDate,allDate];
    
    NSString *message = [[NSString alloc]initWithFormat:@"你的新剧：%@已经成功添加",name];
    UIAlertController *alert=
    [UIAlertController alertControllerWithTitle:@"恭喜，添加成功"
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好嘞！"
                                                     style:UIAlertActionStyleDefault
                                                   handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    [self query];
    }

-(void)query{
    // 1.执行查询语句
    FMResultSet *resultSet = [self.db executeQuery:@"SELECT * FROM t_show"];
    // 2.遍历结果
    while ([resultSet next]) {
        int ID = [resultSet intForColumn:@"id"];
        NSString *name = [resultSet stringForColumn:@"name"];
        NSString *introduction = [resultSet stringForColumn:@"introduction"];
        NSString *lastDate = [resultSet stringForColumn:@"lastDate"];
        NSLog(@"%d %@ %@ %@", ID, name, introduction,lastDate);
    }

}
#pragma -
#pragma Picker Season
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{//获取有多少行数据
    if (component == kSeason) {
        return [self.seasonNumber count];
    }else {
        return [self.episodeNumber count];
    }
}



#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component//获取每一行的数据
{
    if (component == kSeason) {
        return self.seasonNumber[row];
    } else {
        return self.episodeNumber[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    if (component == kSeason) {
        NSString *selectSeason = self.seasonNumber[row];
        self.episodeNumber = self.seasonEpisode[selectSeason];
        [self.dataPicker reloadComponent:kEpisode];
        [self.dataPicker selectRow:0
                            inComponent:kEpisode
                               animated:YES];
    }
}







@end
