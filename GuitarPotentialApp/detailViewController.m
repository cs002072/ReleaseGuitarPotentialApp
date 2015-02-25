//
//  detailViewController.m
//  GuitarPotentialApp
//
//  Created by 岡 慎一郎 on 2015/02/23.
//  Copyright (c) 2015年 oka.shinichiro. All rights reserved.
//

#import "detailViewController.h"

@interface detailViewController ()

@end

@implementation detailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%d", self.selectNum);
    
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

//- (IBAction)tapCancelButton:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
//    //    [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//- (IBAction)tapSaveButton:(id)sender {
//    [self performSegueWithIdentifier:@"historySegue" sender:nil];
//}



- (IBAction)tapSaveButton:(id)sender {
    [self performSegueWithIdentifier:@"historySegue" sender:nil];
}

- (IBAction)tapCancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
