//
//  MeasurementViewController.m
//  easyMeasure
//
//  Created by qiwl on 2017/6/10.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "MeasurementViewController.h"

@interface MeasurementViewController ()
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) NSArray *imageArr;
@end

@implementation MeasurementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测量说明";
    self.view.backgroundColor = kColorFromRGB(0xffffff);
    if (_fingerType == kFingerOfThumb) {
        _imageArr = @[@"2_01",@"2_02",@"2_03",@"2_04",@"2_05"];
    }else{
        _imageArr = @[@"1_02",@"1_03",@"1_04",@"1_05",@"1_06"];
    }
    [self setupViews];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setBackBarButton];
}

- (void)setupViews{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView];
    CGFloat y = 0;
    for (NSString *imageStr in _imageArr) {
        UIImage *image = kImage(imageStr);
        CGSize imageSize = image.size;
        CGFloat height = 0;
        if (imageSize.width != 0) {
            height = kScreen_Width*imageSize.height/imageSize.width;
        }
        UIImageView *measurement = [[UIImageView alloc] initWithFrame:CGRectMake(0, y, kScreen_Width, height)];
        measurement.backgroundColor = [UIColor clearColor];
        measurement.image = image;
        [_scrollView addSubview:measurement];
        y += height;
    }
    _scrollView.contentSize = CGSizeMake(kScreen_Width, y);
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
