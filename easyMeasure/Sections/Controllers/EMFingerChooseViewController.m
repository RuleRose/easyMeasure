//
//  FingerChooseViewController.m
//  easyMeasure
//
//  Created by qiwl on 2017/6/9.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "EMFingerChooseViewController.h"
#import "EMFingerChooseView.h"
#import "EMFingerTypeViewController.h"

@interface EMFingerChooseViewController ()<FingerViewDelegate>
@property(nonatomic, strong)EMFingerChooseView *chooseView;

@end

@implementation EMFingerChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_isLeft) {
        self.title = kLocalization(@"em_measure_leftfinger");
    }else{
        self.title = kLocalization(@"em_measure_rightfinger");
    }
    self.view.backgroundColor = kColorFromRGB(0xffffff);
    [self setupViews];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setBackBarButton];
    [self showStatusBar];
    [self showNavigationBar];
}

- (void)setupViews{
    _chooseView = [[EMFingerChooseView alloc] initWithIsLeft:_isLeft];
    _chooseView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_chooseView];
    _chooseView.littleFingerView.delegate = self;
    _chooseView.ringFingerView.delegate = self;
    _chooseView.middleFingerView.delegate = self;
    _chooseView.indexFingerView.delegate = self;
    _chooseView.thumbView.delegate = self;

    [_chooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}

#pragma mark FingerViewDelegate
- (void)measureFinger:(FingerType)fingerType left:(BOOL)isLeft{
    EMFingerTypeViewController *typeVC = [[EMFingerTypeViewController alloc] init];
    typeVC.isLeft = isLeft;
    typeVC.fingerType = fingerType;
    [typeVC pushToNavigationController:self.navigationController animated:YES];
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
