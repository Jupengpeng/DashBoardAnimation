//
//  ViewController.m
//  DashBoardAnimation
//
//  Created by 鞠鹏 on 16/5/24.
//  Copyright © 2016年 鞠鹏. All rights reserved.
//


#import "ViewController.h"
#import "DashBoardView.h"
@interface ViewController ()

@property (nonatomic,strong) DashBoardView *dashBoardView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"仪表盘显示";
    
    self.dashBoardView = [[DashBoardView alloc] initsWithFrame:CGRectMake(0, 164, SCREEN_WIDTH, SCREEN_WIDTH) middleNum:18 leftNum:15 rightNum:50 middleBaseNum:24 leftBaseNum:30 rightBaseNum:51];
    self.dashBoardView.layer.borderWidth = 1.0f;
    self.dashBoardView.layer.borderColor = UIColorFromRGB(0xff5000).CGColor;
    [self.view addSubview:self.dashBoardView];
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
