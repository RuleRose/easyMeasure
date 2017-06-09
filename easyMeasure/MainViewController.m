//
//  MainViewController.m
//  easyMeasure
//
//  Created by qiwl on 2017/6/9.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "MainViewController.h"
#import "UIImage+Extension.h"
#import "MeasureButton.h"
#import "FingerChooseViewController.h"

@interface MainViewController ()
@property(nonatomic, strong)UILabel *measureNotiLabel;
@property(nonatomic, strong)MeasureButton *leftFingerBtn;
@property(nonatomic, strong)MeasureButton *rightFingerBtn;
@property(nonatomic, strong)UIImageView *iconView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测量手指";
    self.view.backgroundColor = kColorFromRGB(0xffffff);
    [self setupViews];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationButtons:1 title:nil image:@[[UIImage imageNamed:@"titel_button_jilu"]] highlightedImage:@[[UIImage imageNamed:@"titel_button_jilu_highlight"]] frame:nil isRight:YES];
}

- (void)setupViews{
    _measureNotiLabel = [[UILabel alloc] init];
    _measureNotiLabel.backgroundColor = [UIColor clearColor];
    _measureNotiLabel.text = @"请选择要测量的手";
    _measureNotiLabel.textColor = kColor_Text1;
    _measureNotiLabel.font = [UIFont systemFontOfSize:16];
    _measureNotiLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_measureNotiLabel];
    
    _iconView = [[UIImageView alloc] init];
    _iconView.backgroundColor = [UIColor clearColor];
    _iconView.image = kImage(@"image");
    [self.view addSubview:_iconView];
    MJWeakSelf;
    _leftFingerBtn = [[MeasureButton alloc] init];
    _leftFingerBtn.layer.masksToBounds = YES;
    _leftFingerBtn.layer.cornerRadius = 24;
    _leftFingerBtn.normalColor = kColor_Button1;
    _leftFingerBtn.highlightColor = kColor_Highlight_Button3;
    [_leftFingerBtn setTitle:@"测量左手" forState:UIControlStateNormal];
    [_leftFingerBtn setTitleColor:kColor_Text1 forState:UIControlStateNormal];
    _leftFingerBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _leftFingerBtn.measureBlock = ^(){
        FingerChooseViewController *chooseVC = [[FingerChooseViewController alloc] init];
        chooseVC.isLeft = YES;
        [chooseVC pushToNavigationController:weakSelf.navigationController animated:YES];
    };
    [self.view addSubview:_leftFingerBtn];
    
    _rightFingerBtn = [[MeasureButton alloc] init];
    _rightFingerBtn.layer.masksToBounds = YES;
    _rightFingerBtn.layer.cornerRadius = 24;
    _rightFingerBtn.normalColor = kColor_Button1;
    _rightFingerBtn.highlightColor = kColor_Highlight_Button3;
    [_rightFingerBtn setTitle:@"测量右手" forState:UIControlStateNormal];
    [_rightFingerBtn setTitleColor:kColor_Text1 forState:UIControlStateNormal];
    _rightFingerBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _rightFingerBtn.measureBlock = ^(){
        FingerChooseViewController *chooseVC = [[FingerChooseViewController alloc] init];
        chooseVC.isLeft = NO;
        [chooseVC pushToNavigationController:weakSelf.navigationController animated:YES];
    };
    [self.view addSubview:_rightFingerBtn];
    [_measureNotiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@(60 + kNavigationHeight + kStatusHeight));
        make.right.equalTo(@0);
        make.height.equalTo(@24);
    }];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.measureNotiLabel.mas_bottom).offset(35);
        make.centerX.equalTo(weakSelf.measureNotiLabel.mas_centerX);
        make.height.equalTo(@176);
        make.width.equalTo(@176);
    }];
    [_leftFingerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@19);
        make.top.equalTo(weakSelf.iconView.mas_bottom).offset(49);
        make.right.equalTo(weakSelf.rightFingerBtn.mas_left).offset(-21);
        make.height.equalTo(@48);
        make.width.equalTo(weakSelf.rightFingerBtn.mas_width);
    }];
    [_rightFingerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-19));
        make.top.equalTo(weakSelf.iconView.mas_bottom).offset(49);
        make.left.equalTo(weakSelf.leftFingerBtn.mas_right).offset(21);
        make.height.equalTo(@48);
        make.width.equalTo(weakSelf.rightFingerBtn.mas_width);
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
