//
//  UIView+Ex.m
//
//  Created by Romeo on 15/7/31.
//  Copyright (c) 2015年. All rights reserved.
//

#import "UIView+Ex.h"

@implementation UIView (Ex)
//重写getter,返回x值
- (CGFloat)x {
       return self.frame.origin.x;
}
//重写setter,给x重新赋值
- (void)setX:(CGFloat)x {
       CGRect frame = self.frame;
       frame.origin.x = x;
       self.frame = frame;
}

//重写getter,返回y值
- (CGFloat)y {
       return self.frame.origin.y;
}
//重写setter,给y重新赋值
- (void)setY:(CGFloat)y {
       CGRect frame = self.frame;
       frame.origin.y = y;
       self.frame = frame;
}

- (CGFloat)width {
       return self.bounds.size.width;
}

- (void)setWidth:(CGFloat)width {
       CGRect bounds = self.bounds;
       bounds.size.width = width;
       self.bounds = bounds;
}


- (CGFloat)height {
       return self.bounds.size.height;
}

- (void)setHeight:(CGFloat)height {
       CGRect bounds = self.bounds;
       bounds.size.height = height;
       self.bounds = bounds;
}

@end
