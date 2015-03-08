//
//  PickerViewController.m
//  GuitarPotentialApp
//
//  Created by 岡 慎一郎 on 2015/03/08.
//  Copyright (c) 2015年 oka.shinichiro. All rights reserved.
//

#import "PickerViewController.h"

@interface PickerViewController ()

@end

@implementation PickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.keyCapoPicker.delegate = self;
    self.keyCapoPicker.dataSource = self;
}

//-- PickerViewで要素が選択されたときに呼び出されるメソッド
- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //-- デリゲード先の処理を呼び出し，選択された文字列を親viewに表示させる
    [self.delegate applySelectedString:[NSString stringWithFormat:@"%ld", (long)row]];
}

//-- Pickerの列数を指定するメソッド
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

//-- PickerViewに表示する行数を指定するメソッド
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 10;
}

//-- PickerViewの各行に表示する文字列を指定するメソッド
- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%ld", (long)row];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closePickerView:(id)sender {
    //-- PickerViewを閉じるための処理を呼び出す
    [self.delegate closePickerView:self];
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
