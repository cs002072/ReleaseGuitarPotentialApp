//
//  ViewController.h
//  GuitarPotentialApp
//
//  Created by 岡 慎一郎 on 2015/02/23.
//  Copyright (c) 2015年 oka.shinichiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *_songList;//-- 練習する曲のリスト
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

