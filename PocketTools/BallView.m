//
//  BallView.m
//  Tools
//
//  Created by 颜超 on 15/3/27.
//  Copyright (c) 2015年 颜超. All rights reserved.
//

#import "BallView.h"

#define pi 3.14159265359
#define DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)

@implementation BallView
- (void)setFrame:(CGRect)frame {
   [super setFrame:frame];
   [self setTitleEdgeInsets:UIEdgeInsetsMake(frame.size.width / 2, 0, 0, 0)];
}

- (void)setText:(NSString *)text {
    [self.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self setTitle:text forState:UIControlStateNormal];
}

- (void)reDraw {
    NSLog(@"%f", _per);
    [self setTitleEdgeInsets:UIEdgeInsetsMake(self.frame.size.width / 2, 0, 0, 0)];
    [self.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self drawRound];
}

- (void)drawRound {
    if(!_color) {
        _color = [UIColor whiteColor];
    }
    [_color set];  //设置线条颜色
    int start = -90;
    int end = 0;
    
    start  = 90 - (_per * 180);
    
    if (start >= 0 && start <= 90) {
        end = (90 - start) + 90;
    } else if (start < 0) {
        end = 180 + start * - 1;
    }
    
    CGRect frame = self.bounds;
    CGFloat mid_X = CGRectGetMidX(frame);
    CGFloat mid_Y = CGRectGetMidY(frame);
    
    UIBezierPath* aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(mid_X, mid_Y)
                                                         radius:mid_X
                                                     startAngle:DEGREES_TO_RADIANS(start)
                                                       endAngle:DEGREES_TO_RADIANS(end)
                                                      clockwise:YES];
    
    aPath.lineWidth = 1.0;
    aPath.lineCapStyle = kCGLineCapRound;  //线条拐角
    aPath.lineJoinStyle = kCGLineCapRound;  //终点处理
    
    [aPath stroke];
    [aPath fill];
}


@end
