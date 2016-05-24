//
//  DashBoardView.h
//  DashBoardAnimation
//
//  Created by 鞠鹏 on 16/5/24.
//  Copyright © 2016年 鞠鹏. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define GreyColor   UIColorFromRGB(0xe2e7ec)
#define RedColor    UIColorFromRGB(0xfd5878)
#define YellowColor UIColorFromRGB(0xfeb635)
#define GreenColor  UIColorFromRGB(0x34bdb3)
#import <UIKit/UIKit.h>

@interface DashBoardView : UIView

/**
 *  中间的数字
 */
@property (nonatomic,assign) NSInteger middleNum;

/**
 *  左边的数字
 */
@property (nonatomic,assign) NSInteger leftNum;


/**
 *  右边的数字
 */
@property (nonatomic,assign) NSInteger rightNum;

/**
 *  左边的基数
 */
@property (nonatomic,assign) CGFloat leftBaseNum;
/**
 *  中间的基数
 */
@property (nonatomic,assign) CGFloat middleBaseNum;
/**
 *  右边的基数
 */
@property (nonatomic,assign) CGFloat rightBaseNum;



- (instancetype)initsWithFrame:(CGRect)frame  middleNum:(NSInteger)middleNum leftNum:(NSInteger)leftNum rightNum:(NSInteger)rightNum middleBaseNum:(CGFloat)middleBaseNum leftBaseNum:(CGFloat)leftBaseNum rightBaseNum:(CGFloat)rightBaseNum;
@end
