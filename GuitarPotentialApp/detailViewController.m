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
    NSString *_previousKey, *_strKey, *_strCapo;
    NSString *_previousCapo;
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
    
    _codeCircleArray = @[@"C", @"C#/D♭", @"D", @"D#/E♭", @"E", @"F", @"F#/G♭", @"G", @"G#/A♭", @"A", @"A#/B♭", @"B"];
    //プロジェクト内のファイルにアクセスできるオブジェクトを作成
    NSBundle *bundle = [NSBundle mainBundle];
    //読み込むプロパティリストのファイルパス（場所）を指定
    NSString *path = [bundle pathForResource:@"AllSongsList" ofType:@"plist"];
    //プロパティリストの中身のデータを取得
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    _AllSongsArrayAtDetail = [dic objectForKey:@"AllSongsList"];
    
    _previousKey = @"+-0";
    _previousCapo = @"0";
    _strKey = @"+-0";
    _strCapo = @"0";
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
                    NSLog(@"%@", component3);
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
    /***************************************************/
    /******************キーとカポの再描画******************/
    /***************************************************/
    _previousKey = self.selectedKey.text;
    self.selectedKey.text = _strKey;
    NSLog(@"_previousKey = %@, selectedKey = %@", _previousKey, self.selectedKey.text);
    _previousCapo = self.selectedCapo.text;
    self.selectedCapo.text = _strCapo;
    NSLog(@"_previousCapo = %@, selectedCapo = %@", _previousCapo, self.selectedCapo.text);
    /***************************************************/
    /******************キーとカポの再描画******************/
    /***************************************************/
    
    /***************************************************/
    /******************キーの計算******************/
    /***************************************************/
    for (NSString *codeStr in _codeArray) {
        //if ()
    }
    
    /***************************************************/
    /******************キーの計算******************/
    /***************************************************/
    
    
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
    UITabBarController *tab = (UITabBarController *)[self presentingViewController];
    [tab setSelectedIndex:2];
    [self dismissViewControllerAnimated:YES completion:nil];
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
