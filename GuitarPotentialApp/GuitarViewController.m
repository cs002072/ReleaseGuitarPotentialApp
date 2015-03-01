//
//  GuitarViewController.m
//  GuitarPotentialApp
//
//  Created by 岡 慎一郎 on 2015/03/01.
//  Copyright (c) 2015年 oka.shinichiro. All rights reserved.
//

#import "GuitarViewController.h"

@interface GuitarViewController () {
    NSArray *_codeId;
//    _songList = @[@"涙のキッス", @"いとしのエリー"];
}

@end

@implementation GuitarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _codeId = @[@[@"11", @"21", @"31", @"41", @"51", @"61"],
                @[@"12", @"22", @"32", @"42", @"52", @"62"],
                @[@"13", @"23", @"33", @"43", @"53", @"63"],
                @[@"14", @"24", @"34", @"44", @"54", @"64"],
                @[@"15", @"25", @"35", @"45", @"55", @"65"],
                @[@"16", @"26", @"36", @"46", @"56", @"66"],];
    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"beginTouched");
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

@end
