//
//  AddViewController.m
//  TvShowManage
//
//  Created by shucheng on 16/3/29.
//  Copyright © 2016年 shucheng. All rights reserved.
//

#import "AddViewController.h"

#define kSeason 0
#define kEpisode 1

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *dataPicker;
@property(strong,nonatomic) NSArray *seasonNumber;
@property(strong,nonatomic) NSArray *episodeNumber;
@property(strong,nonatomic) NSDictionary *seasonEpisode;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.seasonNumber = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16"];
//  self.episodeNumber=@[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16"];
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *plistURl = [bundle URLForResource:@"DataList" withExtension:@"plist"];
    
    self.seasonEpisode = [NSDictionary
                          dictionaryWithContentsOfURL:plistURl];
    NSArray *allSeason = [self.seasonEpisode allKeys];
    NSArray *sortedSeason = [allSeason sortedArrayUsingSelector:@selector(compare:)];
    self.seasonNumber = sortedSeason;
    NSString *selectedSeason = self.seasonNumber[0];
    self.episodeNumber = self.seasonEpisode[selectedSeason];
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
