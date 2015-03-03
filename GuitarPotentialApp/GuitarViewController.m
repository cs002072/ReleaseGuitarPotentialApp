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
    NSMutableArray *_pushedFlag;
    NSMutableArray *_DummyPushedFlag;
    NSArray *_codeImageView;
    BOOL _isflag;
//    _songList = @[@"涙のキッス", @"いとしのエリー"];
}

@end

@implementation GuitarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pushedFlag = [[NSMutableArray alloc] init];
    _DummyPushedFlag = [[NSMutableArray alloc] init];

    // Do any additional setup after loading the view.
    _codeId = @[@[@"11", @"21", @"31", @"41", @"51", @"61"],
                @[@"12", @"22", @"32", @"42", @"52", @"62"],
                @[@"13", @"23", @"33", @"43", @"53", @"63"],
                @[@"14", @"24", @"34", @"44", @"54", @"64"],
                @[@"15", @"25", @"35", @"45", @"55", @"65"],
                @[@"16", @"26", @"36", @"46", @"56", @"66"],];
    for (int i = 0; i < 6; i++) {
        for (int j = 0; j < 7; j++) {
            _isflag = NO;
//            _DummyPushedFlag = [_pushedFlag objectAtIndex:i];
            [_DummyPushedFlag addObject:@(_isflag)];
//            [_DummyPushedFlag set]
            NSLog(@"dsdfsdf");
        }
        
    }
//    _pushedFlag = @[@[@NO, @NO, @NO, @NO, @NO, @NO, @NO],
//                      @[@YES, @NO, @NO, @NO, @NO, @NO, @NO],
//                      @[@NO, @NO, @NO, @NO, @NO, @NO, @NO],
//                      @[@NO, @NO, @NO, @NO, @NO, @NO, @NO],
//                      @[@NO, @NO, @NO, @NO, @NO, @NO, @NO],
//                      @[@NO, @NO, @NO, @NO, @NO, @NO, @NO]];
    _codeImageView = @[@[self.string11, self.string21, self.string31, self.string41, self.string51, self.string61],
                       @[self.string12, self.string22, self.string32, self.string42, self.string52, self.string62],
                       @[self.string13, self.string23, self.string33, self.string43, self.string53, self.string63],
                       @[self.string14, self.string24, self.string34, self.string44, self.string54, self.string64],
                       @[self.string15, self.string25, self.string35, self.string45, self.string55, self.string65],
                       @[self.string16, self.string26, self.string36, self.string46, self.string56, self.string66]];
//    NSLog(@"beginTouched");
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    UIImageView *ImageViewAtGuitar;
    switch (touch.view.tag) {
        default:
            if ([_pushedFlag[0][1] isEqual:@YES]){
                self.string11.image = [UIImage imageNamed:@"normal_guitarstring.png"];
                return;
            }
            self.string11.image = [UIImage imageNamed:@"pushed_guitarstring.png"];
//            BOOL sdfsd = [
            
            //            _pushedFlag[0][1] = false;
//            _pushedFlag[0][1]=YES;
            break;
    }
}

- (void) pushedString {
    
}

// 遷移前の画面に戻るためのボタンを押した時の処理
- (IBAction)goBack {
    self.navigationController.navigationBarHidden = NO;  // 元の画面に戻る際にナビゲーションバーを再表示
    [self.navigationController popViewControllerAnimated:YES];
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
