//
//  detailViewController.h
//  GuitarPotentialApp
//
//  Created by 岡 慎一郎 on 2015/02/23.
//  Copyright (c) 2015年 oka.shinichiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface detailViewController : UIViewController
//{
//    int number;
//}

@property (nonatomic, assign) int selectNum;
@property (weak, nonatomic) IBOutlet UILabel *SongWordStr;
@property (nonatomic, assign) int number;
@property (nonatomic, assign) int numSelected;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *artist;


- (IBAction)tapSaveButton:(id)sender;
- (IBAction)tapCancelButton:(id)sender;

@end
