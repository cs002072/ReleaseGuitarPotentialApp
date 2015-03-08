//
//  detailViewController.m
//  GuitarPotentialApp
//
//  Created by 岡 慎一郎 on 2015/02/23.
//  Copyright (c) 2015年 oka.shinichiro. All rights reserved.
//

#import "detailViewController.h"

@interface detailViewController () {
    NSMutableArray *_songHistoryArray;
    NSArray *_AllSongsArrayAtDetail;
    NSInteger *_songHistoryArrayNum;
//    BOOL boolNum = NO;
}
@end

@implementation detailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _songHistoryArray = [[NSMutableArray alloc] init];
    _AllSongsArrayAtDetail = [[NSArray alloc] init];
    
    //プロジェクト内のファイルにアクセスできるオブジェクトを作成
    NSBundle *bundle = [NSBundle mainBundle];
    //読み込むプロパティリストのファイルパス（場所）を指定
    NSString *path = [bundle pathForResource:@"AllSongsList" ofType:@"plist"];
    //プロパティリストの中身のデータを取得
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    _AllSongsArrayAtDetail = [dic objectForKey:@"AllSongsList"];
    
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
        NSLog(@"%@", component);
//        NSArray *array2 = [component componentsSeparatedByString:@"　"];
//        for (NSString *component2 in array2) {
//            NSLog(@"%@", component2);
//        }
    }
    /***********************************************/
    /**********テキスト分解フェーズ***********/
    /***********************************************/
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
