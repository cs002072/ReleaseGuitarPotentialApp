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
}

@end

@implementation historyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.historyTableView.delegate = self;
    self.historyTableView.dataSource = self;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _historyList = [[NSMutableArray alloc] init];

    //-- １曲の情報
    _AllSongsArrayAtHistory = [[NSMutableArray alloc] init];
    _AllSongsArrayAtHistory = [[defaults arrayForKey:@"HistorySONGS"] mutableCopy];
    
    /**************これ必要くさい*****************/
    /**************これ必要くさい*****************/
    /**************これ必要くさい*****************/
//    //-- ナビゲーションバー追加？
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    //-- セルを削除する機能を追加
//    self.title = @"履歴";
//    self.navigationItem.leftBarButtonItem = [self editButtonItem];
    /**************これ必要くさい*****************/
    /**************これ必要くさい*****************/
    /**************これ必要くさい*****************/
}

/**************これは微妙・・・*****************/
/**************これは微妙・・・*****************/
/**************これは微妙・・・*****************/
//-- 履歴を横スワイプしたとき
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSLog(@"asdas");
    }
}
/**************これは微妙・・・*****************/
/**************これは微妙・・・*****************/
/**************これは微妙・・・*****************/

//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return @"delete";
//}


//-- 行数を返す
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _AllSongsArrayAtHistory = [[defaults arrayForKey:@"HistorySONGS"] mutableCopy];
    return _AllSongsArrayAtHistory.count;
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
    cell.textLabel.text = [NSString stringWithFormat:@"%@, %@", _AllSongsArrayAtHistory[indexPath.row][@"TITLE"], _AllSongsArrayAtHistory[indexPath.row][@"ARTIST"]];
    
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
            NSLog(@"Cancel");
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
