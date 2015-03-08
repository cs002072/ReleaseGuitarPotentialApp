//
//  PickerViewController.h
//  GuitarPotentialApp
//
//  Created by 岡 慎一郎 on 2015/03/08.
//  Copyright (c) 2015年 oka.shinichiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickerViewControllerDelegate;

@interface PickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *closePickerButton;
@property (weak, nonatomic) IBOutlet UIPickerView *keyCapoPicker;
// 処理のデリゲート先の参照
@property (weak, nonatomic) id<PickerViewControllerDelegate> delegate;



// PickerViewを閉じる処理を行うメソッド。closeButtonが押下されたときに呼び出される
- (IBAction)closePickerView:(id)sender;


@end

@protocol PickerViewControllerDelegate <NSObject>
// 選択された文字列を適用するためのデリゲートメソッド
-(void)applySelectedString:(NSString *)str;
// 当該PickerViewを閉じるためのデリゲートメソッド
-(void)closePickerView:(PickerViewController *)controller;

@end
