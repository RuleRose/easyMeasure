//
//  MeasureViewController.m
//  easyMeasure
//
//  Created by qiwl on 2017/6/9.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "MeasureViewController.h"

@interface MeasureViewController ()

@end

@implementation MeasureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorFromRGB(0xffffff);
    NSString *title = @"测量";
    if (_isLeft) {
        title = [title stringByAppendingString:@"左手"];
    }else{
        title = [title stringByAppendingString:@"右手"];
    }
    switch (_fingerType) {
        case kFingerOfThumb:
            title = [title stringByAppendingString:@"拇指"];
            break;
        case kFingerOfIndexFinger:
            title = [title stringByAppendingString:@"食指"];
            break;
        case kFingerOfMiddleFinger:
            title = [title stringByAppendingString:@"中指"];
            break;
        case kFingerOfRingFinger:
            title = [title stringByAppendingString:@"无名指"];
            break;
        case kFingerOfLittleFinger:
            title = [title stringByAppendingString:@"小指"];
            break;
        default:
            break;
    }
    self.title = title;
    [self setupViews];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setBackBarButton];
}

- (void)setupViews{
}

#pragma mark FingerViewDelegate
- (void)measureFinger:(FingerType)fingerType left:(BOOL)isLeft{
    
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
