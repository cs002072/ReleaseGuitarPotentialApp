//
//  ViewController.m
//  GuitarPotentialApp
//
//  Created by 岡 慎一郎 on 2015/02/23.
//  Copyright (c) 2015年 oka.shinichiro. All rights reserved.
//

#import "ViewController.h"
#import "detailViewController.h"

@interface ViewController () {
    NSArray *_AllSongsArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _songList = @[@"涙のキッス", @"いとしのエリー"];
    
    //プロジェクト内のファイルにアクセスできるオブジェクトを作成
    NSBundle *bundle = [NSBundle mainBundle];
    //読み込むプロパティリストのファイルパス（場所）を指定
    NSString *path = [bundle pathForResource:@"AllSongsList" ofType:@"plist"];
    //プロパティリストの中身のデータを取得
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    _AllSongsArray = [dic objectForKey:@"AllSongsList"];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
}

//-- 行数を返す
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _AllSongsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIndentifier = @"Cell";
    
    //-- 再利用可能なCellオブジェクトを作成
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@/%@", _AllSongsArray[indexPath.row][@"TITLE"], _AllSongsArray[indexPath.row][@"ARTIST"]];
    return cell;
}

//-- 行が押された時に発動するメソッド
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //-- 遷移画面のカプセル化（インスタンス化）
    detailViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"detailViewController"];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //-- 遷移画面のカプセル化（インスタンス化）
    detailViewController *dvc = [segue destinationViewController];
    dvc.number = [_AllSongsArray[(int)self.myTableView.indexPathForSelectedRow.row][@"NO"] intValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
