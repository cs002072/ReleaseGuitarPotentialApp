//
//  StrokeViewController.m
//  GuitarPotentialApp
//
//  Created by 岡 慎一郎 on 2015/03/07.
//  Copyright (c) 2015年 oka.shinichiro. All rights reserved.
//

#import "StrokeViewController.h"
#import "GuitarViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface StrokeViewController ()

@end

@implementation StrokeViewController {
    CMMotionManager *_motionManager;
    double *_defference;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    GuitarViewController *gvc = [self.storyboard instantiateViewControllerWithIdentifier:@"GuitarViewController"];
    _motionManager = [[CMMotionManager alloc] init];
//    _defference = (double)0;
    if (_motionManager.accelerometerAvailable){
        //-- センサーの更新間隔を指定
//        _motionManager.accelerometerUpdateInterval = 1 / 10;//-- 10Hz
        _motionManager.accelerometerUpdateInterval = 0.02;//-- 10Hz
        //-- ハンドラを指定
        CMAccelerometerHandler handler = ^(CMAccelerometerData *data, NSError *error){
//            NSLog(@"XLabel == %f", data.acceleration.x);
//            NSLog(@"YLabel == %f", data.acceleration.y);
//            NSLog(@"ZLabel == %f", data.acceleration.z);
//            NSLog(@"\n\n\n\n\n\n");

            float wx = self.ballmg.center.x + data.acceleration.x * 20;
            float wy = self.ballmg.center.y + data.acceleration.y * 20;
            if (wx < 25)        wx = 25;
            else if (295 < wx)  wx = 295;
            else if (wy < 25)   wy = 25;
            else if (435 < wy)  wy = 435;
            
            
            self.ballmg.center = CGPointMake(wx, wy);
//            if (data.acceleration.z < -1.0){
//                NSLog(@"data.acceleration.z == %f", data.acceleration.z);
//            }
//            if (fabs(*(_defference)) - fabs(data.acceleration.z) <= 1.5){
//                NSLog(@"kksdfsdfksdf");
//            }
        };
        //-- 加速度の取得開始
        [_motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:handler];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    //-- 加速度の取得停止
    if (_motionManager.accelerometerActive) {
        [_motionManager stopAccelerometerUpdates];
    }
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
