//
//  detailViewController.m
//  GuitarPotentialApp
//
//  Created by 岡 慎一郎 on 2015/02/23.
//  Copyright (c) 2015年 oka.shinichiro. All rights reserved.
//

#import "detailViewController.h"
#import "AppDelegate.h"

@interface detailViewController () {
    NSMutableArray *_songHistoryArray;
    NSArray *_AllSongsArrayAtDetail;
    NSArray *_codeCircleArray;
    NSInteger *_songHistoryArrayNum;
    NSMutableArray *_codeArray;
    NSMutableArray *_newCodeArray;
    NSString *_previousKey, *_strKey, *_strCapo;
    NSString *_previousCapo;
    int _codeNum;
    //    BOOL boolNum = NO;
}
@end

@implementation detailViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _songHistoryArray = [[NSMutableArray alloc] init];
    _codeArray = [[NSMutableArray alloc] init];
    _AllSongsArrayAtDetail = [[NSArray alloc] init];
    _codeCircleArray = [[NSArray alloc] init];
    _newCodeArray = [[NSMutableArray alloc] init];
    
    _codeCircleArray = @[@"C", @"C#", @"D", @"E♭", @"E", @"F", @"F#", @"G", @"G#", @"A", @"B♭", @"B"];
    //プロジェクト内のファイルにアクセスできるオブジェクトを作成
    NSBundle *bundle = [NSBundle mainBundle];
    //読み込むプロパティリストのファイルパス（場所）を指定
    NSString *path = [bundle pathForResource:@"AllSongsList" ofType:@"plist"];
    //プロパティリストの中身のデータを取得
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    _AllSongsArrayAtDetail = [dic objectForKey:@"AllSongsList"];
    
    _previousKey = @"0";
    _previousCapo = @"0";
    _strKey = @"0";
    _strCapo = @"0";
    _codeNum = -1;
    /***********************************************/
    /**********テキストファイル読み込みフェーズ***********/
    /***********************************************/
    NSError *error = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:_AllSongsArrayAtDetail[self.number][@"TITLE"] ofType:@"txt"];
    self.SongWordStr.text = [NSString stringWithContentsOfFile:filePath encoding:NSShiftJISStringEncoding error:&error];
    /***********************************************/
    /**********テキストファイル読み込みフェーズ***********/
    /***********************************************/



    /***********************************************/
    /**********テキスト分解フェーズ***********/
    /***********************************************/
    NSArray *array = [self.SongWordStr.text componentsSeparatedByString:@"\n"];
    for (NSString *component in array) {
        NSArray *array2 = [component componentsSeparatedByString:@" "];
        for (NSString *component2 in array2) {
            NSArray *array3 = [component2 componentsSeparatedByString:@"　"];
            for (NSString *component3 in array3) {
                NSRange r = NSMakeRange(0, 1);
                NSComparisonResult cmpA = [component3 compare:@"A" options:NSCaseInsensitiveSearch range:r];
                NSComparisonResult cmpZ = [component3 compare:@"Z" options:NSCaseInsensitiveSearch range:r];
                if(cmpA >= 0 && cmpZ <= 0){
                    [_codeArray addObject:component3];
//                    NSLog(@"%@", component3);
                }
            }
        }
    }
    /***********************************************/
    /**********テキスト分解フェーズ***********/
    /***********************************************/
}

- (IBAction)openPickerView:(id)sender {
    //-- pickerViewControllerのインスタンスをstoryboradから取得
    self.pickerViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"PickerViewController"];
    self.pickerViewController.delegate  = self;
    
    //-- PickerViewをサブビューとして表示する
    //-- 表示するときはアニメーションをつけて下から上にゆっくり表示させる
    //-- アニメーション完了時のPickerViewの位置を計算
    UIView *pickerView = self.pickerViewController.view;
    CGPoint middleCenter = pickerView.center;
    
    //-- アニメーション開始時のPickerViewの位置を計算
    UIWindow *mainWindow = (((AppDelegate *) [UIApplication sharedApplication].delegate).window);
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    CGPoint offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
    pickerView.center = offScreenCenter;
    
    [mainWindow addSubview:pickerView];
    
    //-- アニメーションを使ってPickerViewをアニメーション完了時の位置に表示されるようにする
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    pickerView.center = middleCenter;
    [UIView commitAnimations];
}

