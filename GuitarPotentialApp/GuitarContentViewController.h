//
//  GuitarContentViewController.h
//  GuitarPotentialApp
//
//  Created by 岡 慎一郎 on 2015/03/10.
//  Copyright (c) 2015年 oka.shinichiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GuitarContentViewControllerDelegate;

@interface GuitarContentViewController : UIViewController

// 処理のデリゲート先の参照
@property (weak, nonatomic) id<GuitarContentViewControllerDelegate> delegate;

// PickerViewを閉じる処理を行うメソッド。closeButtonが押下されたときに呼び出される
- (IBAction)CandCloseGuitarContent:(id)sender;
- (IBAction)DandCloseGuitarContent:(id)sender;
- (IBAction)EandCloseGuitarContent:(id)sender;
- (IBAction)FandCloseGuitarContent:(id)sender;
- (IBAction)GandCloseGuitarContent:(id)sender;
- (IBAction)AandCloseGuitarContent:(id)sender;
- (IBAction)BandCloseGuitarContent:(id)sender;

@end

@protocol GuitarContentViewControllerDelegate <NSObject>
// 当該PickerViewを閉じるためのデリゲートメソッド
-(void)CandCloseGuitarContent:(GuitarContentViewController *)controller;
-(void)DandCloseGuitarContent:(GuitarContentViewController *)controller;
-(void)EandCloseGuitarContent:(GuitarContentViewController *)controller;
-(void)FandCloseGuitarContent:(GuitarContentViewController *)controller;
-(void)GandCloseGuitarContent:(GuitarContentViewController *)controller;
-(void)AandCloseGuitarContent:(GuitarContentViewController *)controller;
-(void)BandCloseGuitarContent:(GuitarContentViewController *)controller;

@end
