//
//  DivideView.m
//  Wealth88
//
//  Created by wjc on 1/16/15.
//  Copyright (c) 2015 wjc. All rights reserved.
//

#import "DivideView.h"

@implementation DivideView

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
    self.backgroundColor = JCColorAlpha(229, 229, 229, 1.0);
    CGRect rect = self.frame;
    rect.size.height = 0.5;
    self.frame = rect;
}

@end