// PickerViewのある行が選択されたときに呼び出されるPickerViewControllerDelegateプロトコルのデリゲートメソッド
- (void)applySelectedKey:(NSString *)str
{
    _strKey = str;
}
- (void)applySelectedCapo:(NSString *)str
{
    _strCapo = str;
}
/**************************/
/************nowKeyに新たな数字を入れる前に，nowKeyの値をpreviousKeyに入れる．その後，nowKeyに新たな値を入れる**************/
/**************************/
/**************************/
/**************************/


// PickerViewController上にある透明ボタンがタップされたときに呼び出されるPickerViewControllerDelegateプロトコルのデリゲートメソッド
- (void)closePickerView:(PickerViewController *)controller
{

    if (_newCodeArray.count > 0){
        _codeArray = _newCodeArray;
        _newCodeArray = [[NSMutableArray alloc] init];
    }
    // PickerViewをアニメーションを使ってゆっくり非表示にする
    UIView *pickerView = controller.view;
    
    // アニメーション完了時のPickerViewの位置を計算
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    CGPoint offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
    
    [UIView beginAnimations:nil context:(void *)pickerView];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    // アニメーション終了時に呼び出す処理を設定
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    pickerView.center = offScreenCenter;
    [UIView commitAnimations];

    /***************************************************/
    /******************キーとカポの再描画******************/
    /***************************************************/
    _previousKey = self.selectedKey.text;
    self.selectedKey.text = _strKey;
    _previousCapo = self.selectedCapo.text;
    self.selectedCapo.text = _strCapo;
    /***************************************************/
    /******************キーとカポの再描画******************/
    /***************************************************/
    
    /***************************************************/
    /******************ギターコードの抽出******************/
    /***************************************************/
    for (NSString *codeStr in _codeArray) {

        NSLog(@"nodeStr = %@", codeStr);
        NSString *textRange_0, *textRange_1;
        NSArray *codeSeparate;
        int previousKey, nowKey, numUpDowKey, trueUpDown;
        if (codeStr.length <= 4){
            textRange_1 = [codeStr substringWithRange:NSMakeRange(0, 1)];
        }
        else {
            textRange_0 = [codeStr substringWithRange:NSMakeRange(0, 4)];
            if ([textRange_0 isEqualToString:@"Capo"] || [textRange_0 isEqualToString:@"Baby"])  continue;
            textRange_1 = [codeStr substringWithRange:NSMakeRange(0, 1)];
        }
        
        
        previousKey = [_previousKey intValue];
        nowKey = [self.selectedKey.text intValue];
        numUpDowKey = nowKey - previousKey;
        
//_codeCircleArray = @[@"C", @"C#", @"D", @"E♭", @"E", @"F", @"F#", @"G", @"G#", @"A", @"B♭", @"B"];
        if ([textRange_1 isEqualToString:@"C"]){
            codeSeparate = [codeStr componentsSeparatedByString:@"C"];

            if (numUpDowKey < 0){
                _codeNum = (int)_codeCircleArray.count;
            } else {
                _codeNum = 0;
            }
            [_newCodeArray addObject:[[_codeCircleArray objectAtIndex:_codeNum + numUpDowKey] stringByAppendingString:[codeSeparate objectAtIndex:1]]];
            
        } else if ([textRange_1 isEqualToString:@"D"]){
            codeSeparate = [codeStr componentsSeparatedByString:@"D"];
            _codeNum = 2;
            if (_codeNum + numUpDowKey < 0){
                [_newCodeArray addObject:[[_codeCircleArray objectAtIndex:_codeCircleArray.count + _codeNum + numUpDowKey] stringByAppendingString:[codeSeparate objectAtIndex:1]]];
            } else {
                [_newCodeArray addObject:[[_codeCircleArray objectAtIndex:_codeNum + numUpDowKey] stringByAppendingString:[codeSeparate objectAtIndex:1]]];
            }
        } else if ([textRange_1 isEqualToString:@"E"]){
            codeSeparate = [codeStr componentsSeparatedByString:@"E"];
            _codeNum = 4;
            if (_codeNum + numUpDowKey < 0){
                [_newCodeArray addObject:[[_codeCircleArray objectAtIndex:_codeCircleArray.count + _codeNum + numUpDowKey] stringByAppendingString:[codeSeparate objectAtIndex:1]]];
            } else {
                [_newCodeArray addObject:[[_codeCircleArray objectAtIndex:_codeNum + numUpDowKey] stringByAppendingString:[codeSeparate objectAtIndex:1]]];
            }
        } else if ([textRange_1 isEqualToString:@"F"]){
            codeSeparate = [codeStr componentsSeparatedByString:@"F"];
//_codeCircleArray = @[@"C", @"C#", @"D", @"E♭", @"E", @"F", @"F#", @"G", @"G#", @"A", @"B♭", @"B"];
            _codeNum = 5;
            trueUpDown = (int)_codeCircleArray.count - (int)_codeNum - 1;
            if (_codeNum + numUpDowKey < 0){
                /*配列の値が負になったとき*/
                [_newCodeArray addObject:[[_codeCircleArray objectAtIndex:_codeCircleArray.count + _codeNum + numUpDowKey] stringByAppendingString:[codeSeparate objectAtIndex:1]]];
            } else if (_codeNum + numUpDowKey >= _codeCircleArray.count){
                /*配列の値が正になったとき*/
                _codeNum = -1;
                [_newCodeArray addObject:[[_codeCircleArray objectAtIndex:_codeNum + numUpDowKey - trueUpDown] stringByAppendingString:[codeSeparate objectAtIndex:1]]];
            } else {
                [_newCodeArray addObject:[[_codeCircleArray objectAtIndex:_codeNum + numUpDowKey] stringByAppendingString:[codeSeparate objectAtIndex:1]]];
            }
        } else if ([textRange_1 isEqualToString:@"G"]){
            codeSeparate = [codeStr componentsSeparatedByString:@"G"];
//_codeCircleArray = @[@"C", @"C#", @"D", @"E♭", @"E", @"F", @"F#", @"G", @"G#", @"A", @"B♭", @"B"];
            _codeNum = 7;
            trueUpDown = (int)_codeCircleArray.count - (int)_codeNum - 1;
            if (_codeNum + numUpDowKey >= _codeCircleArray.count){
                /*配列の値が正になったとき*/
                _codeNum = -1;
                [_newCodeArray addObject:[[_codeCircleArray objectAtIndex:_codeNum + numUpDowKey - trueUpDown] stringByAppendingString:[codeSeparate objectAtIndex:1]]];
            } else {
                [_newCodeArray addObject:[[_codeCircleArray objectAtIndex:_codeNum + numUpDowKey] stringByAppendingString:[codeSeparate objectAtIndex:1]]];
            }
        } else if ([textRange_1 isEqualToString:@"A"]){
            codeSeparate = [codeStr componentsSeparatedByString:@"A"];
            _codeNum = 9;
            trueUpDown = (int)_codeCircleArray.count - (int)_codeNum - 1;
            if (_codeNum + numUpDowKey >= _codeCircleArray.count){
                /*配列の値が正になったとき*/
                _codeNum = -1;
                [_newCodeArray addObject:[[_codeCircleArray objectAtIndex:_codeNum + numUpDowKey - trueUpDown] stringByAppendingString:[codeSeparate objectAtIndex:1]]];
            } else {
                [_newCodeArray addObject:[[_codeCircleArray objectAtIndex:_codeNum + numUpDowKey] stringByAppendingString:[codeSeparate objectAtIndex:1]]];
            }
        } else if ([textRange_1 isEqualToString:@"B"]){
            codeSeparate = [codeStr componentsSeparatedByString:@"B"];
            _codeNum = 11;
            trueUpDown = (int)_codeCircleArray.count - (int)_codeNum - 1;
            if (_codeNum + numUpDowKey >= _codeCircleArray.count){
                /*配列の値が正になったとき*/
                _codeNum = -1;
                [_newCodeArray addObject:[[_codeCircleArray objectAtIndex:_codeNum + numUpDowKey - trueUpDown] stringByAppendingString:[codeSeparate objectAtIndex:1]]];
            } else {
                [_newCodeArray addObject:[[_codeCircleArray objectAtIndex:_codeNum + numUpDowKey] stringByAppendingString:[codeSeparate objectAtIndex:1]]];
            }
        }
    }
    /***************************************************/
    /******************ギターコードの抽出******************/
    /***************************************************/

    /***************************************************/
    /******************キーの計算******************/
    /***************************************************/
//    textRange_2 = [codeStr substringWithRange:NSMakeRange(0, 1)];

//    if ()
    
    /***************************************************/
    /******************キーの計算******************/
    /***************************************************/
    
    
    
}

