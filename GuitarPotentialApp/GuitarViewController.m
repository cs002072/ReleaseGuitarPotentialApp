//
//  GuitarViewController.m
//  GuitarPotentialApp
//
//  Created by 岡 慎一郎 on 2015/03/01.
//  Copyright (c) 2015年 oka.shinichiro. All rights reserved.
//

#import "GuitarViewController.h"
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
    AVAudioPlayer *_audio;

    BOOL _isflag;
    int _stringNum;
//    _songList = @[@"涙のキッス", @"いとしのエリー"];
}

@end

@implementation GuitarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _stringNum = 9;
    _pushedFlag = [[NSMutableArray alloc] init];
    _dummyArray = [[NSMutableArray alloc] init];
    _codeImageView = [[NSArray alloc] init];
    _truePosition = [[NSMutableArray alloc] init];
    _soundArray = [[NSArray alloc] init];
    
    // Do any additional setup after loading the view.
    _codeId = @[@[@"11", @"21", @"31", @"41", @"51", @"61"],
                @[@"12", @"22", @"32", @"42", @"52", @"62"],
                @[@"13", @"23", @"33", @"43", @"53", @"63"],
                @[@"14", @"24", @"34", @"44", @"54", @"64"],
                @[@"15", @"25", @"35", @"45", @"55", @"65"],
                @[@"16", @"26", @"36", @"46", @"56", @"66"]];
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
                    @[@"sound06.wav", @"sound16.wav", @"sound26.wav", @"sound36.wav", @"sound46.wav", @"sound56.wav", @"sound66"]];
    
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
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    switch (touch.view.tag) {
        case 0: return;
        case 1: _stringNum = 0; [self soundPlayer:_pushedFlag :0 :0];   break;
        case 2: _stringNum = 1; [self soundPlayer:_pushedFlag :1 :0];   break;
        case 3: _stringNum = 2; [self soundPlayer:_pushedFlag :2 :0];   break;
        case 4: _stringNum = 3; [self soundPlayer:_pushedFlag :3 :0];   break;
        case 5: _stringNum = 4; [self soundPlayer:_pushedFlag :4 :0];   break;
        case 6: _stringNum = 5; [self soundPlayer:_pushedFlag :5 :0];   break;
            
        default:
            [self pushedString:touch.view.tag];
            break;
    }
}

- (void) soundPlayer:(NSMutableArray *)pushedFlag :(NSInteger)String :(NSInteger)soundFlag {
    if (soundFlag == 0 || soundFlag == 1 || soundFlag == 2){
        for (int i = (int)[[_pushedFlag objectAtIndex:0] count] - 1; i >= 0; i--){
            if ([[[_pushedFlag objectAtIndex:String] objectAtIndex:i] isEqual:@YES]){
                NSString *path = [[NSBundle mainBundle] pathForResource:[[_soundArray objectAtIndex:String] objectAtIndex:i] ofType:@"wav"];
                NSURL *url = [NSURL fileURLWithPath:path];
                _audio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
//                _audio.currentTime = 0;
//                [_audio play];
                [[SEManager sharedManager] playSound:[[_soundArray objectAtIndex:String] objectAtIndex:i]];
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
