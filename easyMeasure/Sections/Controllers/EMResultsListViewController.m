//
//  ResultsListViewController.m
//  easyMeasure
//
//  Created by qiwl on 2017/6/10.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "EMResultsListViewController.h"
#import "EMResultsListView.h"
#import "XJFDBManager.h"
#import "EMMeasureModel.h"
#import "EMMeasureResultViewController.h"

@interface EMResultsListViewController ()<EMResultsListViewDelegate>
@property(nonatomic,strong)NSMutableArray *measures;
@property(nonatomic, strong)EMResultsListView *resultView;

@end

@implementation EMResultsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"历史记录";
    self.view.backgroundColor = kColorFromRGB(0xefefef);
    _measures = [[NSMutableArray alloc] init];
    [self setupViews];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setBackBarButton];
    [self setNavigationButtons:1 title:@[kLocalization(@"em_clear")] image:nil highlightedImage:nil frame:@[[NSValue valueWithCGRect:CGRectMake(0, 0, 64, 44)]] isRight:YES];
    [self loadData];
}

- (void)setupViews{
    _resultView = [[EMResultsListView alloc] init];
    _resultView.backgroundColor = [UIColor clearColor];
    _resultView.delegate = self;
    [self.view addSubview:_resultView];
    [_resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}

- (void)loadData{
    EMMeasureModel *measureModel = [[EMMeasureModel alloc] init];
    NSArray *result = [XJFDBManager searchModelsWithCondition:measureModel andpage:-1 andOrderby:@"measure_time" isAscend:NO];
    [_measures removeAllObjects];
    [_measures addObjectsFromArray:result];
    _resultView.measures = _measures;
}

#pragma mark EMResultsListViewDelegate
- (void)showResultWithMeasure:(EMMeasureModel *)measure{
    EMMeasureResultViewController *resultVC = [[EMMeasureResultViewController alloc] init];
    resultVC.measure = measure;
    [resultVC pushToNavigationController:self.navigationController animated:YES];
}

- (void)navigationRightButtonClicked:(UIButton *)sender {
    if ([_measures count] > 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:kLocalization(@"em_noti_clear") preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:kLocalization(@"em_cancel") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:cancelAction];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:kLocalization(@"em_confirm") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //清空
            [XJFDBManager clearTableModel:[[EMMeasureModel alloc] init]];
            [_measures removeAllObjects];
            _resultView.measures = _measures;
        }];
        [alertController addAction:confirmAction];
        [self.navigationController presentViewController:alertController animated:YES completion:nil];
    }
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
