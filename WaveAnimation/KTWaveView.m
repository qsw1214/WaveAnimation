//
//  KTWaveView.m
//  WaveAnimation
//
//  Created by qiusenwei on 2017/1/2.
//  Copyright © 2017年 qiusen. All rights reserved.
//

#import "KTWaveView.h"
#import <QuartzCore/QuartzCore.h>

@interface KTWaveView (){
    CADisplayLink *_displayLink;
}

@property(nonatomic, assign)AnimationStatus animationStatus;
@property(nonatomic, assign)CGFloat offsetX;
@property(nonatomic, assign)CGFloat cycle;
@property(nonatomic, assign)CGFloat amplitude; //振幅
@property(nonatomic, assign)CGFloat speed; //角速度
@property(nonatomic, assign)CGFloat pointY;
@property(nonatomic, strong)CAShapeLayer *shapeLayer;
@end

@implementation KTWaveView

-(instancetype)initWithFrame:(CGRect)frame startAnimated:(BOOL)animated{
    self = [self initWithFrame:frame];
    if(self){
        if(animated){
            [self startWaveAnimation];
        }
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setUp];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self setUp];
    }
    return self;
}

- (void)setUp{
    self.backgroundColor = [UIColor clearColor];
    self.amplitude = 15.0;
    self.offsetX = 0;
    self.speed = 0.25/M_PI;
    self.cycle =  1.29 * M_PI / self.frame.size.width;
    self.pointY = self.frame.size.height - 50;
}

- (void)startWaveAnimation{
    if(self.animationStatus){
        if(self.animationStatus == AnimationStatusOrigin2){
            return ;
        }else if(self.animationStatus == AnimationStatusFinal){
            [_displayLink setPaused:NO];
        }
    }else{
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkRefresh:)];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    [self setAnimationStatus:AnimationStatusOrigin2];
}

- (void)pauseWaveAnimation{
    if(self.isAnimating){
        [_displayLink setPaused:YES];
        [self setAnimationStatus:AnimationStatusFinal];
    }
}

- (void)removeWaveAnimation{
    if(self.animationStatus){
        [_displayLink invalidate];
        _displayLink = nil;
        [self setAnimationStatus:AnimationStatusOrigin];
    }
}

-(void)drawRect:(CGRect)rect{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0.0, _pointY);
    for (CGFloat x = 0; x < CGRectGetWidth(rect); x += 1) {
        CGFloat y = _amplitude * sinf(x * _cycle + _offsetX) + _pointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, CGRectGetWidth(rect), CGRectGetHeight(rect));
    CGPathAddLineToPoint(path, nil, 0.0, CGRectGetHeight(rect));
    CGPathCloseSubpath(path);
    [self.shapeLayer setPath:path];
    CGPathRelease(path);
}

- (void)displayLinkRefresh:(CADisplayLink *)link {
    self.offsetX += _speed;
    [self setNeedsDisplay];
}

- (BOOL)isAnimating{
    if(self.animationStatus != AnimationStatusOrigin2){
        return NO;
    }
    return YES;
}

-(CAShapeLayer *)shapeLayer{
    if(!_shapeLayer){
        _shapeLayer = [CAShapeLayer layer];
        [_shapeLayer setFillColor:[UIColor colorWithWhite:0.35 alpha:1.0].CGColor];
        [self.layer addSublayer:_shapeLayer];
    }
    return _shapeLayer;
}

@end
