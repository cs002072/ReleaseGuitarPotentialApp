//
//  historyViewController.m
//  GuitarPotentialApp
//
//  Created by 岡 慎一郎 on 2015/02/24.
//  Copyright (c) 2015年 oka.shinichiro. All rights reserved.
//

#import "historyViewController.h"
#import "detailViewController.h"

@interface historyViewController () {
    NSMutableArray *_AllSongsArrayAtHistory;
    NSArray *_AllSongList;
}

@end

@implementation historyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _AllSongList = [[NSArray alloc] init];
    _AllSongList = @[@"涙のキッス", @"いとしのエリー", @"TSUNAMI", @"真夏の果実", @"波乗りジョニー", @"DIAMONDS", @"M", @"TOMORROW", @"君こそスターだ", @"月とあたしと冷蔵庫"];

    
    self.historyTableView.delegate = self;
    self.historyTableView.dataSource = self;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _historyList = [[NSMutableArray alloc] init];

    //-- １曲の情報
    _AllSongsArrayAtHistory = [[NSMutableArray alloc] init];
    _AllSongsArrayAtHistory = [[defaults arrayForKey:@"HistorySONGS"] mutableCopy];

    UINavigationController *navi = [self navigationController];

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"全て消去" style:UIBarButtonItemStylePlain target:self action:nil];
    navi.navigationItem.rightBarButtonItem = rightItem;
    
    navi.navigationItem.leftBarButtonItem = [self editButtonItem];
    
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"全て消去" style:UIBarButtonItemStylePlain target:self action:nil];
//    self.navigationItem.rightBarButtonItem = rightItem;
//    
//    self.navigationItem.leftBarButtonItem = [self editButtonItem];


}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}


//-- 行数を返す
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _AllSongsArrayAtHistory = [[defaults arrayForKey:@"HistorySONGS"] mutableCopy];
    return _AllSongsArrayAtHistory.count;
}


/************************************************************/
/************************************************************/
/************************************************************/
/*************************１つ消去ボタンを押した時ここに行くには・・・？
 ***********************************/
/************************************************************/
/************************************************************/
/************************************************************/
/************************************************************/
/************************************************************/
/************************************************************/
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _AllSongsArrayAtHistory = [[defaults arrayForKey:@"HistorySONGS"] mutableCopy];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_AllSongsArrayAtHistory removeObjectAtIndex:indexPath.row]; // 削除ボタンが押された行のデータを配列から削除します。
        [self.historyTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // ここは空のままでOKです。
    }
}

// 編集モードになった時に呼ばれるメソッド
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
//    NSLog(@"%s", __func__);
    [super setEditing:editing animated:animated];
    if (editing) {
        // 編集モードの処理
//        NSLog(@"編集モードに入りました。");
    }else{
        // 編集モードから戻った時の処理
//        NSLog(@"編集モードから出ました。");
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _AllSongsArrayAtHistory = [[defaults arrayForKey:@"HistorySONGS"] mutableCopy];
    NSDictionary *dictionary = [[NSDictionary alloc] init];
    dictionary = [_AllSongsArrayAtHistory objectAtIndex:0];

    static NSString *CellIndentifier = @"Cell";
    //-- 再利用可能なCellオブジェクトを作成
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@, %@, %@", _AllSongList[[_AllSongsArrayAtHistory[indexPath.row][@"NO"] intValue]], _AllSongsArrayAtHistory[indexPath.row][@"KEY"], _AllSongsArrayAtHistory[indexPath.row][@"ARTIST"]];
//    cell.textLabel.text = [NSString stringWithFormat:@"%@, %@", _AllSongsArrayAtHistory[indexPath.row][@"TITLE"], /*_AllSongsArrayAtHistory[indexPath.row][@"KEY"],*/ _AllSongsArrayAtHistory[indexPath.row][@"ARTIST"]];
    
    return cell;
}

//-- 行が押された時に発動するメソッド
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //-- 遷移画面のカプセル化（インスタンス化）
    detailViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"detailViewController"];
    dvc.selectNum = (int)indexPath.row;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //-- 遷移画面のカプセル化（インスタンス化）
    detailViewController *dvc = [segue destinationViewController];
    dvc.number = [_AllSongsArrayAtHistory[/*(int)*/self.historyTableView.indexPathForSelectedRow.row][@"NO"] intValue];
    dvc.KeyCorrect = [_AllSongsArrayAtHistory[/*(int)*/self.historyTableView.indexPathForSelectedRow.row][@"KEY"] intValue];
    dvc.historyTableNum = (int)self.historyTableView.indexPathForSelectedRow.row;
//    NSLog(@"historyTableNum = %d", dvc.historyTableNum);
//    NSLog(@"sdf");
}
- (IBAction)DeleteHistoryButton:(id)sender {
    [self setEditing:YES animated:NO];
}
- (IBAction)allDeleteHistoryButton:(id)sender {
    // アラートビューを作成
    // キャンセルボタンを表示しない場合はcancelButtonTitleにnilを指定
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"履歴を全て消去！"
                          message:@"本当に実行しますか？"
                          delegate:self
                          cancelButtonTitle:@"キャンセル！"
                          otherButtonTitles:@"消去する！", nil];
    // アラートビューを表示
    [alert show];
}

/**
 * アラートのボタンが押されたとき
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    switch (buttonIndex) {
        case 1: // Button1が押されたとき
            [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
            [self.historyTableView reloadData];
            break;
            
        default: // キャンセルが押されたとき
//            NSLog(@"Cancel");
            break;
    }
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
