//
//  GuitarViewController.m
//  GuitarPotentialApp
//
//  Created by 岡 慎一郎 on 2015/03/01.
//  Copyright (c) 2015年 oka.shinichiro. All rights reserved.
//

#import "GuitarViewController.h"
#import "AppDelegate.h"
#import "SEManager.h"
#include <AVFoundation/AVFoundation.h>

@interface GuitarViewController () {
    NSArray *_codeId;
    NSMutableArray *_pushedFlag;
    NSMutableArray *_DummyPushedFlag;
    NSMutableArray *_dummyArray;
    NSMutableArray *_truePosition;
    NSArray *_codeImageView;
    NSArray *_soundArray;
    NSArray *_stringArray;
    NSMutableArray *_stringImageView;
    AVAudioPlayer *_audio;

    BOOL _isflag, _touchesMovedFlag;
    int _stringNum, _touchesMovedMemory;
//    _songList = @[@"涙のキッス", @"いとしのエリー"];
}

@end

@implementation GuitarViewController

- (void)viewDidLoad {
    // Do any additional setup after loading the view.

    [super viewDidLoad];
    _stringNum = 9;
    _pushedFlag = [[NSMutableArray alloc] init];
    _dummyArray = [[NSMutableArray alloc] init];
    _codeImageView = [[NSArray alloc] init];
    _truePosition = [[NSMutableArray alloc] init];
    _soundArray = [[NSArray alloc] init];
    _stringArray = [[NSArray alloc] init];
    _stringImageView = [[NSMutableArray alloc] init];
    _touchesMovedFlag = NO;
    
    //-- 左スワイプ
    UISwipeGestureRecognizer *swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(view_SwipeLeft:)];
    //-- 左スワイプを認識するように設定
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    //-- ビューにGestureを追加
    [self.view addGestureRecognizer:swipeLeftGesture];
    
    _codeId = @[@[@"11", @"21", @"31", @"41", @"51", @"61"],
                @[@"12", @"22", @"32", @"42", @"52", @"62"],
                @[@"13", @"23", @"33", @"43", @"53", @"63"],
                @[@"14", @"24", @"34", @"44", @"54", @"64"],
                @[@"15", @"25", @"35", @"45", @"55", @"65"],
                @[@"16", @"26", @"36", @"46", @"56", @"66"]];
    _stringArray = @[@"string6.png", @"string5.png", @"string4.png", @"string3.png", @"string2.png", @"string1.png"];
    
    for (int i = 0; i < 6; i++) {
        _DummyPushedFlag = [[NSMutableArray alloc] init];
        for (int j = 0; j < 7; j++) {
            _isflag = NO;
            [_DummyPushedFlag addObject:@(_isflag)];
        }
        [_pushedFlag addObject:_DummyPushedFlag];
    }
    _soundArray = @[@[@"sound01.wav", @"sound11.wav", @"sound21.wav", @"sound31.wav", @"sound41.wav", @"sound51.wav", @"sound61.wav"],
                    @[@"sound02.wav", @"sound12.wav", @"sound22.wav", @"sound32.wav", @"sound42.wav", @"sound52.wav", @"sound62.wav"],
                    @[@"sound03.wav", @"sound13.wav", @"sound23.wav", @"sound33.wav", @"sound43.wav", @"sound53.wav", @"sound63.wav"],
                    @[@"sound04.wav", @"sound14.wav", @"sound24.wav", @"sound34.wav", @"sound44.wav", @"sound54.wav", @"sound64.wav"],
                    @[@"sound05.wav", @"sound15.wav", @"sound25.wav", @"sound35.wav", @"sound45.wav", @"sound55.wav", @"sound65.wav"],
                    @[@"sound06.wav", @"sound16.wav", @"sound26.wav", @"sound36.wav", @"sound46.wav", @"sound56.wav", @"sound66.wav"]];
    
    _codeImageView = @[@[self.string11, self.string12, self.string13, self.string14, self.string15, self.string16],
                       @[self.string21, self.string22, self.string23, self.string24, self.string25, self.string26],
                       @[self.string31, self.string32, self.string33, self.string34, self.string35, self.string36],
                       @[self.string41, self.string42, self.string43, self.string44, self.string45, self.string46],
                       @[self.string51, self.string52, self.string53, self.string54, self.string55, self.string56],
                       @[self.string61, self.string62, self.string63, self.string64, self.string65, self.string66]];

    
    /***********************************************/
    /**********ギター指板初期化フェーズ***********/
    /***********************************************/

    for (int i = 0; i < [_codeId count]; i++) {
        for (int j = 0; j <= [[_codeId objectAtIndex:0] count]; j++) {
            if (j == 0){
                _isflag = YES;
                [[_pushedFlag objectAtIndex:i] replaceObjectAtIndex:j withObject:@(_isflag)];
                [_truePosition addObject:@(j)];
                //[_truePosition replaceObjectAtIndex:i withObject:0];
            } else {
                _isflag = NO;
                [[_pushedFlag objectAtIndex:i] replaceObjectAtIndex:j withObject:@(_isflag)];
            }
        }
    }
    /***********************************************/
    /**********ギター指板初期化フェーズ***********/
    /***********************************************/
