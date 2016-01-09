//
//  VerticalDivideView.m
//  Wealth88
//
//  Created by wjc on 15/5/7.
//  Copyright (c) wjc. All rights reserved.
//

#import "VerticalDivideView.h"

@implementation VerticalDivideView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setProperty];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setProperty];
    }
    return self;
}

- (void)setProperty{
    self.backgroundColor = JCColor(229, 229, 229);
    CGRect rect = self.frame;
    rect.size.width = 0.5;
    self.frame = rect;
}

@end
