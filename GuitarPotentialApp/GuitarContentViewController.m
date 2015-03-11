//
//  GuitarContentViewController.m
//  GuitarPotentialApp
//
//  Created by 岡 慎一郎 on 2015/03/10.
//  Copyright (c) 2015年 oka.shinichiro. All rights reserved.
//

#import "GuitarContentViewController.h"

@interface GuitarContentViewController ()

@end

@implementation GuitarContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)CandCloseGuitarContent:(id)sender {
    //-- PickerViewを閉じるための処理を呼び出す
    [self.delegate CandCloseGuitarContent:self];
}
- (IBAction)DandCloseGuitarContent:(id)sender {
    //-- PickerViewを閉じるための処理を呼び出す
    [self.delegate DandCloseGuitarContent:self];
}
- (IBAction)EandCloseGuitarContent:(id)sender {
    //-- PickerViewを閉じるための処理を呼び出す
    [self.delegate EandCloseGuitarContent:self];
}
- (IBAction)FandCloseGuitarContent:(id)sender {
    //-- PickerViewを閉じるための処理を呼び出す
    [self.delegate FandCloseGuitarContent:self];
}
- (IBAction)GandCloseGuitarContent:(id)sender {
    //-- PickerViewを閉じるための処理を呼び出す
    [self.delegate GandCloseGuitarContent:self];
}
- (IBAction)AandCloseGuitarContent:(id)sender {
    //-- PickerViewを閉じるための処理を呼び出す
    [self.delegate AandCloseGuitarContent:self];
}
- (IBAction)BandCloseGuitarContent:(id)sender {
    //-- PickerViewを閉じるための処理を呼び出す
    [self.delegate BandCloseGuitarContent:self];
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
