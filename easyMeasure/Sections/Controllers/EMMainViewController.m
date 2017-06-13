//
//  MainViewController.m
//  easyMeasure
//
//  Created by qiwl on 2017/6/9.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "EMMainViewController.h"
#import "EMMainView.h"

@interface EMMainViewController ()
@property(nonatomic, strong)EMMainView *mainView;

@end

@implementation EMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorFromRGB(0xffffff);
    UIImageView *titleView = [[UIImageView alloc] initWithImage:kImage(@"titel_text")];
    titleView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleView;
    [self setupViews];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationButtons:1 title:nil image:@[[UIImage imageNamed:@"titel_button_jilu"]] highlightedImage:@[[UIImage imageNamed:@"titel_button_jilu_highlight"]] frame:nil isRight:YES];
}

- (void)setupViews{
    _mainView = [[EMMainView alloc] init];
    _mainView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_mainView];
    MJWeakSelf;
    _mainView.leftFingerBtn.measureBlock = ^(){
        EMFingerChooseViewController *chooseVC = [[EMFingerChooseViewController alloc] init];
        chooseVC.isLeft = YES;
        [chooseVC pushToNavigationController:weakSelf.navigationController animated:YES];
    };
    _mainView.rightFingerBtn.measureBlock = ^(){
        EMFingerChooseViewController *chooseVC = [[EMFingerChooseViewController alloc] init];
        chooseVC.isLeft = NO;
        [chooseVC pushToNavigationController:weakSelf.navigationController animated:YES];
    };
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}

- (void)navigationRightButtonClicked:(UIButton *)sender {
    EMResultsListViewController *listVC = [[EMResultsListViewController alloc] init];
    [listVC pushToNavigationController:self.navigationController animated:YES];
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
