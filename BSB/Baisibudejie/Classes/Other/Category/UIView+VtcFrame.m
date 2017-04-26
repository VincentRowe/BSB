//
//  UIView+VtcFrame.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/2/22.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "UIView+VtcFrame.h"

@implementation UIView (VtcFrame)

#pragma mark - x
- (CGFloat)vtc_x {
    
    return self.frame.origin.x;
}

- (void)setVtc_x:(CGFloat)vtc_x {
    
    CGRect frame = self.frame;
    frame.origin.x = vtc_x;
    self.frame = frame;
}

#pragma mark - y
- (CGFloat)vtc_y {
    
    return self.frame.origin.y;
}

- (void)setVtc_y:(CGFloat)vtc_y {
    
    CGRect frame = self.frame;
    frame.origin.y = vtc_y;
    self.frame = frame;
}

#pragma mark - centerX
- (CGFloat)vtc_centerX {

    return self.center.x;
}

- (void)setVtc_centerX:(CGFloat)vtc_centerX {

    CGPoint center = self.center;
    center.x = vtc_centerX;
    self.center = center;
}

#pragma mark - centerY
- (CGFloat)vtc_centerY {

    return self.center.y;
}

- (void)setVtc_centerY:(CGFloat)vtc_centerY {

    CGPoint center = self.center;
    center.y = vtc_centerY;
    self.center = center;
}

#pragma mark - width
- (CGFloat)vtc_width {
    
    return self.frame.size.width;
}

- (void)setVtc_width:(CGFloat)vtc_width {
    
    CGRect frame = self.frame;
    frame.size.width = vtc_width;
    self.frame = frame;
}


#pragma mark - height
- (CGFloat)vtc_height {
    
    return self.frame.size.height;
}

- (void)setVtc_height:(CGFloat)vtc_height {
    
    CGRect frame = self.frame;
    frame.size.height = vtc_height;
    self.frame = frame;
}

@end
