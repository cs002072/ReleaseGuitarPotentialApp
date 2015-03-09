//
//  StrokeViewController.h
//  GuitarPotentialApp
//
//  Created by 岡 慎一郎 on 2015/03/07.
//  Copyright (c) 2015年 oka.shinichiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StrokeViewController : UIViewController <UIAccelerometerDelegate>
//- (void) soundPlayer:(NSMutableArray *)pushedFlag :(NSInteger)String :(NSInteger)soundFlag;
@property (weak, nonatomic) IBOutlet UIImageView *ballmg;

@end
