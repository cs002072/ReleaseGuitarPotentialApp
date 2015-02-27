//
//  historyViewController.m
//  GuitarPotentialApp
//
//  Created by 岡 慎一郎 on 2015/02/24.
//  Copyright (c) 2015年 oka.shinichiro. All rights reserved.
//

#import "historyViewController.h"
#import "detailViewController.h"

@interface historyViewController ()

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
    NSMutableArray *songInfo = [[NSMutableArray alloc] init];
    songInfo = [defaults arrayForKey:@"ALLSONGS"];

    NSDictionary *dictionary = [[NSDictionary alloc] init];
    dictionary = [songInfo objectAtIndex:0];
    [_historyList addObject:[dictionary objectForKey:@"TITLE"]];
    [_historyList addObject:[dictionary objectForKey:@"ARTIST"]];
    [_historyList addObject:[dictionary objectForKey:@"KEY"]];
//    self.myTextView.text = [dictionary objectForKey:@"KEY"];
}

//-- 行数を返す
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1/*_historyList.count*/;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIndentifier = @"Cell";
    //-- 再利用可能なCellオブジェクトを作成
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@, %@, %@", [_historyList objectAtIndex:0], [_historyList objectAtIndex:1], [_historyList objectAtIndex:2]];
//    cell.textLabel.text = [NSString stringWithFormat:@"%@", [_historyList objectAtIndex:indexPath.row]];
    return cell;
}

//-- 行が押された時に発動するメソッド
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    //-- 遷移画面のカプセル化（インスタンス化）
    detailViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"detailViewController"];
    dvc.selectNum = (int)indexPath.row;
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