//    UINavigationController *navi = [self navigationController];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"コード一覧" style:UIBarButtonItemStylePlain target:self action:@selector(pushedGuitarContent)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self.navigationController setNavigationBarHidden:NO animated:NO];

    // 画像の幅
    CGFloat width = self.stroke1.frame.size.width;
    // 画像の高さ
    CGFloat height = self.view.bounds.size.height;
    // 拡大・縮小率
    CGFloat scale = 1.5f;
    //iPad Simulator


    if (self.view.bounds.size.height == 480){
        /*iPhone 4のとき*/
        for (int i = 0; i < _stringArray.count; i++) {
            //UIImageView作成
            UIImageView *imageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:[_stringArray objectAtIndex:i]]];
            imageView.userInteractionEnabled = YES;
            imageView.tag = _stringArray.count-i;
            [_stringImageView addObject:imageView];
            CGRect rect = CGRectMake(21+i*imageView.frame.size.width-2, 330, imageView.frame.size.width, imageView.frame.size.height-120);
            imageView.frame = rect;
            [self.view addSubview:imageView];
        }
    }
    else if (self.view.bounds.size.height == 568){
        /*iPhone 5のとき*/
        for (int i = 0; i < _stringArray.count; i++) {
            //UIImageView作成
            UIImageView *imageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:[_stringArray objectAtIndex:i]]];
            imageView.userInteractionEnabled = YES;
            imageView.tag = _stringArray.count-i;
            [_stringImageView addObject:imageView];
            CGRect rect = CGRectMake(21+i*imageView.frame.size.width-2, 330, imageView.frame.size.width, imageView.frame.size.height-30);
            imageView.frame = rect;
            [self.view addSubview:imageView];
        }
    }
    else if (self.view.bounds.size.height == 667){
        /*iPhone 6のとき*/
        for (int i = 0; i < _stringArray.count; i++) {
            //UIImageView作成
            UIImageView *imageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:[_stringArray objectAtIndex:i]]];
            imageView.userInteractionEnabled = YES;
            imageView.tag = _stringArray.count-i;
            [_stringImageView addObject:imageView];
            CGRect rect = CGRectMake(21+i*imageView.frame.size.width-2, 330, imageView.frame.size.width, imageView.frame.size.height+70);
            imageView.frame = rect;
            [self.view addSubview:imageView];
        }
    }
    else if (self.view.bounds.size.height == 736){
        /*iPhone 6 Plusのとき*/
        for (int i = 0; i < _stringArray.count; i++) {
            //UIImageView作成
            UIImageView *imageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:[_stringArray objectAtIndex:i]]];
            imageView.userInteractionEnabled = YES;
            imageView.tag = _stringArray.count-i;
            [_stringImageView addObject:imageView];
            CGRect rect = CGRectMake(21+i*imageView.frame.size.width-2, 330, imageView.frame.size.width, imageView.frame.size.height+100);
            imageView.frame = rect;
            [self.view addSubview:imageView];
        }
    }
    
    
    
