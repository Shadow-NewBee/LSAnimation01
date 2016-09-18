//
//  Lai_CircleLayer.m
//  LSLearnAni01
//
//  Created by xiaoT on 16/4/2.
//  Copyright © 2016年 赖三聘. All rights reserved.
//

#import "Lai_CircleLayer.h"
#import <UIKit/UIKit.h>

typedef enum MovePoint {
    POINT_D,
    POINT_B,
} MovewPoint;

#define outRectSize 90

@interface Lai_CircleLayer()

@property (nonatomic, assign) CGRect outRect;

@property (nonatomic, assign) CGFloat lastProcess;

@property (nonatomic, assign) MovewPoint movePoit;

@end

@implementation Lai_CircleLayer

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.lastProcess = 0.5;
        
    }
    return self;
}

-(void)drawInContext:(CGContextRef)ctx
{
    CGFloat offset = self.outRect.size.width / 3.6;
    CGFloat movedDistance = self.outRect.size.width / 6 * fabs(self.process - 0.5) * 2;
    CGPoint rectCenter = CGPointMake(self.outRect.origin.x + self.outRect.size.width / 2,
                                     self.outRect.origin.y + self.outRect.size.height / 2);
    
//    计算各点的值来画约束rect
    CGPoint pointA = CGPointMake(rectCenter.x, self.outRect.origin.y + movedDistance);
    CGPoint pointB = CGPointMake(self.movePoit == POINT_D? rectCenter
                                 .x + self.outRect.size.width / 2 : rectCenter.x +
                                 self.outRect.size.width / 2 + movedDistance * 2, rectCenter.y);
    CGPoint pointC = CGPointMake(rectCenter.x, self.outRect.origin.y + self.outRect.size.height - movedDistance);
    CGPoint pointD = CGPointMake(self.movePoit == POINT_D? self.outRect.origin.x - movedDistance *
                                 2 : self.outRect.origin.x, rectCenter.y);
    
    CGPoint c1 = CGPointMake(pointA.x + offset, pointA.y);
    CGPoint c2 = CGPointMake(pointB.x, self.movePoit == POINT_D? pointB.y - offset : pointB.y -offset
                             + movedDistance);
    CGPoint c3 = CGPointMake(pointB.x, self.movePoit == POINT_D? pointB.y + offset : pointB.y + offset
                             - movedDistance);
    CGPoint c4 = CGPointMake(pointC.x + offset, pointC.y);
    CGPoint c5 = CGPointMake(pointC.x - offset, pointC.y);
    CGPoint c6 = CGPointMake(pointD.x, self.movePoit == POINT_D? pointD.y + offset - movedDistance :
                             pointD.y + offset);
    CGPoint c7 = CGPointMake(pointD.x, self.movePoit == POINT_D? pointD.y - offset + movedDistance :
                             pointD.y - offset);
    CGPoint c8 = CGPointMake(pointA.x - offset, pointA.y);
    

    
//  外接rect
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:self.outRect];
    CGContextAddPath(ctx, rectPath.CGPath);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(ctx, 1.0);
    CGFloat dash[] = {5.0, 5.0};
    CGContextSetLineDash(ctx, 0.0, dash, 2);
    CGContextStrokePath(ctx);
    
    //   画yuan
    UIBezierPath *arcPath = [UIBezierPath bezierPath];
    [arcPath moveToPoint:pointA];
    [arcPath addCurveToPoint:pointB controlPoint1:c1 controlPoint2:c2];
    [arcPath addCurveToPoint:pointC controlPoint1:c3 controlPoint2:c4];
    [arcPath addCurveToPoint:pointD controlPoint1:c5 controlPoint2:c6];
    [arcPath addCurveToPoint:pointA controlPoint1:c7 controlPoint2:c8];
    [arcPath closePath];
    CGContextAddPath(ctx, arcPath.CGPath);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetFillColorWithColor(ctx, [UIColor orangeColor].CGColor);
    CGContextSetLineDash(ctx, 0, NULL, 0);
    CGContextSetLineWidth(ctx, 1.0);
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
//    连接辅助线
    UIBezierPath *helperline = [UIBezierPath bezierPath];
    [helperline moveToPoint:pointA];
    [helperline addLineToPoint:c1];
    [helperline addLineToPoint:c2];
    [helperline addLineToPoint:pointB];
    [helperline addLineToPoint:c3];
    [helperline addLineToPoint:c4];
    [helperline addLineToPoint:pointC];
    [helperline addLineToPoint:c5];
    [helperline addLineToPoint:c6];
    [helperline addLineToPoint:pointD];
    [helperline addLineToPoint:c7];
    [helperline addLineToPoint:c8];
    [helperline closePath];
    
    CGContextAddPath(ctx, helperline.CGPath);
    
    CGFloat dash2[] = {2.0, 2.0};
    CGContextSetLineDash(ctx, 0.0, dash2, 2);
    CGContextStrokePath(ctx); //给辅助线条填充颜色
}

-(void)setProcess:(CGFloat)process
{
    _process = process;
    
    if (process <= 0.5) {
        self.movePoit = POINT_B;
        NSLog(@"B点动");
    } else {
        self.movePoit = POINT_D;
        NSLog(@"D点动");
    }
    
    self.lastProcess = process;
//    self.outRect的frame
    CGFloat origin_x = self.position.x - outRectSize / 2 + (process -0.5) *
    (self.frame.size.width - outRectSize);
    CGFloat origin_y = self.position.y - outRectSize / 2;
    
    self.outRect = CGRectMake(origin_x, origin_y, outRectSize, outRectSize);
    
    [self setNeedsDisplay];
}

@end
