//
//  GuitarModeViewController.m
//  GuitarPotentialApp
//
//  Created by 岡 慎一郎 on 2015/03/03.
//  Copyright (c) 2015年 oka.shinichiro. All rights reserved.
//

#import "GuitarModeViewController.h"
#import "GuitarViewController.h"
#import "StrokeViewController.h"

@interface GuitarModeViewController ()

@end

@implementation GuitarModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)GuitarCodePracticeButton:(id)sender {
    //画面遷移するViewControllerのカプセル化（インスタンス化）
    GuitarViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"GuitarViewController"];
    
    dvc.hidesBottomBarWhenPushed = YES;  // 画面遷移後にタブバーを隠すための処理
    //ナビゲーションコントローラーの機能で画面遷移
    [[self navigationController] pushViewController:dvc animated:YES];
}

- (IBAction)StrokePracticeButton:(id)sender {
    //画面遷移するViewControllerのカプセル化（インスタンス化）
    StrokeViewController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"StrokeViewController"];
    
    svc.hidesBottomBarWhenPushed = YES;  // 画面遷移後にタブバーを隠すための処理
    //ナビゲーションコントローラーの機能で画面遷移
    [[self navigationController] pushViewController:svc animated:YES];
}
@end
