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
    
    //创建持久化储存,先确定有没有已经存在数据
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;

     NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]
                               initWithEntityName:kShowENtityName];//将实体传递

    //[[segue destinationViewController] setManagedObjectContext:self.managedObjectContext];
    //request.sortDescriptors = @[[NSSortDescriptor  sortDescriptorWithKey:@"TvShowName" ascending:YES]];
    //request.predicate = [NSPredicate predicateWithFormat:@"....",...]
    //这里是一个谓词，可以限定只取出某一些
    
    
    NSError *error;
    NSArray *object =[context executeFetchRequest:request error:&error];
    if(object == nil){
        NSLog(@"出现错误！");
    }
//    for(NSManagedObject *oneObject in object){
//        NSString *showName =[oneObject valueForKey:kTvShowNameKey];
//        NSString *showAllDate = [oneObject valueForKey:kTvShowAllDateKey];
//        NSString *showLastedDate = [oneObject valueForKey:kTvShowLastedDateKey];
//        NSString *showIntroduction = [oneObject valueForKey:kTvShowIntroductionKey];
//        
//    }
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


-(void)setupContenxt{
    //创建一个数据库
    //数据库里面有一张表
    //1/添加上下文,关联数据，模型文件
    NSManagedObjectContext * contenxt = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    
    //2.关联模型文件
    //传一个nil会把所有的bundle的模型文件都关联起来
    NSManagedObjectModel * model = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    //3.持久化数据存储
    NSPersistentStoreCoordinator * store = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    
    //存储数据库的名字
    NSError * error = nil;
    
    //获取docment目录
    NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    //数据库保存的路径
    NSString * sqlite = [doc stringByAppendingPathComponent:@"TvShowManage.sqlite"];
    
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:sqlite] options:nil error:&error];
    
    contenxt.persistentStoreCoordinator = store;
    
    self.contenxt = contenxt;
    
}

-(IBAction)addButton:(id)sender{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];


    NSInteger seasonRow = [self.dataPicker selectedRowInComponent:kSeason];
    NSInteger episodeRow = [self.dataPicker selectedRowInComponent:kEpisode];
    Entity * tvShow1 =[NSEntityDescription insertNewObjectForEntityForName:@"Entity"
                                                    inManagedObjectContext:context];
    NSError * error = nil;
    
    NSString *name = self.nameField.text;
    NSString *introduction = self.introductionField.text;
    NSString *dateSeason = self.seasonNumber[seasonRow];
    NSString *dateEposide = self.episodeNumber[episodeRow];
    NSString *date;
    date = [dateSeason stringByAppendingString:dateEposide];
    tvShow1.showName =name;
    tvShow1.showIntroduction = introduction;
    tvShow1.showLastedData = date;
    if (!error) {
        NSLog(@"保存成功");
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
        [self.contenxt save:&error];
    }
    [appDelegate saveContext];
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
