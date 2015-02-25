//
//  detailViewController.m
//  GuitarPotentialApp
//
//  Created by 岡 慎一郎 on 2015/02/23.
//  Copyright (c) 2015年 oka.shinichiro. All rights reserved.
//

#import "detailViewController.h"

@interface detailViewController (){
//    NSUserDefaults *_defaults;
}

@end

@implementation detailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // myTabBar = [[UITabBarController alloc] init];
    
    
    NSUserDefaults *_defaults = [NSUserDefaults standardUserDefaults];
    NSString *dStr = [_defaults stringForKey:@"saveFlag"];
    
    /***********************************************/
    /**********テキストファイル読み込みフェーズ***********/
    /***********************************************/
    NSError *error = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"J-Total Music－涙のキッス（サザンオールスターズ）" ofType:@"txt"];
    self.SongWordStr.text = [NSString stringWithContentsOfFile:filePath encoding:NSShiftJISStringEncoding error:&error];
    NSLog(@"%@", self.SongWordStr.text);
    /***********************************************/
    /**********テキストファイル読み込みフェーズ***********/
    /***********************************************/
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

- (IBAction)tapSaveButton:(id)sender {
    NSUserDefaults *_defaults = [NSUserDefaults standardUserDefaults];
    [_defaults setObject:@"NO" forKey:@"saveFlag"];
    BOOL sdf = [_defaults stringForKey:@"saveFlag"];
    
    UITabBarController *tab = (UITabBarController *)[self presentingViewController];
    [tab setSelectedIndex:2];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)tapCancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
