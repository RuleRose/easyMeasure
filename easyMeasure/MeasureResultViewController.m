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

@interface MeasureResultViewController ()
@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic, strong)UILabel *measureTitleLabel;
@property(nonatomic, strong)UILabel *measureLabel;
@property(nonatomic, strong)UILabel *suggestTitleLabel;
@property(nonatomic, strong)UILabel *hkDegreeTitleLabel;
@property(nonatomic, strong)UILabel *hkDegreeLabel;
@property(nonatomic, strong)UILabel *euroDegreeTitleLabel;
@property(nonatomic, strong)UILabel *euroDegreeLabel;
@property(nonatomic, strong)UILabel *usDegreeTitleLabel;
@property(nonatomic, strong)UILabel *usDegreeLabel;
@property(nonatomic, strong)MeasureButton *remeasureBtn;
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
    _measureLabel.font = [UIFont systemFontOfSize:40];
    _measureLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_measureLabel];
    _suggestTitleLabel = [[UILabel alloc] init];
    _suggestTitleLabel.backgroundColor = [UIColor clearColor];
    _suggestTitleLabel.text = @"建议您挑选戒指的尺寸为";
    _suggestTitleLabel.textColor = kColor_Text2;
    _suggestTitleLabel.font = [UIFont systemFontOfSize:15];
    _suggestTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_suggestTitleLabel];
    
    _hkDegreeTitleLabel = [[UILabel alloc] init];
    _hkDegreeTitleLabel.backgroundColor = [UIColor clearColor];
    _hkDegreeTitleLabel.text = @"港度";
    _hkDegreeTitleLabel.textColor = kColor_Text2;
    _hkDegreeTitleLabel.font = [UIFont systemFontOfSize:15];
    _hkDegreeTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_hkDegreeTitleLabel];
    _hkDegreeLabel = [[UILabel alloc] init];
    _hkDegreeLabel.backgroundColor = [UIColor clearColor];
    _hkDegreeLabel.textColor = kColor_Text5;
    _hkDegreeLabel.font = [UIFont systemFontOfSize:40];
    _hkDegreeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_hkDegreeLabel];
    
    _euroDegreeTitleLabel = [[UILabel alloc] init];
    _euroDegreeTitleLabel.backgroundColor = [UIColor clearColor];
    _euroDegreeTitleLabel.text = @"欧度";
    _euroDegreeTitleLabel.textColor = kColor_Text2;
    _euroDegreeTitleLabel.font = [UIFont systemFontOfSize:15];
    _euroDegreeTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_euroDegreeTitleLabel];
    _euroDegreeLabel = [[UILabel alloc] init];
    _euroDegreeLabel.backgroundColor = [UIColor clearColor];
    _euroDegreeLabel.textColor = kColor_Text5;
    _euroDegreeLabel.font = [UIFont systemFontOfSize:40];
    _euroDegreeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_euroDegreeLabel];
    _usDegreeTitleLabel = [[UILabel alloc] init];
    _usDegreeTitleLabel.backgroundColor = [UIColor clearColor];
    _usDegreeTitleLabel.text = @"美度";
    _usDegreeTitleLabel.textColor = kColor_Text2;
    _usDegreeTitleLabel.font = [UIFont systemFontOfSize:15];
    _usDegreeTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_usDegreeTitleLabel];
    _usDegreeLabel = [[UILabel alloc] init];
    _usDegreeLabel.backgroundColor = [UIColor clearColor];
    _usDegreeLabel.textColor = kColor_Text5;
    _usDegreeLabel.font = [UIFont systemFontOfSize:40];
    _usDegreeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_usDegreeLabel];
    
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
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@(kNavigationHeight + kStatusHeight));
        make.right.equalTo(@0);
        make.height.equalTo(@235);
    }];
    [_measureTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(weakSelf.imageView.mas_bottom).offset(35);
        make.height.equalTo(@24);
    }];
    [_measureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(weakSelf.measureTitleLabel.mas_bottom).offset(18);
        make.height.equalTo(@48);
    }];
    [_suggestTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(weakSelf.measureLabel.mas_bottom).offset(45);
        make.height.equalTo(@24);
    }];
    [_euroDegreeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.suggestTitleLabel.mas_bottom).offset(22);
        make.left.equalTo(weakSelf.hkDegreeTitleLabel.mas_right);
        make.right.equalTo(weakSelf.usDegreeTitleLabel.mas_left);
        make.height.equalTo(@24);
    }];
    [_hkDegreeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.suggestTitleLabel.mas_bottom).offset(22);
        make.left.equalTo(@0);
        make.width.equalTo(weakSelf.euroDegreeTitleLabel.mas_width);
        make.right.equalTo(weakSelf.euroDegreeTitleLabel.mas_left);
        make.height.equalTo(@24);
    }];
    [_usDegreeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.suggestTitleLabel.mas_bottom).offset(22);
        make.right.equalTo(@0);
        make.width.equalTo(weakSelf.euroDegreeTitleLabel.mas_width);
        make.left.equalTo(weakSelf.euroDegreeTitleLabel.mas_right);
        make.height.equalTo(@24);
    }];

    [_hkDegreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.hkDegreeTitleLabel.mas_left);
        make.top.equalTo(weakSelf.hkDegreeTitleLabel.mas_bottom);
        make.right.equalTo(weakSelf.hkDegreeTitleLabel.mas_right);
        make.height.equalTo(@48);
    }];
    [_euroDegreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.euroDegreeTitleLabel.mas_left);
        make.top.equalTo(weakSelf.euroDegreeTitleLabel.mas_bottom);
        make.right.equalTo(weakSelf.euroDegreeTitleLabel.mas_right);
        make.height.equalTo(@48);
    }];
    [_usDegreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.usDegreeTitleLabel.mas_left);
        make.top.equalTo(weakSelf.usDegreeTitleLabel.mas_bottom);
        make.right.equalTo(weakSelf.usDegreeTitleLabel.mas_right);
        make.height.equalTo(@48);
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
    _hkDegreeLabel.text = [NSString stringWithFormat:@"%0.1f",[[EMScreenSizeManager defaultInstance] hkdegreeWithWidth:[_measure.width floatValue]]];
    _usDegreeLabel.text = [NSString stringWithFormat:@"%0.1f",[[EMScreenSizeManager defaultInstance] usdegreeWithWidth:[_measure.width floatValue]]];
    _euroDegreeLabel.text = [NSString stringWithFormat:@"%0.1f",[[EMScreenSizeManager defaultInstance] eurodegreeWithWidth:[_measure.width floatValue]]];


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
