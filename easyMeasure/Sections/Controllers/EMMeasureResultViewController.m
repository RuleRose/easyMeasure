//
//  MeasureResultViewController.m
//  easyMeasure
//
//  Created by qiwl on 2017/6/10.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "EMMeasureResultViewController.h"
#import "EMScreenSizeManager.h"
#import "EMMeasureResultView.h"

@interface EMMeasureResultViewController ()
@property(nonatomic, strong)EMMeasureResultView *resultView;
@end

@implementation EMMeasureResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = kLocalization(@"em_measure_result");
    self.view.backgroundColor = kColorFromRGB(0xffffff);
    [self setupViews];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setBackBarButton];
}

- (void)setupViews{
    _resultView = [[EMMeasureResultView alloc] init];
    _resultView.backgroundColor = [UIColor clearColor];
    _resultView.measure = _measure;
    [self.view addSubview:_resultView];
    [_resultView.remeasureBtn addTarget:self action:@selector(remeasureBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}

- (void)remeasureBtnPressed{
    EMMeasureViewController *measureVC = [[EMMeasureViewController alloc] init];
    measureVC.measureModel = _measure;
    measureVC.isLeft = [_measure.finger_left boolValue];
    measureVC.fingerType = [_measure.finger_type integerValue];
    NSMutableArray* viewControllers = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
    [viewControllers removeObject:self];
    [viewControllers addObject:measureVC];
    [self.navigationController setViewControllers:viewControllers animated:YES];
}

- (void)goBack:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
