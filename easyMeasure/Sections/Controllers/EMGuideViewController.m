//
//  EMGuideViewController.m
//  easyMeasure
//
//  Created by qiwl on 2017/6/25.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "EMGuideViewController.h"
#import "EMGuideView.h"
#import "EMMainViewController.h"

@interface EMGuideViewController ()<EMGuideViewViewDelegate>
@property(nonatomic, strong) EMGuideView *guideView;
@end

@implementation EMGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    // Do any additional setup after loading the view.
}

- (void)setupViews{
    _guideView = [[EMGuideView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    _guideView.backgroundColor = [UIColor clearColor];
    _guideView.delegate = self;
    _guideView.imageNames = @[@"banner1",@"banner2", @"banner3",@"banner4"];
    [_guideView setPageColor:kColorFromRGB(0x999999) andCurrentPageColor:kColorFromRGB(0x666666)];
    [self.view addSubview:_guideView];
}

- (void)hiddenGuide{
    EMMainViewController *mainVC = [[EMMainViewController alloc] init];
    NSMutableArray* viewControllers = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
    [viewControllers removeAllObjects];
    [viewControllers addObject:mainVC];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.removedOnCompletion = YES;
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController setViewControllers:viewControllers animated:NO];
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
