//
//  detailViewController.m
//  GuitarPotentialApp
//
//  Created by 岡 慎一郎 on 2015/02/23.
//  Copyright (c) 2015年 oka.shinichiro. All rights reserved.
//

#import "detailViewController.h"

@interface detailViewController () {
    NSString *_title, *_artist, *_key;
    NSInteger *_capo;
    NSMutableArray *_songHistoryArray;
    NSArray *_AllSongsArray;
}
@end

@implementation detailViewController
//@synthesize number;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _songHistoryArray = [[NSMutableArray alloc] init];
    //プロジェクト内のファイルにアクセスできるオブジェクトを作成
    NSBundle *bundle = [NSBundle mainBundle];
    //読み込むプロパティリストのファイルパス（場所）を指定
    NSString *path = [bundle pathForResource:@"AllSongsList" ofType:@"plist"];
    //プロパティリストの中身のデータを取得
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    _AllSongsArray = [dic objectForKey:@"AllSongsList"];

    
    /***********************************************/
    /**********テキストファイル読み込みフェーズ***********/
    /***********************************************/
    NSMutableArray *_songHistoryArray = [NSMutableArray array];
    NSError *error = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:_AllSongsArray[self.number][@"TITLE"] ofType:@"txt"];
//    _title = @"涙のキッス";
//    _artist = @"サザンオールスターズ";
//    _key = @"+-0";_capo = 3;
    self.SongWordStr.text = [NSString stringWithContentsOfFile:filePath encoding:NSShiftJISStringEncoding error:&error];
    /***********************************************/
    /**********テキストファイル読み込みフェーズ***********/
    /***********************************************/
}


- (IBAction)tapSaveButton:(id)sender {
    
    /***********************************************/
    /**********楽曲情報保存フェーズ***********/
    /***********************************************/
    //-- ディクショナリに保存
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:_AllSongsArray[self.number][@"TITLE"] forKey:@"TITLE"];
    [dictionary setObject:_AllSongsArray[self.number][@"ARTIST"] forKey:@"ARTIST"];
//    [dictionary setObject:_AllSongsArray[self.number][@"KEY"] forKey:@"KEY"];
//    [dictionary setObject:(NSString *)_capo forKey:@"CAPO"];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _songHistoryArray = [defaults arrayForKey:@"ALLSONGS"];
    //-- NSMutableArrayにディクショナリを追加
    [_songHistoryArray addObject:dictionary];

    //-- ユーザデフォルトにNSMutableArrayを追加
    [defaults setObject:_songHistoryArray forKey:@"ALLSONGS"];
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