//    NSString *model = [UIDevice currentDevice].model;
//    if (!([model isEqualToString:@"iPad Simulator"] || [model isEqualToString:@"iPad"])) {
//    } else {
//    }
}

- (void) pushedGuitarContent {
    //-- pickerViewControllerのインスタンスをstoryboradから取得
    self.guitarContentViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"GuitarContentViewController"];
    self.guitarContentViewController.delegate  = self;
    
    
    //-- PickerViewをサブビューとして表示する
    //-- 表示するときはアニメーションをつけて下から上にゆっくり表示させる
    //-- アニメーション完了時のPickerViewの位置を計算
    UIView *codeIchiran = self.guitarContentViewController.view;
    CGPoint middleCenter = codeIchiran.center;

    //-- アニメーション開始時のPickerViewの位置を計算
    UIWindow *mainWindow = (((AppDelegate *) [UIApplication sharedApplication].delegate).window);
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    CGPoint offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
    codeIchiran.center = offScreenCenter;
    [mainWindow addSubview:codeIchiran];
    //-- アニメーションを使ってPickerViewをアニメーション完了時の位置に表示されるようにする
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    codeIchiran.center = middleCenter;
    [UIView commitAnimations];
}

- (void) closeGuitarContent:(UIViewController *)controller {
    // PickerViewをアニメーションを使ってゆっくり非表示にする
    UIView *codeIchiran = controller.view;
    
    // アニメーション完了時のPickerViewの位置を計算
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    CGPoint offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
    
    [UIView beginAnimations:nil context:(void *)codeIchiran];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    // アニメーション終了時に呼び出す処理を設定
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    codeIchiran.center = offScreenCenter;
    [UIView commitAnimations];
    
}

- (void) initializer {
    for (int i = 0; i < [_codeId count]; i++) {
        for (int j = 0; j < [[_codeId objectAtIndex:i] count]; j++) {
            UIImageView *ImageViewAtGuitar = [[_codeImageView objectAtIndex:i] objectAtIndex:j];
            ImageViewAtGuitar.image = [UIImage imageNamed:@"normal_guitarstring.png"];

            _isflag = NO;
            [[_pushedFlag objectAtIndex:i] replaceObjectAtIndex:j withObject:@(_isflag)];

            
        }
    }
}

