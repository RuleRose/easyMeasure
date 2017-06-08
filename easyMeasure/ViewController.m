//
//  ViewController.m
//  easyMeasure
//
//  Created by yongche on 17/5/19.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "ViewController.h"
#import "EMScreenSizeManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[EMScreenSizeManager defaultInstance] widthOfOnePoint];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
