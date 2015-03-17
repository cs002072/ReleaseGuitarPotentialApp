//
//  GuitarViewController.h
//  GuitarPotentialApp
//
//  Created by 岡 慎一郎 on 2015/03/01.
//  Copyright (c) 2015年 oka.shinichiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuitarContentViewController.h"

@interface GuitarViewController : UIViewController <UIGestureRecognizerDelegate>

- (void) soundPlayer:(NSMutableArray *)pushedFlag :(NSInteger)String :(NSInteger)soundFlag;
@property (strong, nonatomic) GuitarContentViewController *guitarContentViewController;

@property (weak, nonatomic) IBOutlet UIImageView *string11;
@property (weak, nonatomic) IBOutlet UIImageView *string21;
@property (weak, nonatomic) IBOutlet UIImageView *string31;
@property (weak, nonatomic) IBOutlet UIImageView *string41;
@property (weak, nonatomic) IBOutlet UIImageView *string51;
@property (weak, nonatomic) IBOutlet UIImageView *string61;

@property (weak, nonatomic) IBOutlet UIImageView *string12;
@property (weak, nonatomic) IBOutlet UIImageView *string22;
@property (weak, nonatomic) IBOutlet UIImageView *string32;
@property (weak, nonatomic) IBOutlet UIImageView *string42;
@property (weak, nonatomic) IBOutlet UIImageView *string52;
@property (weak, nonatomic) IBOutlet UIImageView *string62;

@property (weak, nonatomic) IBOutlet UIImageView *string13;
@property (weak, nonatomic) IBOutlet UIImageView *string23;
@property (weak, nonatomic) IBOutlet UIImageView *string33;
@property (weak, nonatomic) IBOutlet UIImageView *string43;
@property (weak, nonatomic) IBOutlet UIImageView *string53;
@property (weak, nonatomic) IBOutlet UIImageView *string63;

@property (weak, nonatomic) IBOutlet UIImageView *string14;
@property (weak, nonatomic) IBOutlet UIImageView *string24;
@property (weak, nonatomic) IBOutlet UIImageView *string34;
@property (weak, nonatomic) IBOutlet UIImageView *string44;
@property (weak, nonatomic) IBOutlet UIImageView *string54;
@property (weak, nonatomic) IBOutlet UIImageView *string64;

@property (weak, nonatomic) IBOutlet UIImageView *string15;
@property (weak, nonatomic) IBOutlet UIImageView *string25;
@property (weak, nonatomic) IBOutlet UIImageView *string35;
@property (weak, nonatomic) IBOutlet UIImageView *string45;
@property (weak, nonatomic) IBOutlet UIImageView *string55;
@property (weak, nonatomic) IBOutlet UIImageView *string65;

@property (weak, nonatomic) IBOutlet UIImageView *string16;
@property (weak, nonatomic) IBOutlet UIImageView *string26;
@property (weak, nonatomic) IBOutlet UIImageView *string36;
@property (weak, nonatomic) IBOutlet UIImageView *string46;
@property (weak, nonatomic) IBOutlet UIImageView *string56;
@property (weak, nonatomic) IBOutlet UIImageView *string66;

@property (weak, nonatomic) IBOutlet UIImageView *stroke1;
@property (weak, nonatomic) IBOutlet UIImageView *stroke2;
@property (weak, nonatomic) IBOutlet UIImageView *stroke3;
@property (weak, nonatomic) IBOutlet UIImageView *stroke4;
@property (weak, nonatomic) IBOutlet UIImageView *stroke5;
@property (weak, nonatomic) IBOutlet UIImageView *stroke6;

@end
