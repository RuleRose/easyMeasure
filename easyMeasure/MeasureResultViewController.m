//
//  MeasureResultViewController.m
//  easyMeasure
//
//  Created by qiwl on 2017/6/10.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "MeasureResultViewController.h"
#import "MeasureButton.h"
#import "MainViewController.h"
#import "MeasureViewController.h"
#import "EMScreenSizeManager.h"
#import "DegreeView.h"

@interface MeasureResultViewController ()
@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic, strong)UILabel *measureTitleLabel;
@property(nonatomic, strong)UILabel *measureLabel;
@property(nonatomic, strong)UILabel *suggestTitleLabel;
@property(nonatomic, strong)DegreeView *hkDegreeView;
@property(nonatomic, strong)DegreeView *euroDegreeView;
@property(nonatomic, strong)DegreeView *usDegreeView;
@property(nonatomic, strong)MeasureButton *remeasureBtn;
@property(nonatomic, strong)UIView *leftPoint;
@property(nonatomic, strong)UIView *rightPoint;

@end

@implementation MeasureResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测量结果";
    self.view.backgroundColor = kColorFromRGB(0xffffff);
    [self setupViews];
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setBackBarButton];
}

- (void)setupViews{
    _imageView = [[UIImageView alloc] init];
    _imageView.backgroundColor = [UIColor clearColor];
    _imageView.image = [UIImage imageNamed:@"banner"];
    [self.view addSubview:_imageView];
    _measureTitleLabel = [[UILabel alloc] init];
    _measureTitleLabel.backgroundColor = [UIColor clearColor];
    _measureTitleLabel.text = @"您的戒指内径为";
    _measureTitleLabel.textColor = kColor_Text2;
    _measureTitleLabel.font = [UIFont systemFontOfSize:15];
    _measureTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_measureTitleLabel];
    _measureLabel = [[UILabel alloc] init];
    _measureLabel.backgroundColor = [UIColor clearColor];
    _measureLabel.textColor = kColor_Text5;
    _measureLabel.font = [UIFont boldSystemFontOfSize:40];
    _measureLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_measureLabel];
    _suggestTitleLabel = [[UILabel alloc] init];
    _suggestTitleLabel.backgroundColor = [UIColor clearColor];
    _suggestTitleLabel.text = @"建议您挑选戒指的尺寸为";
    _suggestTitleLabel.textColor = kColor_Text2;
    _suggestTitleLabel.font = [UIFont systemFontOfSize:15];
    _suggestTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_suggestTitleLabel];
    
    _leftPoint = [[UIView alloc] init];
    _leftPoint.backgroundColor = [UIColor blackColor];
    _leftPoint.layer.masksToBounds = YES;
    _leftPoint.layer.cornerRadius = 4;
    [self.view addSubview:_leftPoint];
    _rightPoint = [[UIView alloc] init];
    _rightPoint.backgroundColor = [UIColor blackColor];
    _rightPoint.layer.masksToBounds = YES;
    _rightPoint.layer.cornerRadius = 4;
    [self.view addSubview:_rightPoint];
    
    _hkDegreeView = [[DegreeView alloc] init];
    _hkDegreeView.backgroundColor = [UIColor clearColor];
    _hkDegreeView.degreeTitleLabel.text = @"港度";
    [self.view addSubview:_hkDegreeView];
    _euroDegreeView = [[DegreeView alloc] init];
    _euroDegreeView.backgroundColor = [UIColor clearColor];
    _euroDegreeView.degreeTitleLabel.text = @"欧度";
    [self.view addSubview:_euroDegreeView];
    _usDegreeView = [[DegreeView alloc] init];
    _usDegreeView.backgroundColor = [UIColor clearColor];
    _usDegreeView.degreeTitleLabel.text = @"美度";
    [self.view addSubview:_usDegreeView];
    
    _remeasureBtn = [[MeasureButton alloc] init];
    _remeasureBtn.layer.masksToBounds = YES;
    _remeasureBtn.layer.cornerRadius = 24;
    _remeasureBtn.normalColor = kColor_Button1;
    _remeasureBtn.highlightColor = kColor_Highlight_Button3;
    [_remeasureBtn setTitle:@"重新测量" forState:UIControlStateNormal];
    [_remeasureBtn setTitleColor:kColor_Text1 forState:UIControlStateNormal];
    _remeasureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    MJWeakSelf;
    _remeasureBtn.measureBlock = ^(){
        MeasureViewController *measureVC = [[MeasureViewController alloc] init];
        measureVC.measureModel = weakSelf.measure;
        measureVC.isLeft = [weakSelf.measure.finger_left boolValue];
        measureVC.fingerType = [weakSelf.measure.finger_type integerValue];
        NSMutableArray* viewControllers = [[NSMutableArray alloc] initWithArray:weakSelf.navigationController.viewControllers];
        [viewControllers removeObject:weakSelf];
        [viewControllers addObject:measureVC];
        [weakSelf.navigationController setViewControllers:viewControllers animated:YES];
    };
    [self.view addSubview:_remeasureBtn];
    CGFloat height = kScreen_Width/1.6;
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@(kNavigationHeight + kStatusHeight));
        make.right.equalTo(@0);
        make.height.equalTo(@(height));
    }];
    [_measureTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(weakSelf.imageView.mas_bottom).offset(kFitWidth(31));
        make.height.equalTo(@23);
    }];
    [_measureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(weakSelf.measureTitleLabel.mas_bottom).offset(kFitWidth(14));
        make.height.equalTo(@48);
    }];
    [_suggestTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(weakSelf.measureLabel.mas_bottom).offset(kFitWidth(37));
        make.height.equalTo(@23);
    }];
    [_hkDegreeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.suggestTitleLabel.mas_bottom).offset(14);
        make.left.equalTo(@0);
        make.width.equalTo(weakSelf.euroDegreeView.mas_width);
        make.right.equalTo(weakSelf.euroDegreeView.mas_left);
        make.height.equalTo(@54);
    }];
    
    [_euroDegreeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.suggestTitleLabel.mas_bottom).offset(14);
        make.left.equalTo(weakSelf.hkDegreeView.mas_right);
        make.right.equalTo(weakSelf.usDegreeView.mas_left);
        make.height.equalTo(@54);
    }];

    [_usDegreeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.suggestTitleLabel.mas_bottom).offset(14);
        make.right.equalTo(@0);
        make.width.equalTo(weakSelf.euroDegreeView.mas_width);
        make.left.equalTo(weakSelf.euroDegreeView.mas_right);
        make.height.equalTo(@54);
    }];
    [_leftPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.suggestTitleLabel.mas_bottom).offset(38);
        make.left.equalTo(weakSelf.hkDegreeView.mas_right).offset(-4);
        make.width.equalTo(@8);
        make.height.equalTo(@8);
    }];
    [_rightPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.suggestTitleLabel.mas_bottom).offset(38);
        make.right.equalTo(weakSelf.usDegreeView.mas_left).offset(-4);
        make.width.equalTo(@8);
        make.height.equalTo(@8);
    }];
    
    [_remeasureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@295);
        make.height.equalTo(@44);
        make.bottom.equalTo(@(-19));
        make.centerX.equalTo(weakSelf.imageView.mas_centerX);
    }];
}

- (void)loadData{
    _measureLabel.text = [NSString stringWithFormat:@"%0.1fmm", [_measure.width floatValue]];
    [_hkDegreeView loadWidth:kScreen_Width/3 degreeWidth:[_measure.width floatValue]];
    [_usDegreeView loadWidth:kScreen_Width/3 degreeWidth:[_measure.width floatValue]];
    [_euroDegreeView loadWidth:kScreen_Width/3 degreeWidth:[_measure.width floatValue]];

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
