//
//  ViewController.m
//  GuitarPotentialApp
//
//  Created by 岡 慎一郎 on 2015/02/23.
//  Copyright (c) 2015年 oka.shinichiro. All rights reserved.
//

#import "ViewController.h"
#import "detailViewController.h"
#import "TutorialViewController.h"

@interface ViewController () {
    NSArray *_AllSongsArrayAtView;
    NSArray *_AllSongList;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _AllSongList = [[NSArray alloc] init];
    _AllSongList = @[@"涙のキッス", @"いとしのエリー", @"TSUNAMI", @"真夏の果実", @"波乗りジョニー", @"DIAMONDS", @"M", @"TOMORROW", @"君こそスターだ", @"月とあたしと冷蔵庫"];

    //プロジェクト内のファイルにアクセスできるオブジェクトを作成
    NSBundle *bundle = [NSBundle mainBundle];
    //読み込むプロパティリストのファイルパス（場所）を指定
    NSString *path = [bundle pathForResource:@"AllSongsList" ofType:@"plist"];
    //プロパティリストの中身のデータを取得
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    _AllSongsArrayAtView = [dic objectForKey:@"AllSongsList"];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

//-- 行数を返す
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _AllSongsArrayAtView.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIndentifier = @"Cell";
    
    //-- 再利用可能なCellオブジェクトを作成
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@/%@", _AllSongList[indexPath.row], _AllSongsArrayAtView[indexPath.row][@"ARTIST"]];
//    cell.textLabel.text = [NSString stringWithFormat:@"%@/%@", _AllSongsArrayAtView[indexPath.row][@"TITLE"], _AllSongsArrayAtView[indexPath.row][@"ARTIST"]];
    return cell;
}

//-- 行が押された時に発動するメソッド
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //-- 遷移画面のカプセル化（インスタンス化）
//    detailViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"detailViewController"];
//    dvc.number = [_AllSongsArrayAtView[self.myTableView.indexPathForSelectedRow.row][@"NO"] intValue];
////    NSLog(@"%d", dvc.number);
//    [[self navigationController]pushViewController:dvc animated:YES];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //-- 遷移画面のカプセル化（インスタンス化）
    if ([segue.identifier  isEqual: @"showTutorialSegue"]){
//        TutorialViewController *tvc = [segue destinationViewController];
    } else {
        detailViewController *dvc = [segue destinationViewController];
    //    TutorialViewController *tvc = [segue destinationViewController];
        dvc.number = [_AllSongsArrayAtView[self.myTableView.indexPathForSelectedRow.row][@"NO"] intValue];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushTutorialButton:(id)sender {
//    TutorialViewController *tvc = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialViewController"];
//    [[self navigationController]pushViewController:tvc animated:YES];
    [self performSegueWithIdentifier:@"showTutorialSegue" sender:nil];
}
@end
