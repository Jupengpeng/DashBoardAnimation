//
//  DashBoardView.m
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

#import "DashBoardView.h"

@interface DashBoardView ()

@property (nonatomic,strong) CAShapeLayer *loadingBaseLayer;

@property (nonatomic,strong) CAShapeLayer *loadingLayer;

@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation DashBoardView

- (instancetype)initsWithFrame:(CGRect)frame  middleNum:(NSInteger)middleNum leftNum:(NSInteger)leftNum rightNum:(NSInteger)rightNum middleBaseNum:(CGFloat)middleBaseNum leftBaseNum:(CGFloat)leftBaseNum rightBaseNum:(CGFloat)rightBaseNum{
    
    if (self == [super init]) {
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 150);
        _leftNum = leftNum;
        _leftBaseNum = leftBaseNum;
        _rightNum = rightNum;
        _rightBaseNum = rightBaseNum;
        _middleNum = middleNum;
        _middleBaseNum = middleBaseNum;
        [self setupBaseLine];
        [self setupLabelsWithMiddleNum:middleNum leftNum:leftNum rightNum:rightNum];
        
        
        
        
    }
    
    return self;
}

- (void)setupBaseLine{
    
    self.loadingBaseLayer = [self drawCircleWithFillColor:[UIColor clearColor] LineColor:GreyColor frame:CGRectMake(0, 0, 108, 108) lineWidth:5.0f];
    
    // 这个是用于指定画笔的开始与结束点
    self.loadingBaseLayer.strokeStart = 0;
    self.loadingBaseLayer.strokeEnd = 1;
    
    CGFloat baseRound = 0.12;
    
    for (NSInteger i = 0; i < 12; i ++) {
        NSInteger index;
        if (i >= 6) {
            baseRound = 0.63;
            index = i - 6;
        }
        else{
            index = i;
        }
        CAShapeLayer *leftBaseLayer = [self drawCircleWithFillColor:[UIColor clearColor] LineColor:GreyColor frame:CGRectMake(0, 0, 180, 180) lineWidth:5.0f];
        
        leftBaseLayer.transform = CATransform3DMakeRotation(M_PI/2, 0, 0, 1); // 顺时针旋转90°
        
        CGFloat padding = 0.005; // 小段之间的间隔
        CGFloat singeLine = (0.25 - 5*padding)/6; // 每一小段的宽度
        
        leftBaseLayer.strokeStart = baseRound +  (singeLine+ padding) * index;
        leftBaseLayer.strokeEnd =  baseRound + singeLine * (index + 1) + padding*index;
    }
    
    self.loadingLayer = [self drawCircleWithFillColor:[UIColor clearColor] LineColor:GreenColor frame:CGRectMake(0, 0, 108, 108) lineWidth:5.0f];
    
    self.loadingLayer.transform = CATransform3DMakeRotation(M_PI/2, 0, 0, 1);
    
    self.loadingLayer.strokeStart = 0;
    self.loadingLayer.strokeEnd =  0;
    
    CGFloat leftDegree = self.leftNum / self.leftBaseNum;
    CGFloat middleDegree = self.middleNum/self.middleBaseNum;
    CGFloat rightDegree = self.rightNum/self.rightBaseNum;
    
    [self setupShowAnimationWithLeftDegree:leftDegree middle:middleDegree right:rightDegree];
}

