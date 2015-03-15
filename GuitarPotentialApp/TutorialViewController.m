//
//  TutorialViewController.m
//  GuitarPotentialApp
//
//  Created by 岡 慎一郎 on 2015/03/13.
//  Copyright (c) 2015年 oka.shinichiro. All rights reserved.
//

#import "TutorialViewController.h"

@interface TutorialViewController ()

@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSInteger pageSize = 12; // ページ数
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    // UIScrollViewのインスタンス化
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.frame = self.view.bounds;
    
    // 横スクロールのインジケータを非表示にする
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    // ページングを有効にする
    self.scrollView.pagingEnabled = YES;
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.delegate = self;
    
    // スクロールの範囲を設定
    [self.scrollView setContentSize:CGSizeMake((pageSize * width), height)];
    
    // スクロールビューを貼付ける
    [self.view addSubview:self.scrollView];
    
    
    // スクロールビューにラベルを貼付ける
    for (int i = 0; i < pageSize; i++) {
        
        // UILabel作成
        //        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(i * width, 0, width, height)];
        //        label.text = [NSString stringWithFormat:@"%d", i + 1];
        //        label.font = [UIFont fontWithName:@"Arial" size:92];
        //        label.backgroundColor = [UIColor yellowColor];
        //        label.textAlignment = NSTextAlignmentCenter;
        //        [self.scrollView addSubview:label];
        //        NSLog(@"imagenum:%d",i);
        //head_close.png
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"tutorialImage%d", i]];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Tutorial%d_GuitarPotential.png", i+1]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(i * width, 0, width, height);
        [self.scrollView addSubview:imageView];
    }
    
    // ページコントロールのインスタンス化
    CGFloat x = (width - 300) / 2;
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(x+75, height-60, 150, 50)];
    
    // 背景色を設定
    self.pageControl.backgroundColor = [UIColor whiteColor];
    
    // ページ数を設定
    self.pageControl.numberOfPages = pageSize;
    
    // 現在のページを設定
    self.pageControl.currentPage = 0;
    
    // デフォルトの色
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    // 選択されてるページを現す色
    self.pageControl.currentPageIndicatorTintColor =  [UIColor colorWithRed:0.2 green:0.6 blue:1.0 alpha:1.0];
    
    // ページコントロールをタップされたときに呼ばれるメソッドを設定
    self.pageControl.userInteractionEnabled = YES;
    [self.pageControl addTarget:self
                         action:@selector(pageControl_Tapped:)
               forControlEvents:UIControlEventValueChanged];
    
    
    //    //キャンセルボタン
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(10, height-150, 90, 60);
    //    [canselButton.titleLabel setFont:[UIFont systemFontOfSize:22]];
    //    [canselButton setTitle:@"Cansel" forState:UIControlStateNormal];
    //    [canselButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    UIImage *img =[UIImage imageNamed:@"CanselTutorialButton.png"];
    [cancelButton setImage:img forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(backtoHome:)forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:cancelButton];
    
    
    // ページコントロールを貼付ける
    [self.view addSubview:self.pageControl];
}

// スクロールビューがスワイプされたとき
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    if ((NSInteger)fmod(self.scrollView.contentOffset.x , pageWidth) == 0) {
        // ページコントロールに現在のページを設定
        self.pageControl.currentPage = self.scrollView.contentOffset.x / pageWidth;
    }
}

// ページコントロールがタップされたとき
- (void)pageControl_Tapped:(id)sender
{
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * self.pageControl.currentPage;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}


-(void)backtoHome:(UIButton*)cancelButton{
    NSLog(@"%@",cancelButton);
    //modalを閉じる
    [self dismissViewControllerAnimated:YES completion:NULL];
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
