//
//  TutorialViewController.h
//  GuitarPotentialApp
//
//  Created by 岡 慎一郎 on 2015/03/13.
//  Copyright (c) 2015年 oka.shinichiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialViewController : UIViewController <UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UIPageControl *pageControl;

@property(nonatomic,strong) UIScrollView *canselView;


@end
