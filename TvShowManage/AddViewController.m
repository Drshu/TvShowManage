//
//  AddViewController.m
//  TvShowManage
//
//  Created by shucheng on 16/3/29.
//  Copyright © 2016年 shucheng. All rights reserved.
//

#import "AddViewController.h"
#import "AppDelegate.h"

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

@property(strong,nonatomic)IBOutletCollection(UITextField)NSArray *showInformation;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//获取时间选择器的熟悉列表，并初始化时间选择器
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