- (void)setupShowAnimationWithLeftDegree:(CGFloat)leftDegree middle:(CGFloat)middleDegree right:(CGFloat)rightDegree{
    
    //    左边
    
    //        ====== ====== ====== ====== ====== ====== ====== ====== ====== ====== ====== ====== ====== ======
    /**
     *  每1/6 为一格，
     *  查看有几个1/6,
     *
     */
    NSInteger leftCount  = (leftDegree * 6 *10)/10;
    
    /**
     *  最后一个中的比例
     */
    CGFloat leftEndDegree = leftDegree - leftCount /6.0f;
    
    NSLog(@"leftCount --- %ld,leftEndDegree --- %f" , leftCount , leftEndDegree);
    
    //右边
    
    //        ====== ====== ====== ====== ====== ====== ====== ====== ====== ====== ====== ====== ====== ======
    NSInteger rightCount  = (rightDegree * 6 *10)/10;
    
    /**
     *  最后一个中的比例
     */
    CGFloat rightEndDegree = rightDegree - rightCount /6.0f ;
    
    NSLog(@"leftCount --- %ld,leftEndDegree --- %f" , rightCount , rightEndDegree);
    
    
    /**
     *  显示结果
     */
    
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        /**
         *  左边
         */
        //        ====== ====== ====== ====== ====== ====== ====== ====== ====== ====== ====== ====== ====== ======
        CGFloat leftBaseRound = 0.12;
        NSInteger leftTotalCount = 0;
        
        if (!leftEndDegree) {
            leftTotalCount = leftCount;
        }else{
            leftTotalCount = leftCount + 1;
        }
        for (NSInteger i = 0; i < leftTotalCount; i ++) {
            NSInteger index  ;
            index = i ;
            /**
             *  单独处理最后一个
             */
            if (i == leftTotalCount - 1  &&
                leftTotalCount > leftCount) {
                
                CAShapeLayer *leftBaseLayer = [self drawCircleWithFillColor:[UIColor clearColor] LineColor:RedColor frame:CGRectMake(0, 0, 180, 180) lineWidth:5.0f];
                
                leftBaseLayer.transform = CATransform3DMakeRotation(M_PI/2, 0, 0, 1);
                
                CGFloat padding = 0.005;
                CGFloat singeLine = (0.25 -5*padding)/6;
                
                leftBaseLayer.strokeStart = leftBaseRound +  (singeLine+ padding) * index;
                leftBaseLayer.strokeEnd =  leftBaseRound +  (singeLine+ padding) * index + leftEndDegree*6*singeLine ;
            }else{
                
                CAShapeLayer *leftBaseLayer = [self drawCircleWithFillColor:[UIColor clearColor] LineColor:RedColor frame:CGRectMake(0, 0, 180, 180) lineWidth:5.0f];
                
                leftBaseLayer.transform = CATransform3DMakeRotation(M_PI/2, 0, 0, 1);
                
                CGFloat padding = 0.005;
                CGFloat singeLine = (0.25 -5*padding)/6;
                
                leftBaseLayer.strokeStart = leftBaseRound +  (singeLine+ padding) * index;
                leftBaseLayer.strokeEnd =  leftBaseRound + singeLine * (index + 1) + padding*index;
                
            }
        }
        /**
         *  右边
         */
        //        ====== ====== ====== ====== ====== ====== ====== ====== ====== ====== ====== ====== ====== ======
        
        CGFloat rightBaseRound = 0.88;
        NSInteger rightTotalCount = 0;
        
        if (!rightDegree) {
            rightTotalCount = rightCount;
        }else{
            rightTotalCount = rightCount + 1;
        }
        for (NSInteger i = 0; i < rightTotalCount; i ++) {
            NSInteger index  ;
            index = i ;
            /**
             *  单独处理最后一个
             */
            if (i == rightTotalCount - 1  &&
                rightTotalCount > rightCount) {
                
                CAShapeLayer *rightBaseLayer = [self drawCircleWithFillColor:[UIColor clearColor] LineColor:YellowColor frame:CGRectMake(0, 0, 180, 180) lineWidth:5.0f];
                
                rightBaseLayer.transform = CATransform3DMakeRotation(M_PI/2, 0, 0, 1);
                
                CGFloat padding = 0.005;
                CGFloat singeLine = (0.25 -5*padding)/6;
                
                rightBaseLayer.strokeEnd = rightBaseRound -  (singeLine+ padding) * index;
                rightBaseLayer.strokeStart =  rightBaseRound -  (singeLine+ padding) * index - rightEndDegree*6*singeLine ;
            }else{
                
                CAShapeLayer *rightBaseLayer = [self drawCircleWithFillColor:[UIColor clearColor] LineColor:YellowColor frame:CGRectMake(0, 0, 180, 180) lineWidth:5.0f];
                
                rightBaseLayer.transform = CATransform3DMakeRotation(M_PI/2, 0, 0, 1);
                
                CGFloat padding = 0.005;
                CGFloat singeLine = (0.25 -5*padding)/6;
                
                rightBaseLayer.strokeEnd = rightBaseRound -  (singeLine+ padding) * index;
                rightBaseLayer.strokeStart =  rightBaseRound - singeLine * (index + 1) - padding*index;
            }
        }
        /**
         *  中间圆形
         */
        
        //        ====== ====== ====== ====== ====== ====== ====== ====== ====== ====== ====== ====== ====== ======
        self.loadingLayer.strokeStart = 0;
        self.loadingLayer.strokeEnd =  middleDegree;
        //执行事件
    });
}


/**
 *  添加左 中 右的文字
 */
