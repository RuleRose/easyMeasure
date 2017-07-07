//
//  MeasureViewController.m
//  easyMeasure
//
//  Created by qiwl on 2017/6/9.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "EMMeasureViewController.h"
#import "EMMeasureResultViewController.h"
#import "EMMeasurementViewController.h"
#import "NSDate+Extension.h"
#import "EMMeasureView.h"
#import "EMNotiPopView.h"

@interface EMMeasureViewController ()
@property(nonatomic, strong)EMMeasureView *measureView;

@end

@implementation EMMeasureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorFromRGB(0xffffff);
    NSString *title = kLocalization(@"em_measure");
    if (_isLeft) {
        title = [title stringByAppendingString:kLocalization(@"em_left_hand")];
    }else{
        title = [title stringByAppendingString:kLocalization(@"em_right_hand")];
    }
    switch (_fingerType) {
        case kFingerOfThumb:
            title = [title stringByAppendingString:kLocalization(@"em_thumb")];
            break;
        case kFingerOfIndexFinger:
            title = [title stringByAppendingString:kLocalization(@"em_indexfinger")];
            break;
        case kFingerOfMiddleFinger:
            title = [title stringByAppendingString:kLocalization(@"em_middlefinger")];
            break;
        case kFingerOfRingFinger:
            title = [title stringByAppendingString:kLocalization(@"em_ringfinger")];
            break;
        case kFingerOfLittleFinger:
            title = [title stringByAppendingString:kLocalization(@"em_littlefinger")];
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
    [self setNavigationButtons:1 title:@[kLocalization(@"em_measure_intro")] image:nil highlightedImage:nil frame:@[[NSValue valueWithCGRect:CGRectMake(0, 0, 80, 44)]] isRight:YES];
    [self showNotiView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)navigationRightButtonClicked:(UIButton *)sender {
    EMMeasurementViewController *measurementVC = [[EMMeasurementViewController alloc] init];
    measurementVC.fingerType = _fingerType;
    [measurementVC pushToNavigationController:self.navigationController animated:YES];
}

- (void)setupViews{
    _measureView = [[EMMeasureView alloc] initWithFingerType:_fingerType isLeft:_isLeft];
    _measureView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_measureView];
    [_measureView.finishBtn addTarget:self action:@selector(finishBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_measureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}

- (void)showNotiView{
    if (_fingerType == kFingerOfThumb) {
        NSNumber *showThumbNoti = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULT_SHOW_THUMB];
        if (showThumbNoti) {
            return;
        }
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:USER_DEFAULT_SHOW_THUMB];
    }else{
        NSNumber *showThumbNoti = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULT_SHOW_OTHERFINGER];
        if (showThumbNoti) {
            return;
        }
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:USER_DEFAULT_SHOW_OTHERFINGER];

    }
    EMNotiPopView *notiView = [[EMNotiPopView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    notiView.baseView = self.navigationController.view;
    [notiView showMenus];
}

- (void)finishBtnPressed{
    if (!_measureModel) {
        _measureModel = [[EMMeasureModel alloc] init];
    }
    _measureModel.width = [NSString stringWithFormat:@"%f",_measureView.width];
    _measureModel.finger_left = [NSString stringWithFormat:@"%d",_isLeft];
    _measureModel.finger_type = [NSString stringWithFormat:@"%lu",(unsigned long)_fingerType];
    _measureModel.measure_time = [NSDate timestampFromDate:[NSDate date]];
    if ([NSString leie_isBlankString:_measureModel.pid]) {
        [_measureModel insertToDB];
    }else{
        if (![_measureModel updateToDBDependsOn:nil]) {
            [_measureModel insertToDB];
        }
    }
    EMMeasureResultViewController *resultVC = [[EMMeasureResultViewController alloc] init];
    resultVC.measure = _measureModel;
    NSMutableArray* viewControllers = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
    [viewControllers removeObject:self];
    [viewControllers addObject:resultVC];
    [self.navigationController setViewControllers:viewControllers animated:YES];
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
