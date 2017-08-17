//
//  EyeView.m
//  8.09
//
//  Created by 国恒金服 on 2017/8/17.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import "EyeView.h"


@interface EyeView ()

@property (nonatomic, strong)CAShapeLayer *eyeFirstLightLayer; // 眼白1
@property (nonatomic, strong)CAShapeLayer *eyeSecondLightLayer; // 眼白2
@property (nonatomic, strong)CAShapeLayer *eyeBallLayer; // 眼球
@property (nonatomic, strong)CAShapeLayer *topEyesocketLayer; // 上眼眶
@property (nonatomic, strong)CAShapeLayer *bottomEyesocketLayer; // 下眼眶

@end

@implementation EyeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer addSublayer:self.eyeFirstLightLayer];
        [self.layer addSublayer:self.eyeBallLayer];
        [self.layer addSublayer:self.eyeSecondLightLayer];
        [self.layer addSublayer:self.topEyesocketLayer];
        [self.layer addSublayer:self.bottomEyesocketLayer];
        
        
    }
    return self;
}

- (CAShapeLayer *)eyeFirstLightLayer
{
    if (_eyeFirstLightLayer == nil) {
        _eyeFirstLightLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:CGRectGetWidth(self.frame) *0.2
                                                        startAngle:230.0 / 180.0 * M_PI
                                                          endAngle:265.0 / 180.0 * M_PI
                                                         clockwise:YES];
        _eyeFirstLightLayer.path = path.CGPath;
        _eyeFirstLightLayer.strokeColor = [UIColor whiteColor].CGColor;
        _eyeFirstLightLayer.borderColor = [UIColor blackColor].CGColor;
        _eyeFirstLightLayer.fillColor = [UIColor clearColor].CGColor;
        _eyeFirstLightLayer.lineWidth = 5.f;
        
    }
    return _eyeFirstLightLayer;
}

- (CAShapeLayer *)eyeSecondLightLayer
{
    if (_eyeSecondLightLayer == nil) {
        _eyeSecondLightLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:CGRectGetWidth(self.frame) *0.2 startAngle:211.0 / 180 *M_PI endAngle:220.0 / 180.0 *M_PI clockwise:YES];
        _eyeSecondLightLayer.path = path.CGPath;
        _eyeSecondLightLayer.borderColor = [UIColor blackColor].CGColor;
        _eyeSecondLightLayer.fillColor = [UIColor clearColor].CGColor;
        _eyeSecondLightLayer.strokeColor = [UIColor whiteColor].CGColor;
        _eyeSecondLightLayer.lineWidth = 5.0;
    }
    return _eyeSecondLightLayer;
}

- (CAShapeLayer *)eyeBallLayer
{
    if (_eyeBallLayer == nil) {
        _eyeBallLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:CGRectGetHeight(self.frame) *0.5 startAngle:0 endAngle:M_PI *2 clockwise:YES];
        _eyeBallLayer.path = path.CGPath;
        _eyeBallLayer.fillColor = [UIColor clearColor].CGColor;
        _eyeBallLayer.strokeColor = [UIColor whiteColor].CGColor;
        _eyeBallLayer.lineWidth = 1.f;
    }
    return _eyeBallLayer;
}

- (CAShapeLayer *)topEyesocketLayer
{
    if (_topEyesocketLayer == nil) {
        _topEyesocketLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, CGRectGetHeight(self.frame) / 2)];
        [path addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 2) controlPoint:CGPointMake(CGRectGetWidth(self.frame) / 2, - 20)];
        _topEyesocketLayer.lineWidth = 1.f;
        _topEyesocketLayer.path = path.CGPath;
        _topEyesocketLayer.fillColor = [UIColor clearColor].CGColor;
        _topEyesocketLayer.strokeColor = [UIColor whiteColor].CGColor;
    }
    return _topEyesocketLayer;
}

- (CAShapeLayer *)bottomEyesocketLayer
{
    if (_bottomEyesocketLayer == nil) {
        _bottomEyesocketLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, CGRectGetHeight(self.frame) / 2)];
        [path addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 2) controlPoint:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) + 20)];
        _bottomEyesocketLayer.fillColor = [UIColor clearColor].CGColor;
        _bottomEyesocketLayer.strokeColor = [UIColor whiteColor].CGColor;
        _bottomEyesocketLayer.path = path.CGPath;
        _bottomEyesocketLayer.lineWidth = 1.f;
    }
    return _bottomEyesocketLayer;
}
@end
