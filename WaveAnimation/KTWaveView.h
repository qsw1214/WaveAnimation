//
//  KTWaveView.h
//  WaveAnimation
//
//  Created by qiusenwei on 2017/1/2.
//  Copyright © 2017年 qiusen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AnimationStatus) {
    AnimationStatusOrigin = 0,
    AnimationStatusOrigin2,
    AnimationStatusFinal,
};

@interface KTWaveView : UIView

- (void)startWaveAnimation;

@end