- (void)CandCloseGuitarContent:(GuitarContentViewController *)controller{
    [self closeGuitarContent:controller];
    
    [self initializer];
    
    UIImageView *ImageViewAtGuitar = [[_codeImageView objectAtIndex:4] objectAtIndex:2];
    ImageViewAtGuitar.image = [UIImage imageNamed:@"pushed_guitarstring.png"];
    UIImageView *ImageViewAtGuitar2 = [[_codeImageView objectAtIndex:3] objectAtIndex:1];
    ImageViewAtGuitar2.image = [UIImage imageNamed:@"pushed_guitarstring.png"];
    UIImageView *ImageViewAtGuitar3 = [[_codeImageView objectAtIndex:1] objectAtIndex:0];
    ImageViewAtGuitar3.image = [UIImage imageNamed:@"pushed_guitarstring.png"];
    
    _isflag = NO;   [[_pushedFlag objectAtIndex:4] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = YES;  [[_pushedFlag objectAtIndex:4] replaceObjectAtIndex:3 withObject:@(_isflag)];
    _isflag = NO;   [[_pushedFlag objectAtIndex:3] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = YES;  [[_pushedFlag objectAtIndex:3] replaceObjectAtIndex:2 withObject:@(_isflag)];
    _isflag = YES;  [[_pushedFlag objectAtIndex:2] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = NO;   [[_pushedFlag objectAtIndex:1] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = YES;  [[_pushedFlag objectAtIndex:1] replaceObjectAtIndex:1 withObject:@(_isflag)];
    _isflag = YES;  [[_pushedFlag objectAtIndex:0] replaceObjectAtIndex:0 withObject:@(_isflag)];
    //truePosition[1] = 1; truePosition[3] = 2; truePosition[4] = 3;
    [_truePosition replaceObjectAtIndex:1 withObject:@(1)];
    [_truePosition replaceObjectAtIndex:3 withObject:@(2)];
    [_truePosition replaceObjectAtIndex:4 withObject:@(3)];
}
- (void)DandCloseGuitarContent:(GuitarContentViewController *)controller{
    [self closeGuitarContent:controller];

    [self initializer];
    
    UIImageView *ImageViewAtGuitar = [[_codeImageView objectAtIndex:2] objectAtIndex:1];
    ImageViewAtGuitar.image = [UIImage imageNamed:@"pushed_guitarstring.png"];
    UIImageView *ImageViewAtGuitar2 = [[_codeImageView objectAtIndex:1] objectAtIndex:2];
    ImageViewAtGuitar2.image = [UIImage imageNamed:@"pushed_guitarstring.png"];
    UIImageView *ImageViewAtGuitar3 = [[_codeImageView objectAtIndex:0] objectAtIndex:1];
    ImageViewAtGuitar3.image = [UIImage imageNamed:@"pushed_guitarstring.png"];

    _isflag = YES;  [[_pushedFlag objectAtIndex:3] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = NO;   [[_pushedFlag objectAtIndex:2] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = YES;  [[_pushedFlag objectAtIndex:2] replaceObjectAtIndex:2 withObject:@(_isflag)];
    _isflag = NO;   [[_pushedFlag objectAtIndex:1] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = YES;  [[_pushedFlag objectAtIndex:1] replaceObjectAtIndex:3 withObject:@(_isflag)];
    _isflag = NO;   [[_pushedFlag objectAtIndex:1] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = YES;  [[_pushedFlag objectAtIndex:0] replaceObjectAtIndex:2  withObject:@(_isflag)];

    [_truePosition replaceObjectAtIndex:0 withObject:@(2)];
    [_truePosition replaceObjectAtIndex:1 withObject:@(3)];
    [_truePosition replaceObjectAtIndex:2 withObject:@(2)];

}

- (void)EandCloseGuitarContent:(GuitarContentViewController *)controller{
    [self closeGuitarContent:controller];
    [self initializer];

    UIImageView *ImageViewAtGuitar = [[_codeImageView objectAtIndex:4] objectAtIndex:1];
    ImageViewAtGuitar.image = [UIImage imageNamed:@"pushed_guitarstring.png"];
    UIImageView *ImageViewAtGuitar2 = [[_codeImageView objectAtIndex:3] objectAtIndex:1];
    ImageViewAtGuitar2.image = [UIImage imageNamed:@"pushed_guitarstring.png"];
    UIImageView *ImageViewAtGuitar3 = [[_codeImageView objectAtIndex:2] objectAtIndex:0];
    ImageViewAtGuitar3.image = [UIImage imageNamed:@"pushed_guitarstring.png"];
    
    _isflag = YES;  [[_pushedFlag objectAtIndex:5] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = NO;   [[_pushedFlag objectAtIndex:4] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = YES;  [[_pushedFlag objectAtIndex:4] replaceObjectAtIndex:2 withObject:@(_isflag)];
    _isflag = NO;   [[_pushedFlag objectAtIndex:3] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = YES;  [[_pushedFlag objectAtIndex:3] replaceObjectAtIndex:2 withObject:@(_isflag)];
    _isflag = NO;   [[_pushedFlag objectAtIndex:2] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = YES;  [[_pushedFlag objectAtIndex:2] replaceObjectAtIndex:1  withObject:@(_isflag)];
    _isflag = YES;  [[_pushedFlag objectAtIndex:1] replaceObjectAtIndex:0  withObject:@(_isflag)];
    _isflag = YES;  [[_pushedFlag objectAtIndex:0] replaceObjectAtIndex:0  withObject:@(_isflag)];

    [_truePosition replaceObjectAtIndex:2 withObject:@(1)];
    [_truePosition replaceObjectAtIndex:3 withObject:@(2)];
    [_truePosition replaceObjectAtIndex:4 withObject:@(2)];

}

- (void)FandCloseGuitarContent:(GuitarContentViewController *)controller{
    [self closeGuitarContent:controller];
    [self initializer];
    
    UIImageView *ImageViewAtGuitar = [[_codeImageView objectAtIndex:5] objectAtIndex:0];
    ImageViewAtGuitar.image = [UIImage imageNamed:@"pushed_guitarstring.png"];
    UIImageView *ImageViewAtGuitar2 = [[_codeImageView objectAtIndex:4] objectAtIndex:2];
    ImageViewAtGuitar2.image = [UIImage imageNamed:@"pushed_guitarstring.png"];
    UIImageView *ImageViewAtGuitar3 = [[_codeImageView objectAtIndex:3] objectAtIndex:2];
    ImageViewAtGuitar3.image = [UIImage imageNamed:@"pushed_guitarstring.png"];
    UIImageView *ImageViewAtGuitar4 = [[_codeImageView objectAtIndex:2] objectAtIndex:1];
    ImageViewAtGuitar4.image = [UIImage imageNamed:@"pushed_guitarstring.png"];
    UIImageView *ImageViewAtGuitar5 = [[_codeImageView objectAtIndex:1] objectAtIndex:0];
    ImageViewAtGuitar5.image = [UIImage imageNamed:@"pushed_guitarstring.png"];
    UIImageView *ImageViewAtGuitar6 = [[_codeImageView objectAtIndex:0] objectAtIndex:0];
    ImageViewAtGuitar6.image = [UIImage imageNamed:@"pushed_guitarstring.png"];
    
    _isflag = NO;  [[_pushedFlag objectAtIndex:5] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = NO;  [[_pushedFlag objectAtIndex:4] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = NO;  [[_pushedFlag objectAtIndex:3] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = NO;  [[_pushedFlag objectAtIndex:2] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = NO;  [[_pushedFlag objectAtIndex:1] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = NO;  [[_pushedFlag objectAtIndex:0] replaceObjectAtIndex:0 withObject:@(_isflag)];
    
    _isflag = YES;   [[_pushedFlag objectAtIndex:5] replaceObjectAtIndex:1 withObject:@(_isflag)];
    _isflag = YES;  [[_pushedFlag objectAtIndex:4] replaceObjectAtIndex:3 withObject:@(_isflag)];
    _isflag = YES;   [[_pushedFlag objectAtIndex:3] replaceObjectAtIndex:3 withObject:@(_isflag)];
    _isflag = YES;  [[_pushedFlag objectAtIndex:2] replaceObjectAtIndex:2 withObject:@(_isflag)];
    _isflag = YES;   [[_pushedFlag objectAtIndex:1] replaceObjectAtIndex:1 withObject:@(_isflag)];
    _isflag = YES;  [[_pushedFlag objectAtIndex:0] replaceObjectAtIndex:1  withObject:@(_isflag)];
 
    [_truePosition replaceObjectAtIndex:0 withObject:@(1)];
    [_truePosition replaceObjectAtIndex:1 withObject:@(1)];
    [_truePosition replaceObjectAtIndex:2 withObject:@(2)];
    [_truePosition replaceObjectAtIndex:3 withObject:@(3)];
    [_truePosition replaceObjectAtIndex:4 withObject:@(3)];
    [_truePosition replaceObjectAtIndex:5 withObject:@(1)];

}

- (void)GandCloseGuitarContent:(GuitarContentViewController *)controller{
    [self closeGuitarContent:controller];
    [self initializer];
    
    UIImageView *ImageViewAtGuitar = [[_codeImageView objectAtIndex:5] objectAtIndex:2];
    ImageViewAtGuitar.image = [UIImage imageNamed:@"pushed_guitarstring.png"];
    UIImageView *ImageViewAtGuitar2 = [[_codeImageView objectAtIndex:4] objectAtIndex:1];
    ImageViewAtGuitar2.image = [UIImage imageNamed:@"pushed_guitarstring.png"];
    UIImageView *ImageViewAtGuitar3 = [[_codeImageView objectAtIndex:0] objectAtIndex:2];
    ImageViewAtGuitar3.image = [UIImage imageNamed:@"pushed_guitarstring.png"];
    
    _isflag = NO;  [[_pushedFlag objectAtIndex:5] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = NO;  [[_pushedFlag objectAtIndex:4] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = NO;  [[_pushedFlag objectAtIndex:0] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = YES;  [[_pushedFlag objectAtIndex:5] replaceObjectAtIndex:3 withObject:@(_isflag)];
    _isflag = YES;   [[_pushedFlag objectAtIndex:4] replaceObjectAtIndex:2 withObject:@(_isflag)];
    _isflag = YES;  [[_pushedFlag objectAtIndex:3] replaceObjectAtIndex:0  withObject:@(_isflag)];
    _isflag = YES;   [[_pushedFlag objectAtIndex:2] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = YES;   [[_pushedFlag objectAtIndex:1] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = YES;  [[_pushedFlag objectAtIndex:0] replaceObjectAtIndex:3  withObject:@(_isflag)];

    [_truePosition replaceObjectAtIndex:0 withObject:@(3)];
    [_truePosition replaceObjectAtIndex:4 withObject:@(2)];
    [_truePosition replaceObjectAtIndex:5 withObject:@(3)];

}
- (void)AandCloseGuitarContent:(GuitarContentViewController *)controller{
    [self closeGuitarContent:controller];
    [self initializer];
    
    UIImageView *ImageViewAtGuitar = [[_codeImageView objectAtIndex:3] objectAtIndex:1];
    ImageViewAtGuitar.image = [UIImage imageNamed:@"pushed_guitarstring.png"];
    UIImageView *ImageViewAtGuitar2 = [[_codeImageView objectAtIndex:2] objectAtIndex:1];
    ImageViewAtGuitar2.image = [UIImage imageNamed:@"pushed_guitarstring.png"];
    UIImageView *ImageViewAtGuitar3 = [[_codeImageView objectAtIndex:1] objectAtIndex:1];
    ImageViewAtGuitar3.image = [UIImage imageNamed:@"pushed_guitarstring.png"];
    
    _isflag = NO;  [[_pushedFlag objectAtIndex:3] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = NO;  [[_pushedFlag objectAtIndex:2] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = NO;  [[_pushedFlag objectAtIndex:1] replaceObjectAtIndex:0 withObject:@(_isflag)];

    _isflag = YES;  [[_pushedFlag objectAtIndex:4] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = YES;   [[_pushedFlag objectAtIndex:3] replaceObjectAtIndex:2 withObject:@(_isflag)];
    _isflag = YES;  [[_pushedFlag objectAtIndex:2] replaceObjectAtIndex:2  withObject:@(_isflag)];
    _isflag = YES;   [[_pushedFlag objectAtIndex:1] replaceObjectAtIndex:2 withObject:@(_isflag)];
    _isflag = YES;   [[_pushedFlag objectAtIndex:0] replaceObjectAtIndex:0 withObject:@(_isflag)];

    [_truePosition replaceObjectAtIndex:1 withObject:@(2)];
    [_truePosition replaceObjectAtIndex:2 withObject:@(2)];
    [_truePosition replaceObjectAtIndex:3 withObject:@(2)];

}
- (void)BandCloseGuitarContent:(GuitarContentViewController *)controller{
    [self closeGuitarContent:controller];
    [self initializer];
    
    UIImageView *ImageViewAtGuitar = [[_codeImageView objectAtIndex:4] objectAtIndex:1];
    ImageViewAtGuitar.image = [UIImage imageNamed:@"pushed_guitarstring.png"];
    UIImageView *ImageViewAtGuitar2 = [[_codeImageView objectAtIndex:3] objectAtIndex:3];
    ImageViewAtGuitar2.image = [UIImage imageNamed:@"pushed_guitarstring.png"];
    UIImageView *ImageViewAtGuitar3 = [[_codeImageView objectAtIndex:2] objectAtIndex:3];
    ImageViewAtGuitar3.image = [UIImage imageNamed:@"pushed_guitarstring.png"];
    UIImageView *ImageViewAtGuitar4 = [[_codeImageView objectAtIndex:1] objectAtIndex:3];
    ImageViewAtGuitar4.image = [UIImage imageNamed:@"pushed_guitarstring.png"];
    UIImageView *ImageViewAtGuitar5 = [[_codeImageView objectAtIndex:0] objectAtIndex:1];
    ImageViewAtGuitar5.image = [UIImage imageNamed:@"pushed_guitarstring.png"];
    
    _isflag = NO;  [[_pushedFlag objectAtIndex:4] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = NO;  [[_pushedFlag objectAtIndex:3] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = NO;  [[_pushedFlag objectAtIndex:2] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = NO;  [[_pushedFlag objectAtIndex:1] replaceObjectAtIndex:0 withObject:@(_isflag)];
    _isflag = NO;  [[_pushedFlag objectAtIndex:0] replaceObjectAtIndex:0 withObject:@(_isflag)];
    
    _isflag = YES;   [[_pushedFlag objectAtIndex:4] replaceObjectAtIndex:2 withObject:@(_isflag)];
    _isflag = YES;  [[_pushedFlag objectAtIndex:3] replaceObjectAtIndex:4 withObject:@(_isflag)];
    _isflag = YES;   [[_pushedFlag objectAtIndex:2] replaceObjectAtIndex:4 withObject:@(_isflag)];
    _isflag = YES;  [[_pushedFlag objectAtIndex:1] replaceObjectAtIndex:4 withObject:@(_isflag)];
    _isflag = YES;   [[_pushedFlag objectAtIndex:0] replaceObjectAtIndex:2 withObject:@(_isflag)];
    
    [_truePosition replaceObjectAtIndex:0 withObject:@(2)];
    [_truePosition replaceObjectAtIndex:1 withObject:@(4)];
    [_truePosition replaceObjectAtIndex:2 withObject:@(4)];
    [_truePosition replaceObjectAtIndex:3 withObject:@(4)];
    [_truePosition replaceObjectAtIndex:4 withObject:@(2)];

}

- (void) pushedCloseGuitarContent:(GuitarContentViewController *)controller{
    [self closeGuitarContent:controller];

}

//- (void) viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
//}


-(void)hoge:(UIBarButtonItem*)b{
//    NSLog(@"ボタンを押されましたね");
}

- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    //-- モーションがシェイクのときに実行
    if (motion == UIEventSubtypeMotionShake){
        for (int i = (integer_t)[_codeId count] - 1; i >= 0; i--){
            [self soundPlayer:_pushedFlag :i :1];
        }
    }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    switch (touch.view.tag) {
        case 0: return;
        case 1:case 2:case 3:case 4:case 5:case 6:
            _stringNum = (int)touch.view.tag - 1;
            [self soundPlayer:_pushedFlag :(int)touch.view.tag - 1 :0];
            break;
        default:    [self pushedString:touch.view.tag]; break;
    }
}

- (void) view_SwipeLeft:(UISwipeGestureRecognizer *)sender {
}




- (void) soundPlayer:(NSMutableArray *)pushedFlag :(NSInteger)String :(NSInteger)soundFlag {
    if (soundFlag == 0 || soundFlag == 1 || soundFlag == 2){
        for (int i = (int)[[_pushedFlag objectAtIndex:0] count] - 1; i >= 0; i--){
            if ([[[_pushedFlag objectAtIndex:String] objectAtIndex:i] isEqual:@YES]){
                [[SEManager sharedManager] playSound:[[_soundArray objectAtIndex:String] objectAtIndex:i]];
                if (soundFlag == 1) [NSThread sleepForTimeInterval:0.05f];
                return;
            }
        }
    }
}

- (void) pushedString:(NSInteger) tag {
    int i = 0, j = 0;
    NSMutableArray *dummyArrayAtPushString;
    dummyArrayAtPushString = [[NSMutableArray alloc] init];
    switch (tag) {
            //-- １弦全部の処理
        case 11:i = 0;j = 0;break;  case 12:i = 0;j = 1;break;  case 13:i = 0;j = 2;break;
        case 14:i = 0;j = 3;break;  case 15:i = 0;j = 4;break;  case 16:i = 0;j = 5;break;
            
            //-- ２弦全部の処理
        case 21:i = 1;j = 0;break;  case 22:i = 1;j = 1;break;  case 23:i = 1;j = 2;break;
        case 24:i = 1;j = 3;break;  case 25:i = 1;j = 4;break;  case 26:i = 1;j = 5;break;
            
            //-- ３弦全部の処理
        case 31:i = 2;j = 0;break;  case 32:i = 2;j = 1;break;  case 33:i = 2;j = 2;break;
        case 34:i = 2;j = 3;break;  case 35:i = 2;j = 4;break;  case 36:i = 2;j = 5;break;
            
            //-- ４弦全部の処理
        case 41:i = 3;j = 0;break;  case 42:i = 3;j = 1;break;  case 43:i = 3;j = 2;break;
        case 44:i = 3;j = 3;break;  case 45:i = 3;j = 4;break;  case 46:i = 3;j = 5;break;
            
            //-- ５弦全部の処理
        case 51:i = 4;j = 0;break;  case 52:i = 4;j = 1;break;  case 53:i = 4;j = 2;break;
        case 54:i = 4;j = 3;break;  case 55:i = 4;j = 4;break;  case 56:i = 4;j = 5;break;
            
            //-- ６弦全部の処理
        case 61:i = 5;j = 0;break;  case 62:i = 5;j = 1;break;  case 63:i = 5;j = 2;break;
        case 64:i = 5;j = 3;break;  case 65:i = 5;j = 4;break;  case 66:i = 5;j = 5;break;
            
        default:
            break;
    }
    dummyArrayAtPushString = [_codeImageView objectAtIndex:i];
    UIImageView *ImageViewAtGuitar = [dummyArrayAtPushString objectAtIndex:j];
    if ([_pushedFlag[i][j + 1] isEqual:@YES]){
        ImageViewAtGuitar.image = [UIImage imageNamed:@"normal_guitarstring.png"];
        _isflag = NO;
        [[_pushedFlag objectAtIndex:i] replaceObjectAtIndex:j + 1 withObject:@(_isflag)];
        [_truePosition replaceObjectAtIndex:i withObject:@(0)];
        _isflag = YES;
        [[_pushedFlag objectAtIndex:i] replaceObjectAtIndex:[[_truePosition objectAtIndex:i] intValue] withObject:@(_isflag)];
        return;
    }
    ImageViewAtGuitar.image = [UIImage imageNamed:@"pushed_guitarstring.png"];
    for (int k = 1; k <= [[_codeId objectAtIndex:0] count]; k++){
        // 押す弦の場所を変えたかったら
        if ([_pushedFlag[i][k] isEqual:@YES]){
            //CodeImageView[i][k - 1].setImageResource(R.drawable.normal_guitarstring);
            ImageViewAtGuitar = [dummyArrayAtPushString objectAtIndex:k - 1];
            ImageViewAtGuitar.image = [UIImage imageNamed:@"normal_guitarstring.png"];
        }
    }
    _isflag = NO;
    [[_pushedFlag objectAtIndex:i] replaceObjectAtIndex:[[_truePosition objectAtIndex:i] intValue] withObject:@(_isflag)];
    [_truePosition replaceObjectAtIndex:i withObject:@(j + 1)];
    _isflag = YES;
    [[_pushedFlag objectAtIndex:i] replaceObjectAtIndex:j + 1 withObject:@(_isflag)];
//    codeChecker();
    return;
    

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
