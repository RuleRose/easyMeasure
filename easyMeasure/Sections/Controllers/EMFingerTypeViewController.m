//
//  EMFingerTypeViewController.m
//  easyMeasure
//
//  Created by qiwl on 2017/7/10.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "EMFingerTypeViewController.h"
#import "EMFingerTypeView.h"
#import "EMMeasureViewController.h"
#import "EMFingerTypePopView.h"

@interface EMFingerTypeViewController ()
@property(nonatomic, strong)EMFingerTypeView *typeView;

@end

@implementation EMFingerTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = kLocalization(@"em_fingertype_title");
    self.view.backgroundColor = kColorFromRGB(0xffffff);
    [self setupViews];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setBackBarButton];
    [self showNotiView];
    [self showStatusBar];
    [self showNavigationBar];
}


- (void)setupViews{
    _typeView = [[EMFingerTypeView alloc] init];
    _typeView.backgroundColor = [UIColor clearColor];
    [_typeView.leftBtn addTarget:self action:@selector(leftBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_typeView.rightBtn addTarget:self action:@selector(rightBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_typeView];
    [_typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}

- (void)showNotiView{
    NSNumber *showNoti = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULT_SHOW_TYPE];
    if (showNoti) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:USER_DEFAULT_SHOW_TYPE];
    EMFingerTypePopView *notiView = [[EMFingerTypePopView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    notiView.baseView = self.navigationController.view;
    [notiView showMenus];
}

- (void)leftBtnPressed{
    EMMeasureViewController *measureVC = [[EMMeasureViewController alloc] init];
    measureVC.isLeft = _isLeft;
    measureVC.fingerType = _fingerType;
    measureVC.isBasic = NO;
    [measureVC pushToNavigationController:self.navigationController animated:YES];
}

- (void)rightBtnPressed{
    EMMeasureViewController *measureVC = [[EMMeasureViewController alloc] init];
    measureVC.isLeft = _isLeft;
    measureVC.fingerType = _fingerType;
    measureVC.isBasic = YES;
    [measureVC pushToNavigationController:self.navigationController animated:YES];
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
