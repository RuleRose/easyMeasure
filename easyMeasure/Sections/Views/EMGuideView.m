//
//  EMGuideView.m
//  easyMeasure
//
//  Created by qiwl on 2017/6/25.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "EMGuideView.h"
#import "EMGuideImageView.h"

#define VERMARGIN 5
#define HORMARGIN 10
#define DEFAULTTIME 5

@interface EMGuideView()<UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *hiddenBtn;

@end

@implementation EMGuideView
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.scrollsToTop = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.contentInset = UIEdgeInsetsZero;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.userInteractionEnabled = NO;
        CGSize size = [_pageControl sizeForNumberOfPages:_pageControl.numberOfPages];
        size.height = 8;
        _pageControl.frame = CGRectMake(0, 0, size.width, size.height);
        CGFloat centerY = self.frame.size.height - size.height * 0.5 - VERMARGIN;
        _pageControl.center = CGPointMake(self.frame.size.width * 0.5, centerY);
    }
    return _pageControl;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    _hiddenBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreen_Width - 100, 64, 80, 48)];
    _hiddenBtn.backgroundColor = [UIColor grayColor];
    [self addSubview:_hiddenBtn];
    [_hiddenBtn addTarget:self action:@selector(hiddenGuide) forControlEvents:UIControlEventTouchUpInside];
}

- (void)hiddenGuide{
    if (_delegate && [_delegate respondsToSelector:@selector(hiddenGuide)]) {
        [_delegate hiddenGuide];
    }
}

- (void)setImageNames:(NSArray *)imageNames{
    _imageNames = imageNames;
    if (!imageNames.count) return;
    _images = [NSMutableArray array];
    for (NSInteger i = 0; i < _imageNames.count; i++) {
        if ([_imageNames[i] isKindOfClass:[UIImage class]]) {
            [_images addObject:_imageNames[i]];
        } else if ([_imageNames[i] isKindOfClass:[NSString class]]){
            UIImage *image = kImage(_imageNames[i]);
            if (image) {
                [_images addObject:image];
            }else{
                if (_placeholderImage) {
                    [_images addObject:_placeholderImage];
                }else{
                    [_images addObject:[[UIImage alloc] init]];
                }
            }
        }
    }
    MJWeakSelf;
    for (NSInteger i = 0; i < _images.count; i ++) {
        EMGuideImageView *imageView = [[EMGuideImageView alloc] initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = _images[i];
        imageView.hiddenblock = ^(){
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(hiddenblock)]) {
                [weakSelf.delegate hiddenGuide];
            }
        };
        [_scrollView addSubview:imageView];
    }
    //防止在滚动过程中重新给imageArray赋值时报错
    if (_images.count > 1) {
        self.pageControl.numberOfPages = _images.count;
        _pageControl.hidden = NO;
    }else{
        self.pageControl.numberOfPages = _imageNames.count;
        _pageControl.hidden = YES;
    }
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * _images.count, self.frame.size.height);
    _pageControl.currentPage = 0;
}

#pragma mark- --------UIScrollViewDelegate--------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    
    NSInteger currentIndex = (offsetX + self.frame.size.width/2)/self.frame.size.width;
    self.pageControl.currentPage = currentIndex;
}

- (void)setPageColor:(UIColor *)color andCurrentPageColor:(UIColor *)currentColor {
    _pageControl.pageIndicatorTintColor = color;
    _pageControl.currentPageIndicatorTintColor = currentColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
