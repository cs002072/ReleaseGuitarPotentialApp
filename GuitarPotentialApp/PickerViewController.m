//
//  PickerViewController.m
//  GuitarPotentialApp
//
//  Created by 岡 慎一郎 on 2015/03/08.
//  Copyright (c) 2015年 oka.shinichiro. All rights reserved.
//

#import "PickerViewController.h"

@interface PickerViewController () {
    NSArray *_keyArray;
    NSArray *_capoArray;
}

@end

@implementation PickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.keyCapoPicker.delegate = self;
    self.keyCapoPicker.dataSource = self;

    _keyArray = [[NSArray alloc] init];
    _capoArray = [[NSArray alloc] init];
    
    _keyArray = @[@"-7", @"-6", @"-5", @"-4", @"-3", @"-2", @"-1", @"0", @"+1", @"+2", @"+3", @"+4", @"+5", @"+6", @"+7"];
    _capoArray = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7"];

    self.keyCapoPicker.showsSelectionIndicator = YES;
    [self.keyCapoPicker selectRow:7 inComponent:0 animated:NO];
    [self.delegate applySelectedKey:[NSString stringWithFormat:@"0"]];
}

//-- PickerViewで要素が選択されたときに呼び出されるメソッド
- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //-- デリゲード先の処理を呼び出し，選択された文字列を親viewに表示させる
//    [self.delegate applySelectedString:[NSString stringWithFormat:@"%ld", (long)row]];
    switch (component) {
        case 0: [self.delegate applySelectedKey:[NSString stringWithFormat:@"%@", [_keyArray objectAtIndex:row]]];   break;
        case 1:
            [self.delegate applySelectedCapo:[NSString stringWithFormat:@"%@", [_capoArray objectAtIndex:row]]];   break;
        default:    break;
    }
}

//-- Pickerの列数を指定するメソッド
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1/*2*/;
}

//-- PickerViewに表示する行数を指定するメソッド
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:     return [_keyArray count];
        case 1:     return [_capoArray count];
        default:    return 0;
    }
}



//-- PickerViewの各行に表示する文字列を指定するメソッド
- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    switch (component) {
        case 0:     return [NSString stringWithFormat:@"%@", [_keyArray objectAtIndex:row]];
        case 1:     return [NSString stringWithFormat:@"%@", [_capoArray objectAtIndex:row]];
        default:    return 0;
    }
}

- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    switch (component) {
        case 0:     return 100.0;
        case 1:     return 50.0;
        default:    return 0;
    }
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
