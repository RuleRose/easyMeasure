//
//  MeasurementViewController.m
//  easyMeasure
//
//  Created by qiwl on 2017/6/10.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "EMMeasurementViewController.h"
#import "EMMeasurementView.h"

@interface EMMeasurementViewController ()
@property(nonatomic, strong)EMMeasurementView *measurementView;

@end

@implementation EMMeasurementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = kLocalization(@"em_measure_intro");
    self.view.backgroundColor = kColorFromRGB(0xffffff);
    [self setupViews];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setBackBarButton];
}

- (void)setupViews{
    _measurementView = [[EMMeasurementView alloc] init];
    _measurementView.backgroundColor = [UIColor clearColor];
    _measurementView.fingerType = _fingerType;
    [self.view addSubview:_measurementView];
    [_measurementView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
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