- (void)setupLabelsWithMiddleNum:(NSInteger)middleNum leftNum:(NSInteger)leftNum rightNum:(NSInteger)rightNum{
    
    NSString *middleStr= [NSString stringWithFormat:@"行驶里程\n%ldkm",middleNum];
    UILabel *middleLabel  = [[UILabel  alloc] initWithFrame:CGRectMake(0, 0, 108, 108)];
    middleLabel.center = CGPointMake(self.loadingLayer.frame.origin.x + self.loadingLayer.frame.size.width * 0.5,
                                     self.loadingLayer.frame.origin.y + self.loadingLayer.frame.size.height * 0.5);
    middleLabel.textAlignment = NSTextAlignmentCenter;
    middleLabel.numberOfLines = 0 ;
    [self addSubview:middleLabel];
    
    middleLabel.backgroundColor = [UIColor clearColor];
    
    NSDictionary *middleAttributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                         
                                         [UIFont systemFontOfSize:14.0],NSFontAttributeName,
                                         
                                         GreenColor,NSForegroundColorAttributeName,
                                         
                                         //                                   NSUnderlineStyleAttributeName,NSUnderlineStyleSingle,
                                         nil];
    
    NSMutableAttributedString *middleAttributeStr= [[NSMutableAttributedString alloc] initWithString:middleStr attributes:middleAttributeDict];
    
    [middleAttributeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:35.0f] range:NSMakeRange(5, 2)];
    [middleAttributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11.0f] range:NSMakeRange(middleStr.length - 2, 2)];
    middleLabel.attributedText = middleAttributeStr;
    
    NSString *leftStr= [NSString stringWithFormat:@"%ldL\n油耗\n（百公里）",leftNum];
    UILabel *leftLabel  = [[UILabel  alloc] initWithFrame:CGRectMake(0, 0, 80, 108)];
    leftLabel.center = CGPointMake(SCREEN_WIDTH/2.0f - 130.0f, self.loadingLayer.frame.origin.y + self.loadingLayer.frame.size.height * 0.5);
    leftLabel.textAlignment = NSTextAlignmentCenter;
    leftLabel.numberOfLines = 0 ;
    [self addSubview:leftLabel];
    
    leftLabel.backgroundColor = [UIColor clearColor];
    
    
    NSDictionary *leftAttributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                       
                                       
                                       RedColor,NSForegroundColorAttributeName,
                                       
                                       //                                   NSUnderlineStyleAttributeName,NSUnderlineStyleSingle,
                                       nil];
    
    NSMutableAttributedString *leftAttributeStr= [[NSMutableAttributedString alloc] initWithString:leftStr attributes:leftAttributeDict];
    
    
    [leftAttributeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:25.0f] range:NSMakeRange(0, 2)];
    [leftAttributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11.0f] range:NSMakeRange(2, 1)];
    [leftAttributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:NSMakeRange(5, 2)];
    [leftAttributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9.0f] range:NSMakeRange(leftStr.length - 5,5)];
    leftLabel.attributedText = leftAttributeStr;
    
    
    NSString *rightStr= [NSString stringWithFormat:@"%ldmin\n用时",rightNum];
    UILabel *rightLabel  = [[UILabel  alloc] initWithFrame:CGRectMake(0, 0, 80, 108)];
    rightLabel.center = CGPointMake(SCREEN_WIDTH/2.0f + 130.0f, self.loadingLayer.frame.origin.y + self.loadingLayer.frame.size.height * 0.5);
    rightLabel.textAlignment = NSTextAlignmentCenter;
    rightLabel.numberOfLines = 0 ;
    [self addSubview:rightLabel];
    
    rightLabel.backgroundColor = [UIColor clearColor];
    
    
    
    NSDictionary *rightAttributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                        
                                        
                                        YellowColor,NSForegroundColorAttributeName,
                                        
                                        //                                   NSUnderlineStyleAttributeName,NSUnderlineStyleSingle,
                                        nil];
    
    NSMutableAttributedString *rightAttributeStr= [[NSMutableAttributedString alloc] initWithString:rightStr attributes:rightAttributeDict];
    
    
    [rightAttributeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:25.0f] range:NSMakeRange(0, 2)];
    [rightAttributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11.0f] range:NSMakeRange(2, 3)];
    [rightAttributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:NSMakeRange(rightStr.length - 2, 2)];
    
    rightLabel.attributedText = rightAttributeStr;
}

- (CAShapeLayer *)drawCircleWithFillColor:(UIColor *)fillColor LineColor:(UIColor *)lineColor frame:(CGRect)myFrame lineWidth:(CGFloat)lineWidth {
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    // 指定frame，只是为了设置宽度和高度
    circleLayer.frame = myFrame;
    //    CGRectMake(0, 0, 200, 200);
    // 设置居中显示
    circleLayer.position = CGPointMake(SCREEN_WIDTH/2.0f, 75);
    //    self.center;
    // 设置填充颜色
    circleLayer.fillColor = fillColor.CGColor;
    // 设置线宽
    circleLayer.lineWidth = lineWidth;
    // 设置线的颜色
    circleLayer.strokeColor = lineColor.CGColor;
    
    // 使用UIBezierPath创建路径
    //    CGRect frame = CGRectMake(0, 0, 200, 200);
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:myFrame];
    
    // 设置CAShapeLayer与UIBezierPath关联
    circleLayer.path = circlePath.CGPath;
    
    // 将CAShaperLayer放到某个层上显示
    [self.layer addSublayer:circleLayer];
    
    return circleLayer;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
