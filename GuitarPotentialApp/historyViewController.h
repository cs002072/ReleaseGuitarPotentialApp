//
//  historyViewController.h
//  GuitarPotentialApp
//
//  Created by 岡 慎一郎 on 2015/02/24.
//  Copyright (c) 2015年 oka.shinichiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface historyViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *_historyList;//-- 履歴の楽曲リスト
}

@property (weak, nonatomic) IBOutlet UITableView *historyTableView;

@end
