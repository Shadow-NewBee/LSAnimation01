//
//  Lai_CicleView.m
//  LSLearnAni01
//
//  Created by xiaoT on 16/4/2.
//  Copyright © 2016年 赖三聘. All rights reserved.
//

#import "Lai_CicleView.h"

@implementation Lai_CicleView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.circleLayer = [Lai_CircleLayer layer];
        self.circleLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.circleLayer.contentsScale = [UIScreen mainScreen].scale;
        [self.layer addSublayer:self.circleLayer];
    }
    return self;
}

@end