// 単位のPickerViewを閉じるアニメーションが終了したときに呼び出されるメソッド
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    // PickerViewをサブビューから削除
    UIView *pickerView = (__bridge UIView *)context;
    [pickerView removeFromSuperview];
}





- (IBAction)tapSaveButton:(id)sender {
    /***********************************************/
    /**********楽曲情報保存フェーズ***********/
    /***********************************************/
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _songHistoryArray = [[NSMutableArray alloc] init];
    
    BOOL boolFlag = [defaults boolForKey:@"BOOL"];
    if (boolFlag == YES){
        _songHistoryArray = [[defaults arrayForKey:@"HistorySONGS"] mutableCopy];
    }
    [defaults setBool:YES forKey:@"BOOL"];
    [defaults synchronize];
    //-- ディクショナリに保存
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:_AllSongsArrayAtDetail[self.number][@"NO"] forKey:@"NO"];
    [dictionary setObject:_AllSongsArrayAtDetail[self.number][@"TITLE"] forKey:@"TITLE"];
    [dictionary setObject:_AllSongsArrayAtDetail[self.number][@"ARTIST"] forKey:@"ARTIST"];

    //-- NSMutableArrayにディクショナリを追加
    [_songHistoryArray addObject:dictionary];
    //-- ユーザデフォルトにNSMutableArrayを追加r
    [defaults setObject:_songHistoryArray forKey:@"HistorySONGS"];
    [defaults synchronize];

    /***********************************************/
    /**********楽曲情報保存フェーズ***********/
    /***********************************************/
    
//        UITabBarController *tab = (UITabBarController *)[self presentingViewController];
//        [tab setSelectedIndex:2];

    
    
//    UINavigationController *navi = (UINavigationController *)[self presentingViewController];
//    UITabBarController *tab = (UITabBarController *)[navi tabBarController];
//    [tab setSelectedIndex:2];
//    [[[self navigationController] tabBarController] setSelectedIndex:2];
    
//    UITabBarController *tab = (UITabBarController *)[self parentViewController];
//    [tab setSelectedIndex:2];

//    NSLog(@"Beforecount = %d", [self.navigationController.viewControllers count]);
//    self.tabBarController.selectedIndex = 2;
//    NSLog(@"Aftercount = %d", [self.navigationController.viewControllers count]);
//

    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"履歴に追加しました！"
                          message:@""
                          delegate:self
                          cancelButtonTitle:@"キャンセル！"
                          otherButtonTitles:@"OK！", nil];
    // アラートビューを表示
    [alert show];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 * アラートのボタンが押されたとき
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    

}

- (IBAction)tapCancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
