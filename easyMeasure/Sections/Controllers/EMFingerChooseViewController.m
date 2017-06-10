//
//  FingerChooseViewController.m
//  easyMeasure
//
//  Created by qiwl on 2017/6/9.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "EMFingerChooseViewController.h"
#import "EMFingerView.h"
#import "EMMeasureViewController.h"

@interface EMFingerChooseViewController ()<FingerViewDelegate>
@property(nonatomic, strong)UILabel *measureNotiLabel;
@property(nonatomic, strong)EMFingerView *thumbView;
@property(nonatomic, strong)EMFingerView *indexFingerView;
@property(nonatomic, strong)EMFingerView *middleFingerView;
@property(nonatomic, strong)EMFingerView *ringFingerView;
@property(nonatomic, strong)EMFingerView *littleFingerView;
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
}

- (void)setupViews{
    _measureNotiLabel = [[UILabel alloc] init];
    _measureNotiLabel.backgroundColor = [UIColor clearColor];
    _measureNotiLabel.text = kLocalization(@"em_label_measure_finger");
    _measureNotiLabel.textColor = kColor_Text1;
    _measureNotiLabel.font = [UIFont systemFontOfSize:16];
    _measureNotiLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_measureNotiLabel];
    _littleFingerView = [[EMFingerView alloc] initWithLeft:_isLeft fingerType:kFingerOfLittleFinger];
    _littleFingerView.delegate = self;
    [self.view addSubview:_littleFingerView];
    _ringFingerView = [[EMFingerView alloc] initWithLeft:_isLeft fingerType:kFingerOfRingFinger];
    _ringFingerView.delegate = self;
    [self.view addSubview:_ringFingerView];
    _middleFingerView = [[EMFingerView alloc] initWithLeft:_isLeft fingerType:kFingerOfMiddleFinger];
    _middleFingerView.delegate = self;
    [self.view addSubview:_middleFingerView];
    _indexFingerView = [[EMFingerView alloc] initWithLeft:_isLeft fingerType:kFingerOfIndexFinger];
    _indexFingerView.delegate = self;
    [self.view addSubview:_indexFingerView];
    _thumbView = [[EMFingerView alloc] initWithLeft:_isLeft fingerType:kFingerOfThumb];
    _thumbView.delegate = self;
    [self.view addSubview:_thumbView];
    
    CGFloat space = 60;
    if ([[UIScreen mainScreen] bounds].size.height < 667) {
        space = 48;
    }
    
    MJWeakSelf;
    [_measureNotiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@(space + kNavigationHeight + kStatusHeight));
        make.right.equalTo(@0);
        make.height.equalTo(@24);
    }];
    if (_isLeft) {
        [_littleFingerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.top.equalTo(weakSelf.measureNotiLabel.mas_bottom).offset(space);
            make.right.equalTo(@(kFitWidth(-152)));
            make.height.equalTo(@56);
        }];
        [_ringFingerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.top.equalTo(weakSelf.littleFingerView.mas_bottom).offset(10);
            make.right.equalTo(@(kFitWidth(-70)));
            make.height.equalTo(@56);
        }];
        [_middleFingerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.ringFingerView.mas_bottom).offset(10);
            make.height.equalTo(@56);
            make.left.equalTo(@0);
            make.right.equalTo(@(kFitWidth(-25)));
        }];
        [_indexFingerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.top.equalTo(weakSelf.middleFingerView.mas_bottom).offset(10);
            make.right.equalTo(@(kFitWidth(-91)));
            make.height.equalTo(@56);
        }];
        [_thumbView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.top.equalTo(weakSelf.indexFingerView.mas_bottom).offset(10);
            make.right.equalTo(@(kFitWidth(-245)));
            make.height.equalTo(@69);
        }];
    }else{
        [_littleFingerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@0);
            make.top.equalTo(weakSelf.measureNotiLabel.mas_bottom).offset(space);
            make.left.equalTo(@(kFitWidth(152)));
            make.height.equalTo(@56);
        }];
        [_ringFingerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@0);
            make.top.equalTo(weakSelf.littleFingerView.mas_bottom).offset(10);
            make.left.equalTo(@(kFitWidth(70)));
            make.height.equalTo(@56);
        }];
        [_middleFingerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@0);
            make.top.equalTo(weakSelf.ringFingerView.mas_bottom).offset(10);
            make.left.equalTo(@(kFitWidth(25)));
            make.height.equalTo(@56);
        }];
        [_indexFingerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@0);
            make.top.equalTo(weakSelf.middleFingerView.mas_bottom).offset(10);
            make.left.equalTo(@(kFitWidth(91)));
            make.height.equalTo(@56);
        }];
        [_thumbView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@0);
            make.top.equalTo(weakSelf.indexFingerView.mas_bottom).offset(10);
            make.left.equalTo(@(kFitWidth(245)));
            make.height.equalTo(@69);
        }];
    }
}

#pragma mark FingerViewDelegate
- (void)measureFinger:(FingerType)fingerType left:(BOOL)isLeft{
    EMMeasureViewController *measureVC = [[EMMeasureViewController alloc] init];
    measureVC.isLeft = isLeft;
    measureVC.fingerType = fingerType;
    [measureVC pushToNavigationController:self.navigationController animated:YES
     ];
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
