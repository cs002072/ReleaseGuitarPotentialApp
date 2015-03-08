//
//  detailViewController.h
//  GuitarPotentialApp
//
//  Created by 岡 慎一郎 on 2015/02/23.
//  Copyright (c) 2015年 oka.shinichiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerViewController.h"

@interface detailViewController : UIViewController <PickerViewControllerDelegate>
//{
//    int number;
//}

@property (nonatomic, assign) int selectNum;
@property (weak, nonatomic) IBOutlet UILabel *SongWordStr;
@property (nonatomic, assign) int number;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UILabel *selectedStringLabel;

//-- 呼び出すPickerViewのポインタ *strongを指定してポインタを掴んでおかないと解放されてしまう
@property (strong, nonatomic) PickerViewController *pickerViewController;
- (IBAction)openPickerView:(id)sender;



- (IBAction)tapSaveButton:(id)sender;
- (IBAction)tapCancelButton:(id)sender;

@end
